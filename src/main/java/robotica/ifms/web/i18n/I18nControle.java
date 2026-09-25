package robotica.ifms.web.i18n;

import java.io.IOException;
import java.util.Locale;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.jstl.core.Config;

@WebServlet("/I18nControle")
public class I18nControle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public I18nControle() {
		super();
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String lingua = request.getParameter("lingua");

		if (lingua != null && lingua.contains("_")) {
			String[] tk = new String[2];
			StringTokenizer tokenizer = new StringTokenizer(lingua, "_");
			int i = 0;
			while (tokenizer.hasMoreElements() && i < 2) {
				tk[i] = tokenizer.nextToken();
				i++;
			}
			Locale locale = new Locale(tk[0], tk[1]);
			Config.set(request.getSession(), Config.FMT_LOCALE, locale);
			Config.set(request.getSession(), Config.FMT_FALLBACK_LOCALE, locale);
			request.getSession().setAttribute("currentLocale", lingua);
		}

		String referer = request.getHeader("Referer");
		if (referer != null && !referer.isBlank() && !referer.contains("/I18nControle")) {
			response.sendRedirect(referer);
		} else {
			response.sendRedirect(request.getContextPath() + "/inicio");
		}
	}
}
