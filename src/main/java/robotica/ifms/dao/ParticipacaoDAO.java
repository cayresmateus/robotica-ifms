package robotica.ifms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import robotica.ifms.config.PostgreSQLConnectionFactory;
import robotica.ifms.model.Atividade;
import robotica.ifms.model.Estudante;
import robotica.ifms.model.Participacao;

public class ParticipacaoDAO {

	private static final String SELECT_ALL = 
		"SELECT p.estudante_id, p.atividade_id, p.funcao, p.descricao_contribuicao, " +
		"e.nome AS estudante_nome, e.foto AS estudante_foto, " +
		"a.titulo AS atividade_titulo, a.tipo AS atividade_tipo " +
		"FROM participacao p " +
		"INNER JOIN estudante e ON p.estudante_id = e.id " +
		"INNER JOIN atividade a ON p.atividade_id = a.id " +
		"ORDER BY a.titulo ASC, e.nome ASC";

	private static final String SELECT_BY_ATIVIDADE = 
		"SELECT p.estudante_id, p.atividade_id, p.funcao, p.descricao_contribuicao, " +
		"e.nome AS estudante_nome, e.foto AS estudante_foto, " +
		"a.titulo AS atividade_titulo, a.tipo AS atividade_tipo " +
		"FROM participacao p " +
		"INNER JOIN estudante e ON p.estudante_id = e.id " +
		"INNER JOIN atividade a ON p.atividade_id = a.id " +
		"WHERE p.atividade_id = ? " +
		"ORDER BY e.nome ASC";

	private static final String INSERT_OR_UPDATE = 
		"INSERT INTO participacao (estudante_id, atividade_id, funcao, descricao_contribuicao) " +
		"VALUES (?, ?, ?, ?) " +
		"ON CONFLICT (estudante_id, atividade_id) " +
		"DO UPDATE SET funcao = EXCLUDED.funcao, descricao_contribuicao = EXCLUDED.descricao_contribuicao";

	private static final String DELETE = 
		"DELETE FROM participacao WHERE estudante_id = ? AND atividade_id = ?";

	private static final String COUNT = "SELECT COUNT(*) FROM participacao";

	public List<Participacao> listarTodas() throws SQLException {
		List<Participacao> lista = new ArrayList<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_ALL);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) {
				Estudante estudante = new Estudante();
				estudante.setId(rs.getLong("estudante_id"));
				estudante.setNome(rs.getString("estudante_nome"));
				estudante.setFoto(rs.getString("estudante_foto"));

				Atividade atividade = new Atividade();
				atividade.setId(rs.getLong("atividade_id"));
				atividade.setTitulo(rs.getString("atividade_titulo"));
				atividade.setTipo(rs.getString("atividade_tipo"));

				Participacao p = new Participacao(
					estudante,
					atividade,
					rs.getString("funcao"),
					rs.getString("descricao_contribuicao")
				);
				lista.add(p);
			}
		}
		return lista;
	}

	public List<Participacao> listarPorAtividade(Long atividadeId) throws SQLException {
		List<Participacao> lista = new ArrayList<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_BY_ATIVIDADE)) {
			statement.setLong(1, atividadeId);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					Estudante estudante = new Estudante();
					estudante.setId(rs.getLong("estudante_id"));
					estudante.setNome(rs.getString("estudante_nome"));
					estudante.setFoto(rs.getString("estudante_foto"));

					Atividade atividade = new Atividade();
					atividade.setId(rs.getLong("atividade_id"));
					atividade.setTitulo(rs.getString("atividade_titulo"));
					atividade.setTipo(rs.getString("atividade_tipo"));

					Participacao p = new Participacao(
						estudante,
						atividade,
						rs.getString("funcao"),
						rs.getString("descricao_contribuicao")
					);
					lista.add(p);
				}
			}
		}
		return lista;
	}

	public void salvar(Participacao participacao) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(INSERT_OR_UPDATE)) {
			statement.setLong(1, participacao.getEstudante().getId());
			statement.setLong(2, participacao.getAtividade().getId());
			statement.setString(3, participacao.getFuncao());
			statement.setString(4, participacao.getDescricaoContribuicao());
			statement.executeUpdate();
		}
	}

	public void excluir(Long estudanteId, Long atividadeId) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(DELETE)) {
			statement.setLong(1, estudanteId);
			statement.setLong(2, atividadeId);
			statement.executeUpdate();
		}
	}

	public long contarParticipacoes() throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(COUNT);
		     ResultSet rs = statement.executeQuery()) {
			if (rs.next()) {
				return rs.getLong(1);
			}
		}
		return 0;
	}
}
