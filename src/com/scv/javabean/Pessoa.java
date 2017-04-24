package com.scv.javabean;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import com.scv.entities.enums.Sexo;
import com.scv.entities.enums.TipoDocumento;

public class Pessoa {
	
	private Integer codigo;
	private String nome;
	private Sexo sexo;
	private String nacionalidade;
	private String naturalidade;
	private String cpf;
	private String documento;
	private TipoDocumento tipoDocumento;
	private String emissor;
	private Date dataNascimento;
	private Escolaridade escolaridade;
	private String telefone;
	private String email;
	private String logradouro;
	private String complemento;
	private String bairro;
	private Cidade cidade;
	private Estado estado;
	private String cep;
	private String senha;
	
	public Pessoa() {}

	public Pessoa(String nome, Sexo sexo, String nacionalidade, String naturalidade, String cpf, 
			String documento, TipoDocumento tipoDocumento, String emissor, Date dataNascimento, 
			Escolaridade escolaridade, String telefone, String email, String logradouro, 
			String complemento, String bairro, Cidade cidade, Estado estado, String cep) {
		
		this.nome = nome;
		this.sexo = sexo;
		this.nacionalidade = nacionalidade;
		this.naturalidade = naturalidade;
		this.cpf = cpf;
		this.documento = documento;
		this.tipoDocumento = tipoDocumento;
		this.emissor = emissor;
		this.dataNascimento = dataNascimento;
		this.escolaridade = escolaridade;
		this.telefone = telefone;
		this.email = email;
		this.logradouro = logradouro;
		this.complemento = complemento;
		this.bairro = bairro;
		this.cidade = cidade;
		this.estado = estado;
		this.cep = cep;
		this.senha = "";
	}

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

	public Sexo getSexo() {
		return sexo;
	}

	public void setSexo(Sexo sexo) {
		this.sexo = sexo;
	}

	public String getNacionalidade() {
		return nacionalidade;
	}

	public void setNacionalidade(String nacionalidade) {
		this.nacionalidade = nacionalidade;
	}

	public String getNaturalidade() {
		return naturalidade;
	}

	public void setNaturalidade(String naturalidade) {
		this.naturalidade = naturalidade;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public TipoDocumento getTipoDocumento() {
		return tipoDocumento;
	}

	public void setTipoDocumento(TipoDocumento tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}

	public String getEmissor() {
		return emissor;
	}

	public void setEmissor(String emissor) {
		this.emissor = emissor;
	}

	public Date getDataNascimento() {
		return dataNascimento;
	}

	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}

	public Escolaridade getEscolaridade() {
		return escolaridade;
	}

	public void setEscolaridade(Escolaridade escolaridade) {
		this.escolaridade = escolaridade;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLogradouro() {
		return logradouro;
	}

	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}

	public String getComplemento() {
		return complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
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

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}
	
	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public Integer getIdade() {
		Calendar hoje = Calendar.getInstance();
		Calendar nascimento = new GregorianCalendar();
		nascimento.setTime(dataNascimento);
		
		return hoje.get(Calendar.YEAR) - nascimento.get(Calendar.YEAR);
	}
	
	///////////////////////////////////////////////////////////////
	
	
    public enum Escolaridade {
        
        SEM_ESCOLARIDADE(0), FUNDAMENTAL(1), MEDIO(2), SUPERIOR_INCOMPLETO(3), SUPERIOR_COMPLETO(4);
        private Integer value;
        
        private Escolaridade(Integer value) {
            this.value = value;
        }
        
        public Integer getValue() {
            return value;
        }
        
        public static Escolaridade getByValue(Integer value) {
            for (Escolaridade escolaridade : Escolaridade.values()) {
                if (escolaridade.getValue() == value) {
                    return escolaridade;
                }
            }
            return null;
        }
    }

}
