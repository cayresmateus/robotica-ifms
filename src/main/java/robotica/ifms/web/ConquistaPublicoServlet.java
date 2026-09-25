package robotica.ifms.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import robotica.ifms.dao.ConquistaDAO;
import robotica.ifms.model.Conquista;

@WebServlet("/conquistas")
public class ConquistaPublicoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ConquistaDAO conquistaDAO;

	@Override
	public void init() {
		conquistaDAO = new ConquistaDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Conquista> conquistas = conquistaDAO.listarTodas();
			request.setAttribute("conquistas", conquistas);
			request.getRequestDispatcher("/publica/publica-conquistas.jsp").forward(request, response);
		} catch (SQLException e) {
			throw new ServletException("Erro ao carregar lista de conquistas", e);
		}
	}
}
