package com.scv.entities.enums;

public enum Sexo {

	MASCULINO("M"), FEMININO("F"), OUTROS("O");
    private String value;
    
    private Sexo(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static Sexo getByValue(String value) {
        for (Sexo sexo : Sexo.values()) {
            if (sexo.getValue().equals(value)) {
                return sexo;
            }
        }
        return null;
    }
}
