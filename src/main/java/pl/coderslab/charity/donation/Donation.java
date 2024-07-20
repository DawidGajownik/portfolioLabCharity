package pl.coderslab.charity.donation;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;
import pl.coderslab.charity.category.Category;
import pl.coderslab.charity.institution.Institution;
import pl.coderslab.charity.user.User;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@Entity
@ToString

public class Donation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer quantity;

    @ManyToMany
    private List<Category> categories = new ArrayList<>();

    @ManyToOne
    private Institution institution;

    @ManyToOne
    private User user;

    private String street;

    private String phone;

    private String city;

    private String zipCode;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate pickUpDate;

    private boolean pickedUp;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime pickUpClickDateTime;


    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime creationDateTime;

    private LocalTime pickUpTime;

    private String pickUpComment;

    public String generateHtmlSummary() {
        StringBuilder summary = new StringBuilder();
        summary.append("<html>")
                .append("<body>")
                .append("<h2>Podsumowanie</h2>")
                .append("<table>")
                .append("<tr><th>Oddałeś/aś</th><td>").append(quantity).append("worków</td></tr>")
                .append("<tr><th>z kategorii</th><td>").append(categories.stream()
                        .map(Category::getName)
                        .collect(Collectors.joining(", "))).append("</td></tr>")
                .append("<tr><th>dla: </th><td>").append(institution.getName()).append("</td></tr><br><br>")

                .append("<tr><th>Odbiór zaplanowany: </th><td>").append(pickUpDate).append("</td></tr>")
                .append("<tr><th>O godzinie:</th><td>").append(pickUpTime).append("</td></tr>")
                .append("<tr><th>Twoje uwagi</th><td>").append(pickUpComment).append("</td></tr>")
                .append("</table>")
                .append("</body>")
                .append("</html>");
        return summary.toString();
    }
}
