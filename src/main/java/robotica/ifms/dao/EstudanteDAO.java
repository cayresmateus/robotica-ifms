package robotica.ifms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import robotica.ifms.config.PostgreSQLConnectionFactory;
import robotica.ifms.model.Atividade;
import robotica.ifms.model.Estudante;
import robotica.ifms.model.Participacao;

public class EstudanteDAO {

	private static final String SELECT_ALL = "SELECT id, nome, minibio, foto FROM estudante ORDER BY nome ASC";
	private static final String SELECT_BY_ID = "SELECT id, nome, minibio, foto FROM estudante WHERE id = ?";
	private static final String INSERT = "INSERT INTO estudante (nome, minibio, foto) VALUES (?, ?, ?)";
	private static final String DELETE = "DELETE FROM estudante WHERE id = ?";
	private static final String COUNT = "SELECT COUNT(*) FROM estudante";

	public List<Estudante> listarTodos() throws SQLException {
		List<Estudante> estudantes = new ArrayList<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_ALL);
		     ResultSet resultSet = statement.executeQuery()) {
			while (resultSet.next()) {
				estudantes.add(new Estudante(
					resultSet.getLong("id"),
					resultSet.getString("nome"),
					resultSet.getString("minibio"),
					resultSet.getString("foto")
				));
			}
		}
		return estudantes;
	}

	public Estudante buscarPorId(Long id) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_BY_ID)) {
			statement.setLong(1, id);
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					return new Estudante(
						resultSet.getLong("id"),
						resultSet.getString("nome"),
						resultSet.getString("minibio"),
						resultSet.getString("foto")
					);
				}
			}
		}
		return null;
	}

	public Estudante salvar(Estudante estudante) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, estudante.getNome());
			statement.setString(2, estudante.getMinibio());
			statement.setString(3, estudante.getFoto());
			statement.executeUpdate();
			try (ResultSet keys = statement.getGeneratedKeys()) {
				if (keys.next()) {
					estudante.setId(keys.getLong(1));
				}
			}
		}
		return estudante;
	}

	public void excluir(Long id) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(DELETE)) {
			statement.setLong(1, id);
			statement.executeUpdate();
		}
	}

	public long contarEstudantes() throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(COUNT);
		     ResultSet rs = statement.executeQuery()) {
			if (rs.next()) {
				return rs.getLong(1);
			}
		}
		return 0;
	}

	public List<Estudante> listarTodosComParticipacoes() throws SQLException {
		String sql = "SELECT e.id AS est_id, e.nome AS est_nome, e.minibio AS est_minibio, e.foto AS est_foto, " +
		             "p.funcao, p.descricao_contribuicao, " +
		             "a.id AS ativ_id, a.titulo AS ativ_titulo, a.tipo AS ativ_tipo, a.situacao AS ativ_situacao " +
		             "FROM estudante e " +
		             "LEFT JOIN participacao p ON e.id = p.estudante_id " +
		             "LEFT JOIN atividade a ON p.atividade_id = a.id " +
		             "ORDER BY e.nome ASC, a.titulo ASC";

		Map<Long, Estudante> mapa = new LinkedHashMap<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(sql);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) {
				Long id = rs.getLong("est_id");
				Estudante estudante = mapa.get(id);
				if (estudante == null) {
					estudante = new Estudante(
						id,
						rs.getString("est_nome"),
						rs.getString("est_minibio"),
						rs.getString("est_foto")
					);
					mapa.put(id, estudante);
				}
				long ativId = rs.getLong("ativ_id");
				if (!rs.wasNull()) {
					Atividade atividade = new Atividade();
					atividade.setId(ativId);
					atividade.setTitulo(rs.getString("ativ_titulo"));
					atividade.setTipo(rs.getString("ativ_tipo"));
					atividade.setSituacao(rs.getString("ativ_situacao"));

					Participacao participacao = new Participacao(
						estudante,
						atividade,
						rs.getString("funcao"),
						rs.getString("descricao_contribuicao")
					);
					estudante.getParticipacoes().add(participacao);
				}
			}
		}
		return new ArrayList<>(mapa.values());
	}
}