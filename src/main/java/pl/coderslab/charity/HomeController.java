package pl.coderslab.charity;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.coderslab.charity.category.Category;
import pl.coderslab.charity.donation.Donation;
import pl.coderslab.charity.donation.DonationRepository;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.institution.Institution;
import pl.coderslab.charity.institution.InstitutionRepository;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


@RequiredArgsConstructor
@Controller
public class HomeController {

    private final InstitutionRepository institutionRepository;
    private final DonationRepository donationRepository;
    private final EmailServiceImpl emailService;

    @RequestMapping("/")
    public String homeAction(Model model){
        List <Institution> allInstitutions = new ArrayList<>(institutionRepository.findAll().stream().filter(Institution::isActive).toList());
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
}
