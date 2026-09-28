package robotica.ifms.web;

import robotica.ifms.dao.CoordenadorDAO;
import robotica.ifms.model.Coordenador;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CoordenadorDAO coordenadorDAO = new CoordenadorDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String acao = request.getParameter("acao");

		if ("logout".equals(acao)) {
			HttpSession session = request.getSession(false);
			if (session != null) {
				session.invalidate(); // Destrói a sessão
			}
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		// Caso contrário, apenas exibe a tela de login
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String senha = request.getParameter("senha");

		try {
			// Valida as credenciais consultando o PostgreSQL através do DAO
			Coordenador coordenador = coordenadorDAO.fazerLogin(email, senha);

			if (coordenador != null) {
				// Login bem-sucedido: Criação da Sessão HTTP
				HttpSession session = request.getSession();
				session.setAttribute("coordenadorLogado", coordenador);

				// Redireciona para o painel de gestão/atividades administrativas
				response.sendRedirect(request.getContextPath() + "/admin/atividades?acao=listar");
			} else {
				// Credenciais inválidas: Define mensagem de erro e retorna ao login
				request.setAttribute("erro", "E-mail ou senha inválidos.");
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			throw new ServletException("Erro ao realizar consulta de login no banco de dados", e);
		}
	}
}
