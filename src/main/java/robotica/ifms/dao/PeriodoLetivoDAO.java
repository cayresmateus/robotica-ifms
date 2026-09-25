package robotica.ifms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import robotica.ifms.config.PostgreSQLConnectionFactory;
import robotica.ifms.model.PeriodoLetivo;

public class PeriodoLetivoDAO {

	private static final String SELECT_ALL = "SELECT id, ano, semestre FROM periodo_letivo ORDER BY ano DESC, semestre DESC";
	private static final String SELECT_BY_ID = "SELECT id, ano, semestre FROM periodo_letivo WHERE id = ?";
	private static final String SELECT_BY_ATIVIDADE = 
		"SELECT p.id, p.ano, p.semestre " +
		"FROM periodo_letivo p " +
		"INNER JOIN atividade_periodo ap ON p.id = ap.periodo_id " +
		"WHERE ap.atividade_id = ? " +
		"ORDER BY p.ano DESC, p.semestre DESC";

	public List<PeriodoLetivo> listarTodos() throws SQLException {
		List<PeriodoLetivo> periodos = new ArrayList<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_ALL);
		     ResultSet resultSet = statement.executeQuery()) {
			while (resultSet.next()) {
				periodos.add(new PeriodoLetivo(
					resultSet.getLong("id"),
					resultSet.getInt("ano"),
					resultSet.getInt("semestre")
				));
			}
		}
		return periodos;
	}

	public PeriodoLetivo buscarPorId(Long id) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_BY_ID)) {
			statement.setLong(1, id);
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					return new PeriodoLetivo(
						resultSet.getLong("id"),
						resultSet.getInt("ano"),
						resultSet.getInt("semestre")
					);
				}
			}
		}
		return null;
	}

	public List<PeriodoLetivo> listarPorAtividade(Long atividadeId) throws SQLException {
		List<PeriodoLetivo> periodos = new ArrayList<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_BY_ATIVIDADE)) {
			statement.setLong(1, atividadeId);
			try (ResultSet resultSet = statement.executeQuery()) {
				while (resultSet.next()) {
					periodos.add(new PeriodoLetivo(
						resultSet.getLong("id"),
						resultSet.getInt("ano"),
						resultSet.getInt("semestre")
					));
				}
			}
		}
		return periodos;
	}
}
