package robotica.ifms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import robotica.ifms.config.PostgreSQLConnectionFactory;
import robotica.ifms.model.Coordenador;

public class CoordenadorDAO {

	private static final String SELECT_ALL = "SELECT id, nome, minibio, foto FROM coordenador ORDER BY nome ASC";
	private static final String SELECT_BY_ID = "SELECT id, nome, minibio, foto FROM coordenador WHERE id = ?";

	public List<Coordenador> listarTodos() throws SQLException {
		List<Coordenador> coordenadores = new ArrayList<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_ALL);
		     ResultSet resultSet = statement.executeQuery()) {
			while (resultSet.next()) {
				coordenadores.add(new Coordenador(
					resultSet.getLong("id"),
					resultSet.getString("nome"),
					resultSet.getString("minibio"),
					resultSet.getString("foto")
				));
			}
		}
		return coordenadores;
	}

	public Coordenador buscarPorId(Long id) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_BY_ID)) {
			statement.setLong(1, id);
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					return new Coordenador(
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
}
