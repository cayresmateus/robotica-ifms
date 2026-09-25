package robotica.ifms.web;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import robotica.ifms.dao.AtividadeDAO;
import robotica.ifms.dao.CoordenadorDAO;
import robotica.ifms.dao.PeriodoLetivoDAO;
import robotica.ifms.model.Atividade;
import robotica.ifms.model.Coordenador;
import robotica.ifms.model.PeriodoLetivo;

@WebServlet("/admin/atividades")
public class AtividadeControle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AtividadeDAO atividadeDAO;
	private CoordenadorDAO coordenadorDAO;
	private PeriodoLetivoDAO periodoLetivoDAO;

	@Override
	public void init() {
		atividadeDAO = new AtividadeDAO();
		coordenadorDAO = new CoordenadorDAO();
		periodoLetivoDAO = new PeriodoLetivoDAO();
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
				listarAtividades(request, response);
				break;
			case "novo":
				novaAtividade(request, response);
				break;
			case "inserir":
				gravarAtividade(request, response);
				break;
			case "apagar":
				apagarAtividade(request, response);
				break;
			default:
				listarAtividades(request, response);
				break;
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	private void listarAtividades(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		List<Atividade> atividades = atividadeDAO.listarTodas();
		request.setAttribute("listaAtividades", atividades);

		String sucesso = request.getParameter("sucesso");
		String excluido = request.getParameter("excluido");
		if ("true".equals(sucesso)) {
			request.setAttribute("mensagemSucesso", "admin.atividades.msg.sucesso");
		}
		if ("true".equals(excluido)) {
			request.setAttribute("mensagemSucesso", "admin.atividades.msg.excluida");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin-listar-atividades.jsp");
		dispatcher.forward(request, response);
	}

	private void novaAtividade(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		List<Coordenador> coordenadores = coordenadorDAO.listarTodos();
		List<PeriodoLetivo> periodos = periodoLetivoDAO.listarTodos();

		request.setAttribute("coordenadores", coordenadores);
		request.setAttribute("periodos", periodos);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin-nova-atividade.jsp");
		dispatcher.forward(request, response);
	}

	private void gravarAtividade(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String titulo = request.getParameter("titulo");
		String tipo = request.getParameter("tipo");
		String descricao = request.getParameter("descricao");
		String dataInicioStr = request.getParameter("dataInicio");
		String dataFimStr = request.getParameter("dataFim");
		String situacao = request.getParameter("situacao");
		String coordenadorIdStr = request.getParameter("coordenadorId");
		String[] periodosParams = request.getParameterValues("periodos");

		if (titulo != null && !titulo.isBlank()) {
			Atividade atividade = new Atividade();
			atividade.setTitulo(titulo.trim());
			atividade.setTipo(tipo != null ? tipo.trim() : "Projeto");
			atividade.setDescricao(descricao != null ? descricao.trim() : "");
			atividade.setSituacao(situacao != null ? situacao.trim() : "Planejada");

			if (dataInicioStr != null && !dataInicioStr.isBlank()) {
				atividade.setDataInicio(parseData(dataInicioStr.trim()));
			}
			if (dataFimStr != null && !dataFimStr.isBlank()) {
				atividade.setDataFim(parseData(dataFimStr.trim()));
			}

			if (coordenadorIdStr != null && !coordenadorIdStr.isBlank()) {
				Coordenador coord = new Coordenador();
				coord.setId(Long.parseLong(coordenadorIdStr));
				atividade.setCoordenador(coord);
			}

			List<Long> periodosIds = new ArrayList<>();
			if (periodosParams != null) {
				for (String pId : periodosParams) {
					if (!pId.isBlank()) {
						periodosIds.add(Long.parseLong(pId.trim()));
					}
				}
			}

			atividadeDAO.salvar(atividade, periodosIds);
		}

		response.sendRedirect(request.getContextPath() + "/admin/atividades?acao=listar&sucesso=true");
	}

	private void apagarAtividade(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String idParam = request.getParameter("id");
		if (idParam != null && !idParam.isBlank()) {
			long id = Long.parseLong(idParam);
			atividadeDAO.excluir(id);
		}
		response.sendRedirect(request.getContextPath() + "/admin/atividades?acao=listar&excluido=true");
	}

	private LocalDate parseData(String dataStr) {
		try {
			if (dataStr.contains("-")) {
				return LocalDate.parse(dataStr);
			} else if (dataStr.contains("/")) {
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
				return LocalDate.parse(dataStr, formatter);
			}
		} catch (Exception e) {
			// fallback para data atual caso formato inválido
			return LocalDate.now();
		}
		return LocalDate.now();
	}
}
