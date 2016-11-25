package com.scv.javabean;

import java.util.Date;

import com.scv.entities.enums.Sexo;

public class Pessoa {
	
	Integer codigo;
	String nome;
	Sexo sexo;
	String nacionalidade;
	String naturalidade;
	String documento;
	Date dataNascimento;
	String telefone;
	String email;
	String logradouro;
	String bairro;
	Cidade cidade;
	Estado estado;
	String cep;
	
	public Pessoa() {}

	public int getCodigo() {
		// TODO Auto-generated method stub
		return 0;
	}

}
