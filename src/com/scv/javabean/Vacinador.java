package com.scv.javabean;

import java.util.Date;

import com.scv.entities.enums.Sexo;
import com.scv.entities.enums.TipoDocumento;

public class Vacinador {
	
	private Integer codigo;
	private String matricula;
	private String nome;
	private Sexo sexo;
	private String nacionalidade;
	private String naturalidade;
	private String cpf;
	private TipoVacinador tipoVacinador;
	private String crm;
	private String documento;
	private TipoDocumento tipoDocumento;
	private String emissor;
	private Date dataNascimento;
	private String telefone;
	private String email;
	private String logradouro;
	private String complemento;
	private String bairro;
	private Cidade cidade;
	private Estado estado;
	private String cep;
	private Unidade unidade;
	private Boolean status;
	
	public Vacinador() {}

	public Vacinador(String matricula, String nome, Sexo sexo, String nacionalidade, String naturalidade, 
			String cpf, TipoVacinador tipoVacinador, String crm, String documento, TipoDocumento tipoDocumento, 
			String emissor, Date dataNascimento, String telefone, String email, String logradouro, String complemento, 
			String bairro, Cidade cidade, Estado estado, String cep, Unidade unidade, Boolean status) {
		this.matricula = matricula;
		this.nome = nome;
		this.sexo = sexo;
		this.nacionalidade = nacionalidade;
		this.naturalidade = naturalidade;
		this.cpf = cpf;
		this.tipoVacinador = tipoVacinador;
		this.crm = crm;
		this.documento = documento;
		this.tipoDocumento = tipoDocumento;
		this.emissor = emissor;
		this.dataNascimento = dataNascimento;
		this.telefone = telefone;
		this.email = email;
		this.logradouro = logradouro;
		this.complemento = complemento;
		this.bairro = bairro;
		this.cidade = cidade;
		this.estado = estado;
		this.cep = cep;
		this.unidade = unidade;
		this.status = status;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public String getMatricula() {
		return matricula;
	}

	public void setMatricula(String matricula) {
		this.matricula = matricula;
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

	public Unidade getUnidade() {
		return unidade;
	}

	public void setUnidade(Unidade unidade) {
		this.unidade = unidade;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getComplemento() {
		return complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}	
	
    public TipoVacinador getTipoVacinador() {
		return tipoVacinador;
	}

	public void setTipoVacinador(TipoVacinador tipoVacinador) {
		this.tipoVacinador = tipoVacinador;
	}

	public String getCrm() {
		return crm;
	}

	public void setCrm(String crm) {
		this.crm = crm;
	}
	
	//////////////////////////////////////////////////////////////////////////////

	public enum TipoVacinador {
        
        AGENTE_DE_SAUDE(0), ENFERMEIRO(1), MEDICO(2);
        private Integer value;
        
        private TipoVacinador(Integer value) {
            this.value = value;
        }
        
        public Integer getValue() {
            return value;
        }
        
        public static TipoVacinador getByValue(Integer value) {
            for (TipoVacinador tipo : TipoVacinador.values()) {
                if (tipo.getValue() == value) {
                    return tipo;
                }
            }
            return null;
        }
    }
	
}
