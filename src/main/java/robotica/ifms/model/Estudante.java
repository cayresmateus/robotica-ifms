package robotica.ifms.model;

public class Estudante {

	private Long id;
	private String nome;
	private String minibio;
	private String foto;

	public Estudante() {
	}

	public Estudante(Long id, String nome, String minibio, String foto) {
		this.id = id;
		this.nome = nome;
		this.minibio = minibio;
		this.foto = foto;
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
}