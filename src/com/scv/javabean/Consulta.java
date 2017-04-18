package com.scv.javabean;

import java.util.Date;

public class Consulta {
	
	private Integer codigo;
	private Pessoa pessoa;
	private Unidade unidade;
	private Vacinador vacinador;
	private Campanha campanha;
	private Date dataConsulta;
	
	public Consulta() {}
	
	public Consulta(Pessoa pessoa, Unidade unidade, Vacinador vacinador, Campanha campanha, Date dataConsulta) {
		this.pessoa = pessoa;
		this.unidade = unidade;
		this.vacinador = vacinador;
		this.campanha = campanha;
		this.dataConsulta = dataConsulta;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public Pessoa getPessoa() {
		return pessoa;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}

	public Unidade getUnidade() {
		return unidade;
	}

	public void setUnidade(Unidade unidade) {
		this.unidade = unidade;
	}

	public Vacinador getVacinador() {
		return vacinador;
	}

	public void setVacinador(Vacinador vacinador) {
		this.vacinador = vacinador;
	}

	public Campanha getCampanha() {
		return campanha;
	}

	public void setCampanha(Campanha campanha) {
		this.campanha = campanha;
	}

	public Date getDataConsulta() {
		return dataConsulta;
	}

	public void setDataConsulta(Date dataConsulta) {
		this.dataConsulta = dataConsulta;
	}
	
}
