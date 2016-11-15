package br.com.scv.javabean;

public class Unidade {
	
	private Integer codigo;
	private String nomeFantasia;
	private String razaoSocial;
	private String cnes;
	private String cnpj;
	private String telefone;
	private String tipo;
	private String gestao;
	private String logradouro;
	private String bairro;
	private Cidade cidade;
	private Estado estado;
	private String cep;
	
	
	public String getNomeFantasia() {
		return this.nomeFantasia;
	}

	public String getRazaoSocial() {
		return this.razaoSocial;
	}

	public String getCNES() {
		return this.cnes;
	}

	public String getCNPJ() {
		return this.cnpj;
	}

	public String getTelefone() {
		return this.telefone;
	}

	public String getTipo() {
		return this.tipo;
	}

	public String getGestao() {
		return this.gestao;
	}

	public String getLogradouro() {
		return this.logradouro;
	}

	public String getBairro() {
		return this.bairro;
	}

	public Cidade getCidade() {
		return this.cidade;
	}

	public Estado getEstado() {
		return this.estado;
	}

	public String getCEP() {
		return this.cep;
	}


}
