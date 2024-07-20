package pl.coderslab.charity.utils;

import java.security.SecureRandom;
import java.util.Random;

public class TokenGenerator {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final Random RANDOM = new SecureRandom();

    public static String generateToken() {

        StringBuilder token = new StringBuilder(30);
        for (int i = 0; i < 30; i++) {
            token.append(CHARACTERS.charAt(RANDOM.nextInt(CHARACTERS.length())));
        }

        return token.toString();
    }
}
