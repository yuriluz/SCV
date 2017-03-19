package com.scv.entities.enums;

public enum TipoDocumento {

	RG(1), PASSAPORTE(2), CNH(3), CTPS(4);
    private Integer value;
    
    private TipoDocumento(Integer value) {
        this.value = value;
    }
    
    public Integer getValue() {
        return value;
    }
    
    public static TipoDocumento getByValue(Integer value) {
        for (TipoDocumento tipoDocumento : TipoDocumento.values()) {
            if (tipoDocumento.getValue().equals(value)) {
                return tipoDocumento;
            }
        }
        return null;
    }
}
