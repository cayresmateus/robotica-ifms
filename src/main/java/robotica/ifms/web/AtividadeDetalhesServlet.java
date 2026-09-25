package robotica.ifms.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import robotica.ifms.dao.AtividadeDAO;
import robotica.ifms.model.Atividade;

@WebServlet("/atividade-detalhes")
public class AtividadeDetalhesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AtividadeDAO atividadeDAO;

	@Override
	public void init() {
		atividadeDAO = new AtividadeDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String idParam = request.getParameter("id");
		if (idParam == null || idParam.isBlank()) {
			response.sendRedirect(request.getContextPath() + "/atividades");
			return;
		}

		try {
			Long id = Long.parseLong(idParam);
			Atividade atividade = atividadeDAO.buscarPorId(id);
			if (atividade == null) {
				response.sendRedirect(request.getContextPath() + "/atividades");
				return;
			}
			request.setAttribute("atividade", atividade);
			request.getRequestDispatcher("/publica/publica-atividade-detalhes.jsp").forward(request, response);
		} catch (NumberFormatException | SQLException e) {
			throw new ServletException("Erro ao buscar detalhes da atividade", e);
		}
	}
}
