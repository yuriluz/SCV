package com.scv.javabean;

import java.util.Calendar;
import java.util.Date;

import com.scv.persistence.dao.RegistroDAO;
import com.scv.persistence.exception.DAOException;

public class Registro {
	
	private Integer codigo;
	private Pessoa pessoa;
	private Vacina vacina;
	private Consulta consulta;
	private Date dataVacina;
	private Date dataValidade;
	private String lote;
	private Integer dose;
	private Boolean verificado;
	private Date dtVerificacao;
	private Vacinador verificador;
	
	public Registro() {}

	public Registro(Pessoa pessoa, Vacina vacina, Consulta consulta, Date dataVacina, String lote, Boolean verificado) {
		this.pessoa = pessoa;
		this.vacina = vacina;
		this.consulta = consulta;
		this.dataVacina = dataVacina;
		if (!vacina.getValidade().equals(null)) {
			Calendar cal = Calendar.getInstance();
			cal.setTime(dataVacina);
			cal.add(Calendar.MONTH, vacina.getValidade());
			this.dataValidade = cal.getTime();
		} else {
			this.dataValidade = null;
		}
		this.lote = lote;
		try {
			this.dose = RegistroDAO.getInstance().carregarNumeroDaUltimaDose(pessoa, vacina) + 1;
		} catch (ClassNotFoundException | DAOException e) {
			this.dose = 1;
			e.printStackTrace();
		}
		this.verificado = verificado;
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

	public Vacina getVacina() {
		return vacina;
	}

	public void setVacina(Vacina vacina) {
		this.vacina = vacina;
	}

	public Consulta getConsulta() {
		return consulta;
	}

	public void setConsulta(Consulta consulta) {
		this.consulta = consulta;
	}

	public Date getDataVacina() {
		return dataVacina;
	}

	public void setDataVacina(Date dataVacina) {
		this.dataVacina = dataVacina;
	}

	public Date getDataValidade() {
		return dataValidade;
	}

	public void setDataValidade(Date dataValidade) {
		this.dataValidade = dataValidade;
	}

	public String getLote() {
		return lote;
	}

	public void setLote(String lote) {
		this.lote = lote;
	}

	public Integer getDose() {
		return dose;
	}

	public void setDose(Integer dose) {
		this.dose = dose;
	}

	public Boolean getVerificado() {
		return verificado;
	}

	public void setVerificado(Boolean verificado) {
		this.verificado = verificado;
	}

	public Date getDtVerificacao() {
		return dtVerificacao;
	}

	public void setDtVerificacao(Date dtVerificacao) {
		this.dtVerificacao = dtVerificacao;
	}

	public Vacinador getVerificador() {
		return verificador;
	}

	public void setVerificador(Vacinador verificador) {
		this.verificador = verificador;
	}
	
}
