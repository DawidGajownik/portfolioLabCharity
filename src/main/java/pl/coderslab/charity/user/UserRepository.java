package pl.coderslab.charity.user;

import lombok.NonNull;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.validation.constraints.Email;
import java.util.Optional;

public interface UserRepository extends JpaRepository <User, Long> {
    Optional<User> findByEmailOrLogin (@NonNull @Email String email, @NonNull String login);
    Optional<User> findByEmail(String email);
    Optional<User> findByLogin(String login);
    Optional<User> findByToken(String token);
}
