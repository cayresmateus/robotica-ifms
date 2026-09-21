package robotica.ifms.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class PostgreSQLConnectionFactory {

	private static final String HOST = env("DB_HOST", "localhost");
	private static final String PORT = env("DB_PORT", "5432");
	private static final String DATABASE = env("DB_NAME", "portal_robotica");
	private static final String USER = env("DB_USER", "postgres");
	private static final String PASSWORD = env("DB_PASSWORD", "postgresql");

	private static final String URL = "jdbc:postgresql://" + HOST + ":" + PORT + "/" + DATABASE;

	static {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException exception) {
			throw new ExceptionInInitializerError(exception);
		}
	}

	private PostgreSQLConnectionFactory() {
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}

	private static String env(String name, String defaultValue) {
		String value = System.getenv(name);
		return (value == null || value.isBlank()) ? defaultValue : value;
	}
}
