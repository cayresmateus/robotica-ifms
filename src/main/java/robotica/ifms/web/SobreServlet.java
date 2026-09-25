package robotica.ifms.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import robotica.ifms.dao.CoordenadorDAO;
import robotica.ifms.model.Coordenador;

@WebServlet("/sobre")
public class SobreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CoordenadorDAO coordenadorDAO;

	@Override
	public void init() {
		coordenadorDAO = new CoordenadorDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Coordenador> coordenadores = coordenadorDAO.listarTodos();
			request.setAttribute("coordenadores", coordenadores);
			request.getRequestDispatcher("/publica/publica-sobre.jsp").forward(request, response);
		} catch (SQLException e) {
			throw new ServletException("Erro ao carregar dados institucionais", e);
		}
	}
}
