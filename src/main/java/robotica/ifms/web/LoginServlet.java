package robotica.ifms.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String senha = request.getParameter("senha");

		// Simulação de autenticação institucional (ou aceitação de credenciais padrão)
		if (email != null && !email.trim().isEmpty() && senha != null && !senha.trim().isEmpty()) {
			request.getSession().setAttribute("usuarioLogado", email);
			response.sendRedirect(request.getContextPath() + "/admin/atividades?acao=listar");
		} else {
			request.setAttribute("erro", "login.erro.obrigatorio");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}
}
