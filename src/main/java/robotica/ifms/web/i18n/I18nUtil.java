package robotica.ifms.web.i18n;

import java.util.Locale;
import java.util.ResourceBundle;

public class I18nUtil {

	public String getMensagem(Locale locale, String chave) {
		if (locale == null) {
			locale = new Locale("pt", "BR");
		}
		try {
			ResourceBundle bundle = ResourceBundle.getBundle("resources.message", locale);
			return bundle.getString(chave);
		} catch (Exception e) {
			return chave;
		}
	}
}
