package pl.coderslab.charity.utils;

import com.google.cloud.translate.Detection;
import com.google.cloud.translate.Translate;
import com.google.cloud.translate.TranslateOptions;
import com.google.cloud.translate.Translation;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.coderslab.charity.APIConfig;

@Component
@RequiredArgsConstructor
public class GoogleTranslate {

    private final String APIKEY = APIConfig.getApiKey();

    public String translate (String text, String language) {
        Translate translate = TranslateOptions.newBuilder().setApiKey(APIKEY).build().getService();
        Detection detection = translate.detect(text);
        if (language.equals(detection.getLanguage())) {
            return text;
        }
        if (text.isEmpty()){
            return "";
        }
        Translation translation = translate.translate(text, Translate.TranslateOption.sourceLanguage(detection.getLanguage()), Translate.TranslateOption.targetLanguage(language));
        return translation.getTranslatedText();
    }
}
