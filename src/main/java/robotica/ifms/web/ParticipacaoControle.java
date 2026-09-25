package robotica.ifms.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import robotica.ifms.dao.AtividadeDAO;
import robotica.ifms.dao.EstudanteDAO;
import robotica.ifms.dao.ParticipacaoDAO;
import robotica.ifms.model.Atividade;
import robotica.ifms.model.Estudante;
import robotica.ifms.model.Participacao;

@WebServlet("/admin/participacoes")
public class ParticipacaoControle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ParticipacaoDAO participacaoDAO;
	private EstudanteDAO estudanteDAO;
	private AtividadeDAO atividadeDAO;

	@Override
	public void init() {
		participacaoDAO = new ParticipacaoDAO();
		estudanteDAO = new EstudanteDAO();
		atividadeDAO = new AtividadeDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processarRequisicao(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processarRequisicao(request, response);
	}

	private void processarRequisicao(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String acao = request.getParameter("acao");
		if (acao == null || acao.isBlank()) {
			acao = "listar";
		}

		try {
			switch (acao) {
			case "listar":
				listarParticipacoes(request, response);
				break;
			case "novo":
				novaParticipacao(request, response);
				break;
			case "inserir":
				gravarParticipacao(request, response);
				break;
			case "apagar":
				apagarParticipacao(request, response);
				break;
			default:
				listarParticipacoes(request, response);
				break;
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	private void listarParticipacoes(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		List<Participacao> participacoes = participacaoDAO.listarTodas();
		request.setAttribute("listaParticipacoes", participacoes);

		String sucesso = request.getParameter("sucesso");
		String excluido = request.getParameter("excluido");
		if ("true".equals(sucesso)) {
			request.setAttribute("mensagemSucesso", "admin.participacoes.msg.sucesso");
		}
		if ("true".equals(excluido)) {
			request.setAttribute("mensagemSucesso", "admin.participacoes.msg.excluida");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin-listar-participacoes.jsp");
		dispatcher.forward(request, response);
	}

	private void novaParticipacao(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		List<Estudante> estudantes = estudanteDAO.listarTodos();
		List<Atividade> atividades = atividadeDAO.listarTodas();

		request.setAttribute("estudantes", estudantes);
		request.setAttribute("atividades", atividades);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin-nova-participacao.jsp");
		dispatcher.forward(request, response);
	}

	private void gravarParticipacao(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String estudanteIdStr = request.getParameter("estudanteId");
		String atividadeIdStr = request.getParameter("atividadeId");
		String funcao = request.getParameter("funcao");
		String descricaoContribuicao = request.getParameter("descricaoContribuicao");

		if (estudanteIdStr != null && !estudanteIdStr.isBlank() && atividadeIdStr != null && !atividadeIdStr.isBlank()) {
			Estudante est = new Estudante();
			est.setId(Long.parseLong(estudanteIdStr.trim()));

			Atividade ativ = new Atividade();
			ativ.setId(Long.parseLong(atividadeIdStr.trim()));

			Participacao part = new Participacao(
				est,
				ativ,
				funcao != null ? funcao.trim() : "",
				descricaoContribuicao != null ? descricaoContribuicao.trim() : ""
			);
			participacaoDAO.salvar(part);
		}

		response.sendRedirect(request.getContextPath() + "/admin/participacoes?acao=listar&sucesso=true");
	}

	private void apagarParticipacao(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String estudanteIdStr = request.getParameter("estudanteId");
		String atividadeIdStr = request.getParameter("atividadeId");

		if (estudanteIdStr != null && !estudanteIdStr.isBlank() && atividadeIdStr != null && !atividadeIdStr.isBlank()) {
			long estudanteId = Long.parseLong(estudanteIdStr.trim());
			long atividadeId = Long.parseLong(atividadeIdStr.trim());
			participacaoDAO.excluir(estudanteId, atividadeId);
		}

		response.sendRedirect(request.getContextPath() + "/admin/participacoes?acao=listar&excluido=true");
	}
}
