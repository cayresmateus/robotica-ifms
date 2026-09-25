package robotica.ifms.dao;

import java.sql.Connection;
import java.sql.Date;
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
import robotica.ifms.model.Coordenador;
import robotica.ifms.model.Estudante;
import robotica.ifms.model.Participacao;
import robotica.ifms.model.PeriodoLetivo;

public class AtividadeDAO {

	private static final String SELECT_BASE = 
		"SELECT a.id, a.titulo, a.tipo, a.descricao, a.data_inicio, a.data_fim, a.situacao, " +
		"c.id AS coord_id, c.nome AS coord_nome, c.minibio AS coord_minibio, c.foto AS coord_foto, " +
		"p.id AS per_id, p.ano AS per_ano, p.semestre AS per_semestre " +
		"FROM atividade a " +
		"LEFT JOIN coordenador c ON a.coordenador_id = c.id " +
		"LEFT JOIN atividade_periodo ap ON a.id = ap.atividade_id " +
		"LEFT JOIN periodo_letivo p ON ap.periodo_id = p.id ";

	private static final String INSERT = 
		"INSERT INTO atividade (titulo, tipo, descricao, data_inicio, data_fim, situacao, coordenador_id) " +
		"VALUES (?, ?, ?, ?, ?, ?, ?)";

	private static final String INSERT_ATIVIDADE_PERIODO = 
		"INSERT INTO atividade_periodo (atividade_id, periodo_id) VALUES (?, ?) ON CONFLICT DO NOTHING";

	private static final String DELETE = "DELETE FROM atividade WHERE id = ?";
	private static final String COUNT = "SELECT COUNT(*) FROM atividade";

	public List<Atividade> listarTodas() throws SQLException {
		String sql = SELECT_BASE + "ORDER BY a.data_inicio DESC, a.id DESC, p.ano DESC, p.semestre DESC";
		return carregarAtividades(sql, null);
	}

	public List<Atividade> listarPorPeriodo(Long periodoId) throws SQLException {
		String sql = SELECT_BASE + 
			"WHERE a.id IN (SELECT ap2.atividade_id FROM atividade_periodo ap2 WHERE ap2.periodo_id = ?) " +
			"ORDER BY a.data_inicio DESC, a.id DESC, p.ano DESC, p.semestre DESC";
		return carregarAtividades(sql, periodoId);
	}

	public List<Atividade> listarDestaques(int limite) throws SQLException {
		List<Atividade> todas = listarTodas();
		if (todas.size() <= limite) {
			return todas;
		}
		return todas.subList(0, limite);
	}

	public Atividade buscarPorId(Long id) throws SQLException {
		String sql = SELECT_BASE + "WHERE a.id = ? ORDER BY p.ano DESC, p.semestre DESC";
		List<Atividade> lista = carregarAtividades(sql, id);
		if (lista.isEmpty()) {
			return null;
		}
		Atividade atividade = lista.get(0);
		carregarParticipantes(atividade);
		return atividade;
	}

	public Atividade salvar(Atividade atividade, List<Long> periodosIds) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection()) {
			connection.setAutoCommit(false);
			try {
				try (PreparedStatement stmt = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS)) {
					stmt.setString(1, atividade.getTitulo());
					stmt.setString(2, atividade.getTipo());
					stmt.setString(3, atividade.getDescricao());
					stmt.setDate(4, atividade.getDataInicio() != null ? Date.valueOf(atividade.getDataInicio()) : null);
					stmt.setDate(5, atividade.getDataFim() != null ? Date.valueOf(atividade.getDataFim()) : null);
					stmt.setString(6, atividade.getSituacao());
					stmt.setLong(7, atividade.getCoordenador() != null ? atividade.getCoordenador().getId() : 1L);
					stmt.executeUpdate();

					try (ResultSet keys = stmt.getGeneratedKeys()) {
						if (keys.next()) {
							atividade.setId(keys.getLong(1));
						}
					}
				}

				if (periodosIds != null && !periodosIds.isEmpty() && atividade.getId() != null) {
					try (PreparedStatement stmtPer = connection.prepareStatement(INSERT_ATIVIDADE_PERIODO)) {
						for (Long perId : periodosIds) {
							stmtPer.setLong(1, atividade.getId());
							stmtPer.setLong(2, perId);
							stmtPer.addBatch();
						}
						stmtPer.executeBatch();
					}
				}

				connection.commit();
			} catch (SQLException e) {
				connection.rollback();
				throw e;
			} finally {
				connection.setAutoCommit(true);
			}
		}
		return atividade;
	}

	public void excluir(Long id) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(DELETE)) {
			statement.setLong(1, id);
			statement.executeUpdate();
		}
	}

	public long contarAtividades() throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(COUNT);
		     ResultSet rs = statement.executeQuery()) {
			if (rs.next()) {
				return rs.getLong(1);
			}
		}
		return 0;
	}

	private List<Atividade> carregarAtividades(String sql, Long parametro) throws SQLException {
		Map<Long, Atividade> mapa = new LinkedHashMap<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(sql)) {
			if (parametro != null) {
				statement.setLong(1, parametro);
			}
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					Long ativId = rs.getLong("id");
					Atividade atividade = mapa.get(ativId);
					if (atividade == null) {
						atividade = new Atividade();
						atividade.setId(ativId);
						atividade.setTitulo(rs.getString("titulo"));
						atividade.setTipo(rs.getString("tipo"));
						atividade.setDescricao(rs.getString("descricao"));
						Date dIni = rs.getDate("data_inicio");
						if (dIni != null) {
							atividade.setDataInicio(dIni.toLocalDate());
						}
						Date dFim = rs.getDate("data_fim");
						if (dFim != null) {
							atividade.setDataFim(dFim.toLocalDate());
						}
						atividade.setSituacao(rs.getString("situacao"));

						long coordId = rs.getLong("coord_id");
						if (!rs.wasNull()) {
							Coordenador c = new Coordenador(
								coordId,
								rs.getString("coord_nome"),
								rs.getString("coord_minibio"),
								rs.getString("coord_foto")
							);
							atividade.setCoordenador(c);
						}
						mapa.put(ativId, atividade);
					}

					long perId = rs.getLong("per_id");
					if (!rs.wasNull()) {
						PeriodoLetivo p = new PeriodoLetivo(
							perId,
							rs.getInt("per_ano"),
							rs.getInt("per_semestre")
						);
						if (!atividade.getPeriodos().contains(p)) {
							atividade.getPeriodos().add(p);
						}
					}
				}
			}
		}
		return new ArrayList<>(mapa.values());
	}

	private void carregarParticipantes(Atividade atividade) throws SQLException {
		String sql = 
			"SELECT p.funcao, p.descricao_contribuicao, " +
			"e.id AS est_id, e.nome AS est_nome, e.minibio AS est_minibio, e.foto AS est_foto " +
			"FROM participacao p " +
			"INNER JOIN estudante e ON p.estudante_id = e.id " +
			"WHERE p.atividade_id = ? " +
			"ORDER BY e.nome ASC";

		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setLong(1, atividade.getId());
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					Estudante e = new Estudante(
						rs.getLong("est_id"),
						rs.getString("est_nome"),
						rs.getString("est_minibio"),
						rs.getString("est_foto")
					);
					Participacao part = new Participacao(
						e,
						atividade,
						rs.getString("funcao"),
						rs.getString("descricao_contribuicao")
					);
					atividade.getParticipacoes().add(part);
				}
			}
		}
	}
}
