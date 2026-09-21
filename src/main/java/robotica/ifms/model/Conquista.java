package robotica.ifms.model;

import java.time.LocalDate;

public class Conquista {

	private Long id;
	private Atividade atividade;
	private String titulo;
	private LocalDate data;
	private String descricao;

	public Conquista() {
	}

	public Conquista(Long id, Atividade atividade, String titulo, LocalDate data, String descricao) {
		this.id = id;
		this.atividade = atividade;
		this.titulo = titulo;
		this.data = data;
		this.descricao = descricao;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Atividade getAtividade() {
		return atividade;
	}

	public void setAtividade(Atividade atividade) {
		this.atividade = atividade;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public LocalDate getData() {
		return data;
	}

	public void setData(LocalDate data) {
		this.data = data;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
}