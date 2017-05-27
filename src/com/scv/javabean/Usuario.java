package com.scv.javabean;

public class Usuario {
	
	private Integer codigo;
	private String nome;
	private Integer codUsuario;
	private String email;
	private String senha;
	private TipoUsuario tipo;
	
	public Usuario() {}
	
    public Usuario(String nome, String email, String senha, TipoUsuario tipo) {
		this.nome = nome;
		this.email = email;
		this.senha = senha;
		this.tipo = tipo;
	}

	public Usuario(String nome, Integer codUsuario, String email, String senha, TipoUsuario tipo) {
		this.nome = nome;
		this.codUsuario = codUsuario;
		this.email = email;
		this.senha = senha;
		this.tipo = tipo;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public Integer getCodUsuario() {
		return codUsuario;
	}


	public void setCodUsuario(Integer codUsuario) {
		this.codUsuario = codUsuario;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNome() {
		return nome;
	}


	public void setNome(String nome) {
		this.nome = nome;
	}


	public String getSenha() {
		return senha;
	}


	public void setSenha(String senha) {
		this.senha = senha;
	}


	public TipoUsuario getTipo() {
		return tipo;
	}

	public void setTipo(TipoUsuario tipo) {
		this.tipo = tipo;
	}

	////////////////////////////////////////////////////////////////////////////    

	public enum TipoUsuario {

    	ADMINISTRADOR("1"), GERENTE("2"), VACINADOR("3");
        private String value;
        
        private TipoUsuario(String value) {
            this.value = value;
        }
        
        public String getValue() {
            return value;
        }
        
        public static TipoUsuario getByValue(String value) {
            for (TipoUsuario tipo : TipoUsuario.values()) {
                if (tipo.getValue().equals(value)) {
                    return tipo;
                }
            }
            return null;
        }
    }

}
