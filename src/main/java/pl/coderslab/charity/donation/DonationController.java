package pl.coderslab.charity.donation;

import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.HomeController;
import pl.coderslab.charity.category.Category;
import pl.coderslab.charity.category.CategoryRepository;
import pl.coderslab.charity.email.EmailServiceImpl;
import pl.coderslab.charity.institution.Institution;
import pl.coderslab.charity.institution.InstitutionRepository;
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
    private final CategoryRepository categoryRepository;
    private final InstitutionRepository institutionRepository;
    private final UserRepository userRepository;
    private final EmailServiceImpl emailService;
    private final MessageSource messageSource;
    private final GoogleTranslate googleTranslate;

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

        model.addAttribute("currentLocale", lang);
        model.addAttribute("minTime", LocalTime.of(7, 0));
        model.addAttribute("maxTime", LocalTime.of(19, 59));
        model.addAttribute("now", LocalDate.now().plusDays(1));
        model.addAttribute("categories", new ArrayList<>(categoryRepository.findAll().stream().peek(s -> s.setName(googleTranslate.translate(s.getName(), lang))).filter(Category::isActive).toList()));
        model.addAttribute("institutions", new ArrayList<>(institutionRepository.findAll().stream().peek(s->s.setDescription(googleTranslate.translate(s.getDescription(),lang))).filter(Institution::isActive).toList()));
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

        String emailSubject = messageSource.getMessage("email.donation.thankyou.subject", null, locale);
        String emailBody = generateHtmlSummary(donation, locale, request);

        emailService.sendMessage(donation.getUser().getEmail(), emailSubject, emailBody);
        return "form-confirmation";
    }
    public String generateHtmlSummary(Donation donation, Locale locale, HttpServletRequest request) {
        StringBuilder summary = new StringBuilder();
        summary.append("<html>")
                .append("<body>")
                .append("<h2>").append(messageSource.getMessage("summary.title", null, locale)).append("</h2>")
                .append("<table>")
                .append("<tr><th>").append(messageSource.getMessage("summary.giveAway", null, locale)).append("</th><td>")
                .append(donation.getQuantity()).append(" ").append(messageSource.getMessage("summary.bags", null, locale)).append("</td></tr>")
                .append("<tr><th>").append(messageSource.getMessage("summary.categories", null, locale)).append("</th><td>")
                .append(donation.getCategories().stream()
                        .map(Category::getName)
                        .map(s->googleTranslate.translate(s,HomeController.getLanguage(request)))
                        .collect(Collectors.joining(", "))).append("</td></tr>")
                .append("<tr><th>").append(messageSource.getMessage("summary.for", null, locale)).append("</th><td>")
                .append(donation.getInstitution().getName()).append("</td></tr><br><br>")
                .append("<tr><th>").append(messageSource.getMessage("summary.pickUpDate", null, locale)).append("</th><td>")
                .append(donation.getPickUpDate()).append("</td></tr>")
                .append("<tr><th>").append(messageSource.getMessage("summary.pickUpTime", null, locale)).append("</th><td>")
                .append(donation.getPickUpTime()).append("</td></tr>")
                .append("<tr><th>").append(messageSource.getMessage("summary.comments", null, locale)).append("</th><td>")
                .append(donation.getPickUpComment()).append("</td></tr>")
                .append("</table>")
                .append("</body>")
                .append("</html>");
        return summary.toString();
    }
}
