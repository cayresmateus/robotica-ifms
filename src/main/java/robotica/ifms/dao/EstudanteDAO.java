package robotica.ifms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import robotica.ifms.config.PostgreSQLConnectionFactory;
import robotica.ifms.model.Estudante;

public class EstudanteDAO {

	private static final String SELECT_ALL = "SELECT id, nome, minibio, foto FROM estudante ORDER BY nome";
	private static final String INSERT = "INSERT INTO estudante (nome, minibio, foto) VALUES (?, ?, ?)";

	public List<Estudante> listarTodos() throws SQLException {
		List<Estudante> estudantes = new ArrayList<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection(); PreparedStatement statement = connection.prepareStatement(SELECT_ALL); ResultSet resultSet = statement.executeQuery()) {
			while (resultSet.next()) {
				estudantes.add(new Estudante(resultSet.getLong("id"), resultSet.getString("nome"), resultSet.getString("minibio"), resultSet.getString("foto")));
			}
		}
		return estudantes;
	}

	public void salvar(Estudante estudante) throws SQLException {
		try (Connection connection = PostgreSQLConnectionFactory.getConnection(); PreparedStatement statement = connection.prepareStatement(INSERT)) {
			statement.setString(1, estudante.getNome());
			statement.setString(2, estudante.getMinibio());
			statement.setString(3, estudante.getFoto());
			statement.executeUpdate();
		}
	}
}