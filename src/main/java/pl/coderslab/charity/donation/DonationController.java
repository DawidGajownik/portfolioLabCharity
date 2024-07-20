package pl.coderslab.charity.donation;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.category.Category;
import pl.coderslab.charity.category.CategoryRepository;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.institution.Institution;
import pl.coderslab.charity.institution.InstitutionRepository;
import pl.coderslab.charity.user.UserRepository;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;

@Controller
@RequestMapping("/donation")
@RequiredArgsConstructor

public class DonationController {

    private final DonationRepository donationRepository;
    private final CategoryRepository categoryRepository;
    private final InstitutionRepository institutionRepository;
    private final UserRepository userRepository;
    private final EmailServiceImpl emailService;

    @PostMapping("/confirm")
    public String confirmPickUp (@RequestParam Long donationId, HttpSession session) {
        Long loggedUserId = Long.valueOf(session.getAttribute("loggedUserId").toString());
        Donation donation = donationRepository.getById(donationId);
        if (!donation.getUser().getId().equals(loggedUserId)) {
            return "redirect:/login";
        }
        donation.setPickedUp(true);
        donation.setPickUpClickDateTime(LocalDateTime.now());
        donationRepository.save(donation);
        return "redirect:/myDonations";
    }

    @GetMapping
    public String form (Model model) {
        model.addAttribute("minTime", LocalTime.of(7,0));
        model.addAttribute("maxTime", LocalTime.of(19,59));
        model.addAttribute("now", LocalDate.now().plusDays(1));
        model.addAttribute("categories", new ArrayList<>(categoryRepository.findAll().stream().filter(Category::isActive).toList()));
        model.addAttribute("institutions", new ArrayList<>(institutionRepository.findAll().stream().filter(Institution::isActive).toList()));
        model.addAttribute("donation", new Donation());
        return "form";
    }
    @PostMapping
    public String donate (@ModelAttribute Donation donation, HttpSession session) throws MessagingException {
        if (session.getAttribute("loggedUserId")!=null) {
            donation.setUser(userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString())));
        }
        donation.setCreationDateTime(LocalDateTime.now());
        donation.setPickedUp(false);
        donationRepository.save(donation);
        emailService.sendMessage(donation.getUser().getEmail(), "Dziękujemy za datek", donation.generateHtmlSummary());
        return "form-confirmation";
    }
}
