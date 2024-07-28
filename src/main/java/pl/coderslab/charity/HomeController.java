package pl.coderslab.charity;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.coderslab.charity.donation.Donation;
import pl.coderslab.charity.donation.DonationRepository;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.institution.Institution;
import pl.coderslab.charity.institution.InstitutionRepository;
import pl.coderslab.charity.utils.GoogleTranslate;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


@RequiredArgsConstructor
@Controller
public class HomeController {

    private final InstitutionRepository institutionRepository;
    private final DonationRepository donationRepository;
    private final EmailServiceImpl emailService;
    private final GoogleTranslate googleTranslate;

    @GetMapping("/language")
    public String changeLanguage(@RequestParam String lang, @RequestParam String redirectUrl, HttpServletRequest request) {
        request.getSession().setAttribute("org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE", new Locale(lang));
        return "redirect:" + redirectUrl;
    }

    @RequestMapping("/")
    public String homeAction(Model model, HttpServletRequest request){
        List <Institution> allInstitutions = new ArrayList<>(institutionRepository
                .findAll()
                .stream()
                .peek(s-> s.setDescription(googleTranslate.translate(s.getDescription(), getLanguage(request))))
                .peek(s-> s.setName(googleTranslate.translate(s.getName(), getLanguage(request))))
                .filter(Institution::isActive)
                .toList());
        Map<Institution, Institution> allInstitutionsMap = new LinkedHashMap<>();
        while (!allInstitutions.isEmpty()) {
            if (allInstitutions.size()>1){
                allInstitutionsMap.put(allInstitutions.get(0), allInstitutions.get(1));
                allInstitutions.remove(1);
            } else {
                allInstitutionsMap.put(allInstitutions.get(0), new Institution());
            }
            allInstitutions.remove(0);
        }
        model.addAttribute("givenDonations", donationRepository.findAll().size());
        model.addAttribute("givenBags", donationRepository.findAll().stream().mapToInt(Donation::getQuantity).sum());
        model.addAttribute("institutions", allInstitutionsMap);
        return "index";
    }
    @PostMapping("/contact")
    public String contact (@RequestParam String name, @RequestParam String surname, @RequestParam String message){
        String summary = "Wiadomość:\n" +
                "------------------------------\n" +
                "Imię: " + name + "\n" +
                "Nazwisko: " + surname + "\n" +
                "Treść: " + message;
        emailService.sendSimpleMessage("dawidgajownik6@gmail.com", "Prośba o kontakt", summary);
        return "redirect:/";
    }

    public static String getLanguage(HttpServletRequest request) {
        String language;
        if (request.getSession().getAttribute("org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE")!=null){
            language = request.getSession().getAttribute("org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE").toString();
        } else {
            language = "pl";
        }
        return language;
    }
}
