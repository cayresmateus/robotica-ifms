package robotica.ifms.model;

public class PeriodoLetivo {

	private Long id;
	private Integer ano;
	private Integer semestre;

	public PeriodoLetivo() {
	}

	public PeriodoLetivo(Long id, Integer ano, Integer semestre) {
		this.id = id;
		this.ano = ano;
		this.semestre = semestre;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getAno() {
		return ano;
	}

	public void setAno(Integer ano) {
		this.ano = ano;
	}

	public Integer getSemestre() {
		return semestre;
	}

	public void setSemestre(Integer semestre) {
		this.semestre = semestre;
	}
}