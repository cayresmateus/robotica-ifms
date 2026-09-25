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
import robotica.ifms.dao.ConquistaDAO;
import robotica.ifms.dao.EstudanteDAO;
import robotica.ifms.dao.ParticipacaoDAO;
import robotica.ifms.model.Atividade;
import robotica.ifms.model.Conquista;

@WebServlet({"/inicio", "/home"})
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private EstudanteDAO estudanteDAO;
	private AtividadeDAO atividadeDAO;
	private ParticipacaoDAO participacaoDAO;
	private ConquistaDAO conquistaDAO;

	@Override
	public void init() {
		estudanteDAO = new EstudanteDAO();
		atividadeDAO = new AtividadeDAO();
		participacaoDAO = new ParticipacaoDAO();
		conquistaDAO = new ConquistaDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			long totalEstudantes = estudanteDAO.contarEstudantes();
			long totalAtividades = atividadeDAO.contarAtividades();
			long totalParticipacoes = participacaoDAO.contarParticipacoes();
			long totalConquistas = conquistaDAO.contarConquistas();
			List<Atividade> destaques = atividadeDAO.listarDestaques(3);
			List<Conquista> conquistas = conquistaDAO.listarTodas();

			request.setAttribute("totalEstudantes", totalEstudantes);
			request.setAttribute("totalAtividades", totalAtividades);
			request.setAttribute("totalParticipacoes", totalParticipacoes);
			request.setAttribute("totalConquistas", totalConquistas);
			request.setAttribute("destaques", destaques);
			request.setAttribute("conquistas", conquistas);

			request.getRequestDispatcher("/publica/publica-inicio.jsp").forward(request, response);
		} catch (SQLException e) {
			throw new ServletException("Erro ao carregar dados da página inicial", e);
		}
	}
}