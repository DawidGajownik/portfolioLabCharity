package pl.coderslab.charity.utils;

import com.google.cloud.translate.Detection;
import com.google.cloud.translate.Translate;
import com.google.cloud.translate.TranslateOptions;
import com.google.cloud.translate.Translation;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class GoogleTranslate {

    private final String APIKEY = "AIzaSyBVEnKq5YxoW7wOQRCj_smmVYfgiIpfK0w";

    public String translate (String text, String language) {
        Translate translate = TranslateOptions.newBuilder().setApiKey(APIKEY).build().getService();
        Detection detection = translate.detect(text);
        if (language.equals(detection.getLanguage())) {
            return text;
        }
        Translation translation = translate.translate(text, Translate.TranslateOption.sourceLanguage(detection.getLanguage()), Translate.TranslateOption.targetLanguage(language));
        return translation.getTranslatedText();
    }
}
