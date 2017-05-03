package com.scv.javabean;

public class Unidade {
	
	private Integer codigo;
	private String nomeFantasia;
	private String razaoSocial;
	private String cnes;
	private String cnpj;
	private String telefone;
	private TipoUnidade tipo;
	private Gestao gestao;
	private String logradouro;
	private String bairro;
	private Cidade cidade;
	private Estado estado;
	private String cep;
	private Usuario usuario;
	private Boolean status;
	
	public Unidade() {}

	public Unidade(String nomeFantasia, String razaoSocial, String cnes, String cnpj, 
			String telefone, TipoUnidade tipo, Gestao gestao, String logradouro, String bairro, 
			Cidade cidade, Estado estado, String cep, Usuario usuario, Boolean status) {
		this.nomeFantasia = nomeFantasia;
		this.razaoSocial = razaoSocial;
		this.cnes = cnes;
		this.cnpj = cnpj;
		this.telefone = telefone;
		this.tipo = tipo;
		this.gestao = gestao;
		this.logradouro = logradouro;
		this.bairro = bairro;
		this.cidade = cidade;
		this.estado = estado;
		this.cep = cep;
		this.usuario = usuario;
		this.status = status;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public String getNomeFantasia() {
		return nomeFantasia;
	}

	public void setNomeFantasia(String nomeFantasia) {
		this.nomeFantasia = nomeFantasia;
	}

	public String getRazaoSocial() {
		return razaoSocial;
	}

	public void setRazaoSocial(String razaoSocial) {
		this.razaoSocial = razaoSocial;
	}

	public String getCnes() {
		return cnes;
	}

	public void setCnes(String cnes) {
		this.cnes = cnes;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public TipoUnidade getTipo() {
		return tipo;
	}

	public void setTipo(TipoUnidade tipo) {
		this.tipo = tipo;
	}

	public Gestao getGestao() {
		return gestao;
	}

	public void setGestao(Gestao gestao) {
		this.gestao = gestao;
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
		
    public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
	
	////////////////////////////////////////////////////////////////////////////

	public enum TipoUnidade {
        
        HOSPITAL("H"), CENTRO_DE_SAUDE("P"), CLINICA("C");
        private String value;
        
        private TipoUnidade(String value) {
            this.value = value;
        }
        
        public String getValue() {
            return value;
        }
        
        public static TipoUnidade getByValue(String value) {
            for (TipoUnidade tipo : TipoUnidade.values()) {
                if (tipo.getValue().equals(value)) {
                    return tipo;
                }
            }
            return null;
        }
    }
    
	////////////////////////////////////////////////////////////////////////////    
    
    public enum Gestao {
        
        PARTICULAR("P"), MUNICIPAL("M"), ESTADUAL("E"), DUPLA("D"), FEDERAL("F"), MILITAR("T");
        private String value;
        
        private Gestao(String value) {
            this.value = value;
        }
        
        public String getValue() {
            return value;
        }
        
        public static Gestao getByValue(String value) {
            for (Gestao gestao : Gestao.values()) {
                if (gestao.getValue().equals(value)) {
                    return gestao;
                }
            }
            return null;
        }
    }

}
