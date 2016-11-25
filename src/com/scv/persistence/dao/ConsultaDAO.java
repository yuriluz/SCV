package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Consulta;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ConsultaDAO extends BaseDAO{
	
    private static ConsultaDAO singleton;
    private static Logger LOGGER = Logger.getLogger(ConsultaDAO.class.getName());

    public static ConsultaDAO getInstance() {
        if (singleton == null) {
            singleton = new ConsultaDAO();
        }
        return singleton;
    }
	
	public void inserir(Consulta consulta) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO consulta_con(con_codpes, con_coduni, con_codvac, "
	    		+ "con_codcam, con_dtconsulta) VALUES(?, ?, ?, ?, ?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setInt(1, consulta.getPessoa().getCodigo());
	        pstmt.setInt(2, consulta.getUnidade().getCodigo());
	        pstmt.setInt(3, consulta.getVacinador().getCodigo());
	        pstmt.setInt(4, consulta.getCampanha().getCodigo());
	        pstmt.setDate(5, (Date) consulta.getDataConsulta());

	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria nova consulta";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Consulta consulta) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE consulta_con SET con_codpes = ?, con_coduni = ?, "
	    		+ "con_codvac = ?, con_codcam = ?, con_dtconsulta = ? WHERE con_codcon = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setInt(1, consulta.getPessoa().getCodigo());
	        pstmt.setInt(2, consulta.getUnidade().getCodigo());
	        pstmt.setInt(3, consulta.getVacinador().getCodigo());
	        pstmt.setInt(4, consulta.getCampanha().getCodigo());
	        pstmt.setDate(5, (Date) consulta.getDataConsulta());
	        pstmt.setInt(6, consulta.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no registro da consulta (" + consulta.getCodigo() +")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Consulta> carregarTodos() throws DAOException {
		List<Consulta> consultas = new ArrayList<Consulta>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from consulta_con order by con_codcon";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Consulta consulta = gerarConsulta(res);
                consultas.add(consulta);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as consultas";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return consultas;
	}
	
	public Consulta carregarPorCodigo(Integer codigo) throws DAOException {
		Consulta consulta = new Consulta();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM consulta_con WHERE con_codcon = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	consulta = gerarConsulta(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava a consulta (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return consulta;
	}

	private Consulta gerarConsulta(ResultSet res) throws SQLException, DAOException {
		Consulta consulta = new Consulta();
		
		consulta.setCodigo(res.getInt("con_codcon"));
		consulta.setPessoa(res.getInt("con_codpes"));
		consulta.setUnidade(UnidadeDAO.getInstance().carregarPorCodigo(res.getInt("con_coduni")));
		consulta.setVacinador(VacinadorDAO.getInstance().carregarPorCodigo(res.getInt("con_codvac")));
		consulta.setCampanha(CampanhaDAO.getInstance().carregarPorCodigo(res.getInt("con_codcam")));
		consulta.setDataConsulta((res.getDate("con_dtconsulta")));
		
		return consulta;
	}
	
}
