package com.scv.javabean;

public class Usuario {
	
	private Integer codigo;
	private Integer codUsuario;
	private String email;
	private TipoUsuario tipo;
	
	public Usuario() {}
	
    
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
