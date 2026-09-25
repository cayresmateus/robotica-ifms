package robotica.ifms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import robotica.ifms.config.PostgreSQLConnectionFactory;
import robotica.ifms.model.Atividade;
import robotica.ifms.model.Conquista;
import robotica.ifms.model.Coordenador;

public class ConquistaDAO {

	private static final String SELECT_ALL = 
		"SELECT c.id, c.titulo, c.data, c.descricao, " +
		"a.id AS ativ_id, a.titulo AS ativ_titulo, a.tipo AS ativ_tipo, " +
		"coord.id AS coord_id, coord.nome AS coord_nome " +
		"FROM conquista c " +
		"LEFT JOIN atividade a ON c.atividade_id = a.id " +
		"LEFT JOIN coordenador coord ON a.coordenador_id = coord.id " +
		"ORDER BY c.data DESC, c.id DESC";

	private static final String COUNT = "SELECT COUNT(*) FROM conquista";

	public List<Conquista> listarTodas() throws SQLException {
		List<Conquista> conquistas = new ArrayList<>();
		try (Connection connection = PostgreSQLConnectionFactory.getConnection();
		     PreparedStatement statement = connection.prepareStatement(SELECT_ALL);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) {
				Conquista conquista = new Conquista();
				conquista.setId(rs.getLong("id"));
				conquista.setTitulo(rs.getString("titulo"));
				if (rs.getDate("data") != null) {
					conquista.setData(rs.getDate("data").toLocalDate());
				}
				conquista.setDescricao(rs.getString("descricao"));

				long ativId = rs.getLong("ativ_id");
				if (!rs.wasNull()) {
					Atividade atividade = new Atividade();
					atividade.setId(ativId);
					atividade.setTitulo(rs.getString("ativ_titulo"));
					atividade.setTipo(rs.getString("ativ_tipo"));

					long coordId = rs.getLong("coord_id");
					if (!rs.wasNull()) {
						Coordenador coordenador = new Coordenador();
						coordenador.setId(coordId);
						coordenador.setNome(rs.getString("coord_nome"));
						atividade.setCoordenador(coordenador);
					}
					conquista.setAtividade(atividade);
				}
				conquistas.add(conquista);
			}
		}
		return conquistas;
	}

	public long contarConquistas() throws SQLException {
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
