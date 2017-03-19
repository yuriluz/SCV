package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Calendario;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CalendarioDAO extends BaseDAO{
	
    private static CalendarioDAO singleton;
    private static Logger LOGGER = Logger.getLogger(CalendarioDAO.class.getName());

    public static CalendarioDAO getInstance() {
        if (singleton == null) {
            singleton = new CalendarioDAO();
        }
        return singleton;
    }
	
	public void inserir(Calendario calendario) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO calendario_cal (cal_ano, cal_imagem "
	    		+ "VALUES(?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, calendario.getAno());
	        pstmt.setString(2, calendario.getImagem());

	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria novo calendário";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Calendario calendario) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE calendario_cal SET cal_ano = ?, cal_imagem = ? WHERE cal_codcal = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, calendario.getAno());
	        pstmt.setString(2, calendario.getImagem());
	        pstmt.setInt(3, calendario.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no calendário (" + calendario.getCodigo() +")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Calendario> carregarTodos() throws DAOException, ClassNotFoundException {
		List<Calendario> calendarios = new ArrayList<Calendario>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from calendario_cal";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Calendario calendario = gerarCalendario(res);
                calendarios.add(calendario);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todos os calendários";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return calendarios;
	}
	
	
	public Calendario carregarPorAno(String ano) throws DAOException, ClassNotFoundException {
		Calendario calendario = new Calendario();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM calendario_cal WHERE cal_codcal = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, ano);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	calendario = gerarCalendario(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o calendario do ano " + ano;
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return calendario;
	}
	
	public Calendario carregarMaisAtual() throws DAOException, ClassNotFoundException {
		Calendario calendario = new Calendario();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT cal_codcal, MAX(cal_ano) cal_ano, cal_imagem FROM dbscv.calendario_cal";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	calendario = gerarCalendario(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o calendario mais atual ";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return calendario;
	}

	private Calendario gerarCalendario(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Calendario calendario = new Calendario();
		
		calendario.setCodigo(res.getInt("cal_codcal"));
		calendario.setAno(res.getString("cal_ano"));
		calendario.setImagem(res.getString("cal_imagem"));

		return calendario;
	}
	
}
