package pl.coderslab.charity.user;

import lombok.RequiredArgsConstructor;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.category.Category;
import pl.coderslab.charity.category.CategoryRepository;
import pl.coderslab.charity.institution.Institution;
import pl.coderslab.charity.institution.InstitutionRepository;
import pl.coderslab.charity.log.Log;
import pl.coderslab.charity.log.LogRepository;
import pl.coderslab.charity.utils.BCrypt;
import pl.coderslab.charity.utils.RandomPasswordGenerator;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor

public class AdminController {

    private final UserRepository userRepository;
    private final LogRepository logRepository;
    private final CategoryRepository categoryRepository;
    private final InstitutionRepository institutionRepository;

    @GetMapping
    public String adminPanel (HttpSession session) {
        if (session.getAttribute("loggedUserId")==null){
            return "redirect:login";
        }
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        if (userRepository.getById(loggedUserId).getLevel()<1) {
            return "redirect:/";
        }
        session.setAttribute("admin", userRepository.getById(loggedUserId).getLevel());
        return "admin";
    }
    @GetMapping ("/manage/users")
    public String manageUsers (HttpSession session, Model model) {
        if (session.getAttribute("loggedUserId")==null){
            return "redirect:login";
        }
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        if (userRepository.getById(loggedUserId).getLevel()<1) {
            return "redirect:/";
        }
        session.setAttribute("admin", userRepository.getById(loggedUserId).getLevel());
        model.addAttribute("users", userRepository.findAll().stream().filter(s -> !Objects.equals(s.getId(), loggedUserId)).toList());
        return "users";
    }
    @GetMapping ("/manage/category/add")
    public String addCategory (Model model, HttpSession session) {
        if (session.getAttribute("loggedUserId")==null){
            return "redirect:login";
        }
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        if (userRepository.getById(loggedUserId).getLevel()<1) {
            return "redirect:/";
        }
        model.addAttribute("category", new Category());
        return "add-category";
    }
    @PostMapping("/manage/category/add")
    public String addCategoryPost (@ModelAttribute Category category, Model model, HttpSession session) {

        boolean valid = true;
        Pattern pattern = Pattern.compile("^[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ ]{5,30}$");
        Matcher matcher = pattern.matcher(category.getName());
        if (!matcher.matches()) {
            model.addAttribute("wrongName", "Nazwa może zawierać tylko litery i spację oraz mieć od 5 do 30 znaków.");
            category.setName("");
            valid = false;
        } else {
            if (categoryRepository.findByName(category.getName()).isPresent()){
                model.addAttribute("wrongName", "Kategoria już istnieje.");
                category.setName("");
                valid = false;
            }
        }
        if (!valid) {
            return "add-category";
        }
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(category.getName());
        log.setLocalDateTime(LocalDateTime.now());
        if (category.getId()==null){
            log.setLog("Category added");
        } else {
            log.setLog("Category " +categoryRepository.getById(category.getId()).getName()+ " updated");
        }
        logRepository.save(log);
        category.setActive(true);
        categoryRepository.save(category);
        return "redirect:/admin/manage/categories";
    }
    @PostMapping("/manage/institution/add")
    public String addInstitutionPost (@ModelAttribute Institution institution, Model model, HttpSession session) {
        boolean valid = true;
        Pattern pattern = Pattern.compile("^[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ ]{5,30}$");
        Pattern descriptionPattern = Pattern.compile("^[a-zA-Ząćęł.,ńóśźżĄĆĘŁŃÓŚŹŻ ]{5,500}$");
        Matcher matcher = pattern.matcher(institution.getName());
        Matcher descriptionMatcher = descriptionPattern.matcher(institution.getDescription());
        if (!matcher.matches()) {
            model.addAttribute("wrongName", "Nazwa może zawierać tylko litery i spację oraz mieć od 5 do 30 znaków.");
            institution.setName("");
            valid = false;
        } else {
            if (categoryRepository.findByName(institution.getName()).isPresent()){
                model.addAttribute("wrongName", "Instytucja już istnieje.");
                institution.setName("");
                valid = false;
            }
        }
        if (!descriptionMatcher.matches()) {
            model.addAttribute("wrongName", "Opis może zawierać tylko litery, spację, przecinek i kropkę oraz mieć od 5 do 500 znaków.");
            institution.setDescription("");
            valid = false;
        }
        if (!valid) {
            return "add-institution";
        }
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(institution.getName());
        log.setLocalDateTime(LocalDateTime.now());
        if (institution.getId()==null){
            log.setLog("Institution added");
        } else {
            log.setLog("Institution: " + institutionRepository.getById(institution.getId()).getName() + ":\"" + institutionRepository.getById(institution.getId()).getDescription() + "\" updated to: " + institution.getName() + ":\"" + institution.getDescription() + "\"");
        }
        logRepository.save(log);
        institution.setActive(true);
        institutionRepository.save(institution);
        return "redirect:/admin/manage/institutions";
    }
    @GetMapping ("/manage/institution/add")
    public String addInstitution (Model model, HttpSession session) {
        if (session.getAttribute("loggedUserId")==null){
            return "redirect:login";
        }
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        if (userRepository.getById(loggedUserId).getLevel()<1) {
            return "redirect:/";
        }
        model.addAttribute("institution", new Institution());
        return "add-institution";
    }
    @GetMapping ("/manage/categories")
    public String manageCategories (HttpSession session, Model model) {
        if (session.getAttribute("loggedUserId")==null){
            return "redirect:login";
        }
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        if (userRepository.getById(loggedUserId).getLevel()<1) {
            return "redirect:/";
        }
        session.setAttribute("admin", userRepository.getById(loggedUserId).getLevel());
        model.addAttribute("categories", categoryRepository.findAll());
        return "categories";
    }
    @GetMapping ("/manage/institutions")
    public String manageInstitutions (HttpSession session, Model model) {
        if (session.getAttribute("loggedUserId")==null){
            return "redirect:login";
        }
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        if (userRepository.getById(loggedUserId).getLevel()<1) {
            return "redirect:/";
        }
        session.setAttribute("admin", userRepository.getById(loggedUserId).getLevel());
        model.addAttribute("institutions", institutionRepository.findAll());
        return "institutions";
    }
    @PostMapping ("/manage/changePassword")
    public String changePassword (@RequestParam Long userId, Model model, HttpSession session) {
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        User user = userRepository.getById(userId);
        String newPassword = RandomPasswordGenerator.generatePassword();
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(user.getEmail());
        log.setLocalDateTime(LocalDateTime.now());
        log.setLog("Password changed to: " + newPassword);
        logRepository.save(log);
        user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
        userRepository.save(user);
        return "redirect:/admin/manage/users";
    }
    @PostMapping ("/manage/deleteuser")
    public String deleteUser (@RequestParam Long userId, Model model, HttpSession session) {
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        User user = userRepository.getById(userId);
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(user.getEmail());
        log.setLocalDateTime(LocalDateTime.now());
        log.setLog("Account deleted");
        logRepository.save(log);
        userRepository.delete(user);
        return "redirect:/admin/manage/users";
    }
    @PostMapping ("/manage/deletecategory")
    public String deleteCategory (@RequestParam Long categoryId, Model model, HttpSession session) {
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        Category category = categoryRepository.getById(categoryId);
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(category.getName());
        log.setLocalDateTime(LocalDateTime.now());
        try {
            categoryRepository.delete(category);
            log.setLog("Category deleted");
            logRepository.save(log);
        } catch (DataIntegrityViolationException | ConstraintViolationException e) {
            log.setLog("Category can't be deleted");
        }
        return "redirect:/admin/manage/categories";
    }
    @PostMapping ("/manage/deleteinstitution")
    public String deleteInstitution (@RequestParam Long institutionId, Model model, HttpSession session) {
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        Institution institution = institutionRepository.getById(institutionId);
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(institution.getName());
        log.setLocalDateTime(LocalDateTime.now());
        try {
            institutionRepository.delete(institution);
            log.setLog("Institution deleted");
            logRepository.save(log);
        } catch (DataIntegrityViolationException | ConstraintViolationException e) {
            log.setLog("Institution can't be deleted");
        }
        logRepository.save(log);
        return "redirect:/admin/manage/institutions";
    }
    @PostMapping ("/manage/toggleAdmin")
    public String toggleAdmin (@RequestParam Long userId, Model model, HttpSession session) {
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        User user = userRepository.getById(userId);
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(user.getEmail());
        log.setLocalDateTime(LocalDateTime.now());
        if (user.getLevel()==0){
            user.setLevel(1);
            log.setLog("Admin given");
        } else {
            user.setLevel(0);
            log.setLog("Admin taken");
        }
        logRepository.save(log);
        userRepository.save(user);
        return "redirect:/admin/manage/users";
    }
    @PostMapping ("/manage/blockuser")
    public String blockUser (@RequestParam Long userId, Model model, HttpSession session) {
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        User user = userRepository.getById(userId);
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(user.getEmail());
        log.setLocalDateTime(LocalDateTime.now());
        if (user.isActive()){
            user.setActive(false);
            log.setLog("User blocked");
        } else {
            user.setActive(true);
            log.setLog("User unblocked");
        }
        logRepository.save(log);
        userRepository.save(user);
        return "redirect:/admin/manage/users";
    }
    @PostMapping ("/manage/blockinstitution")
    public String blockInstitution (@RequestParam Long institutionId, Model model, HttpSession session) {
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        Institution institution = institutionRepository.getById(institutionId);
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(institution.getName());
        log.setLocalDateTime(LocalDateTime.now());
        if (institution.isActive()){
            institution.setActive(false);
            log.setLog("Insitution deactivated");
        } else {
            institution.setActive(true);
            log.setLog("Institution activated");
        }
        logRepository.save(log);
        institutionRepository.save(institution);
        return "redirect:/admin/manage/institutions";
    }
    @PostMapping ("/manage/blockcategory")
    public String blockCategory (@RequestParam Long categoryId, Model model, HttpSession session) {
        User admin = userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString()));
        Category category = categoryRepository.getById(categoryId);
        Log log = new Log();
        log.setAdmin(admin.getEmail());
        log.setObject(category.getName());
        log.setLocalDateTime(LocalDateTime.now());
        if (category.isActive()){
            category.setActive(false);
            log.setLog("Category deactivated");
        } else {
            category.setActive(true);
            log.setLog("Category activated");
        }
        logRepository.save(log);
        categoryRepository.save(category);
        return "redirect:/admin/manage/categories";
    }
    @GetMapping ("/logs")
    public String logs (Model model) {
        model.addAttribute("logs", logRepository.findAll());
        return "logs";
    }
    @GetMapping ("/manage/institution/edit/{id}")
    public String editInstitution (Model model, HttpSession session, @PathVariable Long id) {
        if (session.getAttribute("loggedUserId")==null){
            return "redirect:login";
        }
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        if (userRepository.getById(loggedUserId).getLevel()<1) {
            return "redirect:/";
        }
        model.addAttribute("institution", institutionRepository.getById(id));
        return "add-institution";
    }
    @GetMapping ("/manage/category/edit/{id}")
    public String editCategory (Model model, HttpSession session, @PathVariable Long id) {
        if (session.getAttribute("loggedUserId")==null){
            return "redirect:login";
        }
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        if (userRepository.getById(loggedUserId).getLevel()<1) {
            return "redirect:/";
        }
        model.addAttribute("category", categoryRepository.getById(id));
        return "add-category";
    }
}
