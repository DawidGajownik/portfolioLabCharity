package pl.coderslab.charity.utils;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class RandomPasswordGenerator {

    private static final String LOWERCASE = "abcdefghijklmnopqrstuvwxyz";
    private static final String UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL_CHARACTERS = "@$!%*?&";
    private static final String ALL_CHARACTERS = LOWERCASE + UPPERCASE + DIGITS + SPECIAL_CHARACTERS;

    private static final SecureRandom RANDOM = new SecureRandom();

    public static String generatePassword() {
        StringBuilder password = new StringBuilder();
        List<Character> passwordChars = new ArrayList<>();

        // Dodaj przynajmniej jeden znak z każdej wymaganej kategorii
        passwordChars.add(LOWERCASE.charAt(RANDOM.nextInt(LOWERCASE.length())));
        passwordChars.add(UPPERCASE.charAt(RANDOM.nextInt(UPPERCASE.length())));
        passwordChars.add(DIGITS.charAt(RANDOM.nextInt(DIGITS.length())));
        passwordChars.add(SPECIAL_CHARACTERS.charAt(RANDOM.nextInt(SPECIAL_CHARACTERS.length())));

        // Uzupełnij pozostałe znaki, aby hasło miało długość od 8 do 20 znaków
        int remainingLength = 8 + RANDOM.nextInt(13) - passwordChars.size();
        for (int i = 0; i < remainingLength; i++) {
            passwordChars.add(ALL_CHARACTERS.charAt(RANDOM.nextInt(ALL_CHARACTERS.length())));
        }

        // Przetasuj znaki, aby nie było przewidywalnych wzorców
        Collections.shuffle(passwordChars);

        // Zbuduj wynikowe hasło
        for (char c : passwordChars) {
            password.append(c);
        }

        return password.toString();
    }
}