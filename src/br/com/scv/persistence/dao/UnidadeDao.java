package br.com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.Date;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import br.com.scv.javabean.Unidade;
import br.com.scv.persistence.ConnectionFactory;

public class UnidadeDao {

	private Connection connection;
	
	public UnidadeDao() {
		this.connection = new ConnectionFactory().getConnection();
		
	}
	
	public void inserir(Unidade unidade) {
	    String query = "INSERT INTO unidade_uni (uni_nomefant,uni_razao,uni_dtcad,uni_cnes,uni_cnpj,"
	    	    + "uni_telefone,uni_tipo,uni_gestao,uni_logradouro,uni_bairro,uni_codcid,"
	    	    + "uni_codest,uni_cep,uni_codger) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";	    
	    
	    try {
	        PreparedStatement stmt = (PreparedStatement) connection.prepareStatement(query);

	        stmt.setString(1,unidade.getNomeFantasia());
	        stmt.setString(2,unidade.getRazaoSocial());
	        stmt.setDate(3,(java.sql.Date) new Date());
	        stmt.setString(4,unidade.getCNES());
	        stmt.setString(5,unidade.getCNPJ());
	        stmt.setString(6,unidade.getTelefone());
	        stmt.setString(7,unidade.getTipo());
	        stmt.setString(8,unidade.getGestao());
	        stmt.setString(9,unidade.getLogradouro());
	        stmt.setString(10,unidade.getBairro());
	        stmt.setInt(11,unidade.getCidade().getCodigo());
	        stmt.setInt(12,unidade.getEstado().getCodigo());
	        stmt.setString(13,unidade.getCEP());
	        stmt.setString(13, null);
	        
	        stmt.execute();
	        stmt.close();
	    } catch (SQLException e) {
	        throw new RuntimeException(e);
	    }
	}
	
}
