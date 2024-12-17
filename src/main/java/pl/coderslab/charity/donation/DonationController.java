package pl.coderslab.charity.donation;

import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.HomeController;
import pl.coderslab.charity.category.Category;
import pl.coderslab.charity.category.CategoryRepository;
import pl.coderslab.charity.category.CategoryService;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.institution.Institution;
import pl.coderslab.charity.institution.InstitutionRepository;
import pl.coderslab.charity.institution.InstitutionService;
import pl.coderslab.charity.user.UserRepository;
import pl.coderslab.charity.utils.GoogleTranslate;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Locale;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/donation")
@RequiredArgsConstructor
public class DonationController {

    private final DonationRepository donationRepository;
    private final UserRepository userRepository;
    private final EmailServiceImpl emailService;
    private final MessageSource messageSource;
    private final DonationService donationService;
    private final InstitutionService institutionService;
    private final CategoryService categoryService;

    @PostMapping("/confirm")
    public String confirmPickUp(@RequestParam Long donationId, HttpSession session) {
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
    public String form(Model model, HttpServletRequest request) {
        String lang = HomeController.getLanguage(request);
        model.addAttribute("currentLocale", lang);
        model.addAttribute("minTime", LocalTime.of(7, 0));
        model.addAttribute("maxTime", LocalTime.of(19, 59));
        model.addAttribute("now", LocalDate.now().plusDays(1));
        model.addAttribute("categories", categoryService.findAll(request));
        model.addAttribute("institutions", institutionService.findAll(request));
        model.addAttribute("donation", new Donation());
        return "form";
    }

    @PostMapping
    public String donate(@ModelAttribute Donation donation, HttpSession session, Locale locale, HttpServletRequest request) throws MessagingException {
        if (session.getAttribute("loggedUserId") != null) {
            donation.setUser(userRepository.getById(Long.valueOf(session.getAttribute("loggedUserId").toString())));
        }
        donation.setCreationDateTime(LocalDateTime.now());
        donation.setPickedUp(false);
        donationRepository.save(donation);

        if (session.getAttribute("loggedUserId") != null) {
            String emailSubject = messageSource.getMessage("email.donation.thankyou.subject", null, locale);
            String emailBody = donationService.generateHtmlSummary(donation, locale, request);
            emailService.sendMessage(donation.getUser().getEmail(), emailSubject, emailBody);
        }
        return "form-confirmation";
    }
}
