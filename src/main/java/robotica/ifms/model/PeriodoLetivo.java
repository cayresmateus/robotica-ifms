package robotica.ifms.model;

import java.util.Objects;

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

	public String getRotulo() {
		if (ano == null || semestre == null) {
			return "";
		}
		return ano + "/" + semestre;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		PeriodoLetivo that = (PeriodoLetivo) o;
		return Objects.equals(id, that.id);
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public String toString() {
		return getRotulo();
	}
}