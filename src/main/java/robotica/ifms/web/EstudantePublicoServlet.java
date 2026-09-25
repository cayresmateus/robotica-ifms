package robotica.ifms.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import robotica.ifms.dao.EstudanteDAO;
import robotica.ifms.model.Estudante;

@WebServlet("/estudantes")
public class EstudantePublicoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private EstudanteDAO estudanteDAO;

	@Override
	public void init() {
		estudanteDAO = new EstudanteDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Estudante> estudantes = estudanteDAO.listarTodosComParticipacoes();
			request.setAttribute("estudantes", estudantes);
			request.getRequestDispatcher("/publica/publica-estudantes.jsp").forward(request, response);
		} catch (SQLException e) {
			throw new ServletException("Erro ao carregar lista de estudantes", e);
		}
	}
}
