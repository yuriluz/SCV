package com.scv.javabean;

public class Vacina {
	
	private Integer codigo;
	private String nome;
	private String descricao;
	private String sexo;
	private Integer numeroDoses;
	private Double idadeMin;
	private Double idadeMax;
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

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public Integer getNumeroDoses() {
		return numeroDoses;
	}

	public void setNumeroDoses(Integer numeroDoses) {
		this.numeroDoses = numeroDoses;
	}

	public Double getIdadeMin() {
		return idadeMin;
	}

	public void setIdadeMin(Double idadeMin) {
		this.idadeMin = idadeMin;
	}

	public Double getIdadeMax() {
		return idadeMax;
	}

	public void setIdadeMax(Double idadeMax) {
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
