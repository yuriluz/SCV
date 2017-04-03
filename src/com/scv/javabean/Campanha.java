package com.scv.javabean;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class Campanha {
	
	private Integer codigo;
	private String nome;
	private String descricao;
	private Date dataInicio;
	private Date dataFim;
	private Vacina vacina;
	private Cidade cidade;
	private Estado estado;
	
	public Campanha() {}

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

	public Date getDataInicio() {
		return dataInicio;
	}

	public void setDataInicio(Date dataInicio) {
		this.dataInicio = dataInicio;
	}

	public Date getDataFim() {
		return dataFim;
	}

	public void setDataFim(Date dataFim) {
		this.dataFim = dataFim;
	}

	public Vacina getVacina() {
		return vacina;
	}

	public void setVacina(Vacina vacina) {
		this.vacina = vacina;
	}

	public Cidade getCidade() {
		return cidade;
	}

	public void setCidade(Cidade cidade) {
		this.cidade = cidade;
	}

	public Estado getEstado() {
		return estado;
	}

	public void setEstado(Estado estado) {
		this.estado = estado;
	}
	
	public boolean isUpToDate(Pessoa pessoa, List<Registro> registros) {
				
		if (registros.isEmpty()) {
			return false;
		} else if (pessoa.getIdade() < this.getVacina().getIdadeMin() 
				||  pessoa.getIdade() > this.getVacina().getIdadeMax()) {
			return true;
		} else {			
			for (Registro registro: registros) {
				 if (registro.getVacina().equals(this.getVacina())) {
					if (this.getVacina().getNumeroDoses() <= registro.getDose()) {
						return true;
					} else if (this.getVacina().getNumeroDoses() > registro.getDose() && registro.getDataValidade().after((Calendar.getInstance().getTime()))) {
						return true;
					} else if (this.getVacina().getNumeroDoses() == null && registro.getDataValidade().before((Calendar.getInstance().getTime()))) {
						return false;
					} else if (this.getVacina().getNumeroDoses() == null && registro.getDataValidade().after((Calendar.getInstance().getTime()))) {
						return true;
					}				
				} 
				
			}
			
		}
		
		return false;
		
	}

}
