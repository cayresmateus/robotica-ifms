package robotica.ifms.model;

import java.time.LocalDate;

public class Atividade {

	private Long id;
	private String titulo;
	private String tipo;
	private String descricao;
	private LocalDate dataInicio;
	private LocalDate dataFim;
	private String situacao;
	private Coordenador coordenador;

	public Atividade() {
	}

	public Atividade(Long id, String titulo, String tipo, String descricao, LocalDate dataInicio, LocalDate dataFim, String situacao, Coordenador coordenador) {
		this.id = id;
		this.titulo = titulo;
		this.tipo = tipo;
		this.descricao = descricao;
		this.dataInicio = dataInicio;
		this.dataFim = dataFim;
		this.situacao = situacao;
		this.coordenador = coordenador;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public LocalDate getDataInicio() {
		return dataInicio;
	}

	public void setDataInicio(LocalDate dataInicio) {
		this.dataInicio = dataInicio;
	}

	public LocalDate getDataFim() {
		return dataFim;
	}

	public void setDataFim(LocalDate dataFim) {
		this.dataFim = dataFim;
	}

	public String getSituacao() {
		return situacao;
	}

	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}

	public Coordenador getCoordenador() {
		return coordenador;
	}

	public void setCoordenador(Coordenador coordenador) {
		this.coordenador = coordenador;
	}
}