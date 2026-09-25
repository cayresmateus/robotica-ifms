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

import robotica.ifms.dao.EstudanteDAO;
import robotica.ifms.model.Estudante;

@WebServlet("/admin/estudantes")
public class EstudanteControle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private EstudanteDAO estudanteDAO;

	@Override
	public void init() {
		estudanteDAO = new EstudanteDAO();
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
				listarEstudantes(request, response);
				break;
			case "novo":
				novoEstudante(request, response);
				break;
			case "inserir":
				gravarEstudante(request, response);
				break;
			case "apagar":
				apagarEstudante(request, response);
				break;
			default:
				listarEstudantes(request, response);
				break;
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	private void listarEstudantes(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		List<Estudante> estudantes = estudanteDAO.listarTodos();
		request.setAttribute("listaEstudantes", estudantes);

		String sucesso = request.getParameter("sucesso");
		String excluido = request.getParameter("excluido");
		if ("true".equals(sucesso)) {
			request.setAttribute("mensagemSucesso", "admin.estudantes.msg.sucesso");
		}
		if ("true".equals(excluido)) {
			request.setAttribute("mensagemSucesso", "admin.estudantes.msg.excluido");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin-listar-estudantes.jsp");
		dispatcher.forward(request, response);
	}

	private void novoEstudante(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin-novo-estudante.jsp");
		dispatcher.forward(request, response);
	}

	private void gravarEstudante(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String nome = request.getParameter("nome");
		String minibio = request.getParameter("minibio");
		String foto = request.getParameter("foto");

		if (nome != null && !nome.isBlank()) {
			Estudante estudante = new Estudante();
			estudante.setNome(nome.trim());
			estudante.setMinibio(minibio != null ? minibio.trim() : null);
			estudante.setFoto(foto != null ? foto.trim() : null);
			estudanteDAO.salvar(estudante);
		}

		response.sendRedirect(request.getContextPath() + "/admin/estudantes?acao=listar&sucesso=true");
	}

	private void apagarEstudante(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String idParam = request.getParameter("id");
		if (idParam != null && !idParam.isBlank()) {
			long id = Long.parseLong(idParam);
			estudanteDAO.excluir(id);
		}
		response.sendRedirect(request.getContextPath() + "/admin/estudantes?acao=listar&excluido=true");
	}
}
