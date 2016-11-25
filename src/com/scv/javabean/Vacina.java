package com.scv.javabean;

public class Vacina {
	
	private Integer codigo;
	private String nome;
	private String descricao;
	private Integer numeroDoses;
	private Integer idadeMin;
	private Integer idadeMax;
	private Integer validade;
	private Boolean obrigatoria;
	
	public Vacina() {}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Integer getNumeroDoses() {
		return numeroDoses;
	}

	public void setNumeroDoses(Integer numeroDoses) {
		this.numeroDoses = numeroDoses;
	}

	public Integer getIdadeMin() {
		return idadeMin;
	}

	public void setIdadeMin(Integer idadeMin) {
		this.idadeMin = idadeMin;
	}

	public Integer getIdadeMax() {
		return idadeMax;
	}

	public void setIdadeMax(Integer idadeMax) {
		this.idadeMax = idadeMax;
	}

	public Integer getValidade() {
		return validade;
	}

	public void setValidade(Integer validade) {
		this.validade = validade;
	}

	public Boolean getObrigatoria() {
		return obrigatoria;
	}

	public void setObrigatoria(Boolean obrigatoria) {
		this.obrigatoria = obrigatoria;
	}

}
