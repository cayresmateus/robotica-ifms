package robotica.ifms.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import robotica.ifms.dao.AtividadeDAO;
import robotica.ifms.dao.PeriodoLetivoDAO;
import robotica.ifms.model.Atividade;
import robotica.ifms.model.PeriodoLetivo;

@WebServlet("/atividades")
public class AtividadePublicoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AtividadeDAO atividadeDAO;
	private PeriodoLetivoDAO periodoLetivoDAO;

	@Override
	public void init() {
		atividadeDAO = new AtividadeDAO();
		periodoLetivoDAO = new PeriodoLetivoDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<PeriodoLetivo> periodos = periodoLetivoDAO.listarTodos();
			request.setAttribute("periodos", periodos);

			String periodoParam = request.getParameter("periodoId");
			String tipoParam = request.getParameter("tipo");

			List<Atividade> atividades;
			if (periodoParam != null && !periodoParam.isBlank()) {
				try {
					Long periodoId = Long.parseLong(periodoParam);
					atividades = atividadeDAO.listarPorPeriodo(periodoId);
					request.setAttribute("filtroPeriodoId", periodoId);
				} catch (NumberFormatException e) {
					atividades = atividadeDAO.listarTodas();
				}
			} else {
				atividades = atividadeDAO.listarTodas();
			}

			if (tipoParam != null && !tipoParam.isBlank()) {
				request.setAttribute("filtroTipo", tipoParam);
				atividades = atividades.stream()
					.filter(a -> a.getTipo() != null && a.getTipo().equalsIgnoreCase(tipoParam))
					.collect(java.util.stream.Collectors.toList());
			}

			request.setAttribute("atividades", atividades);
			request.getRequestDispatcher("/publica/publica-atividades.jsp").forward(request, response);
		} catch (SQLException e) {
			throw new ServletException("Erro ao carregar lista de atividades", e);
		}
	}
}
