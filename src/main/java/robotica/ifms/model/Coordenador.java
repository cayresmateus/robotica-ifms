package robotica.ifms.model;

public class Coordenador {

	private Long id;
	private String nome;
	private String minibio;
	private String foto;
	private String email;
	private String senha;

	public Coordenador() {
	}

	public Coordenador(Long id, String nome, String minibio, String foto, String email, String senha) {
		this.id = id;
		this.nome = nome;
		this.minibio = minibio;
		this.foto = foto;
		this.email = email;
		this.senha = senha;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getMinibio() {
		return minibio;
	}

	public void setMinibio(String minibio) {
		this.minibio = minibio;
	}

	public String getFoto() {
		return foto;
	}

	public void setFoto(String foto) {
		this.foto = foto;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}