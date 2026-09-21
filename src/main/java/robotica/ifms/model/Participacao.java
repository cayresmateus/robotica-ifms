package robotica.ifms.model;

public class Participacao {

	private Estudante estudante;
	private Atividade atividade;
	private String funcao;
	private String descricaoContribuicao;

	public Participacao() {
	}

	public Participacao(Estudante estudante, Atividade atividade, String funcao, String descricaoContribuicao) {
		this.estudante = estudante;
		this.atividade = atividade;
		this.funcao = funcao;
		this.descricaoContribuicao = descricaoContribuicao;
	}

	public Estudante getEstudante() {
		return estudante;
	}

	public void setEstudante(Estudante estudante) {
		this.estudante = estudante;
	}

	public Atividade getAtividade() {
		return atividade;
	}

	public void setAtividade(Atividade atividade) {
		this.atividade = atividade;
	}

	public String getFuncao() {
		return funcao;
	}

	public void setFuncao(String funcao) {
		this.funcao = funcao;
	}

	public String getDescricaoContribuicao() {
		return descricaoContribuicao;
	}

	public void setDescricaoContribuicao(String descricaoContribuicao) {
		this.descricaoContribuicao = descricaoContribuicao;
	}
}