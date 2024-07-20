package pl.coderslab.charity.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pl.coderslab.charity.donation.Donation;
import pl.coderslab.charity.donation.DonationRepository;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.utils.BCrypt;
import pl.coderslab.charity.utils.RandomPasswordGenerator;
import pl.coderslab.charity.utils.TokenGenerator;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor

public class UserController {

    private final UserRepository userRepository;
    private final DonationRepository donationRepository;
    private final EmailServiceImpl emailService;

    @GetMapping("/register")
    public String register(Model model){
        model.addAttribute("user", new User());
        return "register";
    }
    @PostMapping("/register")
    public String processRegistration(@ModelAttribute User user, @RequestParam String confirmPassword, @RequestParam(required = false) String oldPassword,
                                      @RequestParam(required = false) String newPassword, HttpSession session, Model model) throws MessagingException {

        Long loggedUserId = null;
        String oldHashedPassword = null;
        if (session.getAttribute("loggedUserId")!=null){
            loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
            oldHashedPassword = userRepository.getById(loggedUserId).getPassword();
        }

        //regex maila
        Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
        Matcher emailMatcher = emailPattern.matcher(user.getEmail());
        boolean formIsValid = true;
        if(!emailMatcher.matches()) {
            model.addAttribute("emailError", "Podaj poprawny adres e-mail");
            user.setEmail("");
            formIsValid = false;
        } else if (loggedUserId==null){

            //czy mail istnieje w bazie?
            if (userRepository.findByEmail(user.getEmail()).isPresent()){
                model.addAttribute("emailError", "Użytkownik o podanym adresie email istnieje w bazie.");
                user.setEmail("");
                formIsValid = false;
            }
        }


        //regex loginu
        Pattern loginPattern = Pattern.compile("^[a-zA-Z0-9_-]{3,20}$");
        Matcher loginMatcher = loginPattern.matcher(user.getLogin());
        if (!loginMatcher.matches()) {
            model.addAttribute("loginError", "Login musi składać się z od 3 do 20 znaków i może zawierać tylko litery, cyfry, podkreślenia i myślniki");
            user.setLogin("");
            formIsValid = false;
        } else if (loggedUserId==null){

            //czy login istnieje w bazie?
            if (userRepository.findByLogin(user.getLogin()).isPresent()){
                model.addAttribute("loginError", "Użytkownik " + user.getLogin() + " istnieje w bazie.");
                user.setLogin("");
                formIsValid = false;
            }
        }

        //sprawdzanie czy hasła się zgadzają
        if (loggedUserId==null) {
            if (!user.getPassword().equals(confirmPassword)){
                model.addAttribute("passwordsAreDifferent", "Hasła się nie zgadzają");
                formIsValid = false;
            }
        } else {
            if (!newPassword.equals(confirmPassword)){
                model.addAttribute("passwordsAreDifferent", "Hasła się nie zgadzają");
                formIsValid = false;
            }
        }

        //sprawdzenie czy stare hasło się zgadza z tym bazie w razie edycji konta użytkownika
        if (loggedUserId!=null) {
             if(!BCrypt.checkpw(oldPassword, oldHashedPassword)){
                model.addAttribute("oldPasswordError", "Błędne hasło");
                model.addAttribute("user", user);
                formIsValid = false;
            } else {
                user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
            }
        }


        //sprawdzanie mocy hasła
        Pattern passwordPattern = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%.*?&])[A-Za-z\\d@$!%.*?&]{8,20}$");
        Matcher passwordMatcher = null;
        if (loggedUserId==null){
            passwordMatcher = passwordPattern.matcher(user.getPassword());
        } else {
            passwordMatcher = passwordPattern.matcher(newPassword);
        }
        if (!passwordMatcher.matches()) {
            model.addAttribute("passwordError", "Hasło musi zawierać conajmniej jedną małą literę, jedną wielką literę, jedną cyfrę, jeden znak specjalny oraz musi się składać z od 8 do 20 znaków.");
            formIsValid = false;
        }


        if (!formIsValid){
            user.setPassword("");
            model.addAttribute("user", user);
            return "register";
        }
        user.setLevel(0);
        if (loggedUserId==null) {
            user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        }else {
            user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
        }
        user.setToken(TokenGenerator.generateToken());
        user.setActive(true);
        emailService.sendMessage(user.getEmail(), "Potwierdź konto", "<a href=\"http://localhost:8080/emailconfirmation/"+user.getToken()+"\">Potwierdź</a>");
        userRepository.save(user);
        return "redirect:/";
    }

    @RequestMapping("/remind")
    public String remindPassword (Model model) {
        model.addAttribute("user", new User());
        return "remind";
    }

    @RequestMapping("/remind/{token}")
    public String setNewPassword (@PathVariable String token, RedirectAttributes redirectAttributes){
        Optional <User> userOptional = userRepository.findByToken(token);
        if (userOptional.isEmpty()){
            return "redirect:/";
        }
        User user = userOptional.get();
        redirectAttributes.addFlashAttribute("user", user);
        return "redirect:/setNewPassword";
    }

    @GetMapping("/setNewPassword")
    public String setNewPassword (@ModelAttribute User user, Model model){
        model.addAttribute("user", user);
        if (user.getId()==null) {
            return "redirect:/";
        }
        return "new-password";
    }

    @PostMapping("/setNewPassword")
    public String setNewPassword (@ModelAttribute User user, @RequestParam String confirmPassword, Model model) {
        boolean formIsValid = true;
        if (!user.getPassword().equals(confirmPassword)){
            model.addAttribute("passwordsAreDifferent", "Hasła się nie zgadzają");
            formIsValid = false;
        }
        Pattern passwordPattern = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%.*?&])[A-Za-z\\d@$!%.*?&]{8,20}$");
        Matcher passwordMatcher = passwordPattern.matcher(user.getPassword());

        if (!passwordMatcher.matches()) {
            model.addAttribute("passwordError", "Hasło musi zawierać conajmniej jedną małą literę, jedną wielką literę, jedną cyfrę, jeden znak specjalny oraz musi się składać z od 8 do 20 znaków.");
            formIsValid = false;
        }

        if (!formIsValid){
            user.setPassword("");
            model.addAttribute("user", user);
            return "new-password";
        }
        user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        user.setToken("");
        userRepository.save(user);
        return "redirect:/login";
    }

    @PostMapping("/remind")
    public String remind (@ModelAttribute User userTemp, Model model) throws MessagingException {
        var userOptional = userRepository.findByEmail(userTemp.getEmail());
        if(userOptional.isEmpty()){
            model.addAttribute("wrongUser", "Nie znaleziono użytkownika o podanym emailu");
            model.addAttribute("user", new User());
            return "remind";
        }
        User user = userOptional.get();
        user.setToken(TokenGenerator.generateToken());
        emailService.sendMessage(user.getEmail(), "Przypomnij hasło", "<a href=\"http://localhost:8080/remind/"+user.getToken()+"\">Zresetuj hasło</a>");
        userRepository.save(user);
        return "redirect:/";
    }

    @RequestMapping("emailconfirmation/{token}")
    public String emailConfirmation (@PathVariable String token) {
        Optional <User> userOptional = userRepository.findByToken(token);
        if (userOptional.isEmpty()){
            return "redirect:/";
        }
        User user = userOptional.get();
        user.setConfirmed(true);
        user.setToken("");
        userRepository.save(user);
        return "redirect:/login";
    }
    @GetMapping("/login")
    public String login(Model model){
        model.addAttribute("user", new User());
        return "login";
    }
    @PostMapping("/login")
    public String processlogin(@ModelAttribute User user, Model model, HttpSession session){
        var loginOrEmail = user.getLogin();
        var typedPassword = user.getPassword();
        var userOptional = userRepository.findByEmailOrLogin(loginOrEmail, loginOrEmail);
        if(userOptional.isEmpty()){
            model.addAttribute("wrongUser", "Nie znaleziono użytkownika "+ loginOrEmail);
            model.addAttribute("user", new User());
            return "login";
        }
        User userFromDb = userOptional.get();
        if (!userFromDb.isActive()) {
            model.addAttribute("block", "Twoje konto jest zablokowane");
            model.addAttribute("user", new User());
            return "login";
        }
        if (!userFromDb.isConfirmed()) {
            model.addAttribute("block", "Kliknij w link potwierdzający wysłany na Twojego maila.");
            model.addAttribute("user", new User());
            return "login";
        }
        if (!BCrypt.checkpw(typedPassword, userFromDb.getPassword())){
            User user1 = new User();
            user1.setEmail(loginOrEmail);
            model.addAttribute("wrongPassword", "Błędne hasło");
            model.addAttribute("user", user1);
            return "login";
        }
        session.setAttribute("admin", userFromDb.getLevel());
        session.setAttribute("loggedUserId", userFromDb.getId());
        session.setAttribute("loggedUserLogin", userFromDb.getLogin());
        if (userFromDb.getLevel()>0){
            return "redirect:/admin";
        }
        return "redirect:/myProfile";
    }
    @GetMapping("/myProfile")
    public String myProfile(Model model, HttpSession session) {
        if (session.getAttribute("loggedUserId")==null) {
            return "redirect:/login";
        }
        Long id = Long.valueOf(session.getAttribute("loggedUserId").toString());
        model.addAttribute("user", userRepository.getById(id));
        model.addAttribute("edit", true);
        return "register";
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("loggedUserId");
        session.removeAttribute("loggedUserLogin");
        session.removeAttribute("passwordsAreDifferent");
        return "redirect:/";
    }
    @GetMapping("/myDonations")
    public String myDonations(Model model, HttpSession session) {
        if (session.getAttribute("loggedUserId")==null) {
            return "redirect:/login";
        }
        Long id = Long.valueOf(session.getAttribute("loggedUserId").toString());
        model.addAttribute("donations", donationRepository.findAllByUserId(id)
                .stream()
                .sorted(Comparator.comparing(Donation::getCreationDateTime))
                .sorted(Comparator.comparing(Donation::getPickUpDate))
                .sorted(Comparator.comparing(Donation::isPickedUp).reversed())
                .toList());
        return "my-donations";
    }
}
