package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Estado;
import com.scv.javabean.Pais;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EstadoDAO extends BaseDAO{
	
    private static EstadoDAO singleton;
    private static Logger LOGGER = Logger.getLogger(EstadoDAO.class.getName());

    public static EstadoDAO getInstance() {
        if (singleton == null) {
            singleton = new EstadoDAO();
        }
        return singleton;
    }
	
	public List<Estado> carregarTodos() throws DAOException, ClassNotFoundException {
		
		List<Estado> estados = new ArrayList<Estado>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM estado_est ORDER BY est_nome";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            
            while (res.next()) {
                Estado estado = gerarEstado(res);
                estados.add(estado);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todos os estados";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return estados;
	}
	
	public List<Estado> carregarPorPais(Pais pais) throws DAOException, ClassNotFoundException {
		
		List<Estado> estados = new ArrayList<Estado>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM estado_est WHERE est_codpai = ? ORDER BY est_nome";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, pais.getCodigo());
            
            res = pstmt.executeQuery();
            
            while (res.next()) {
                Estado estado = gerarEstado(res);
                estados.add(estado);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava os estados do " + pais.getNome();
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return estados;
	}
	
	public Estado carregarPorCodigo(Integer codigo) throws DAOException, ClassNotFoundException {
		
		Estado estado = new Estado();
		
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM estado_est WHERE est_codest = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1,codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
                estado = gerarEstado(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o estado (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return estado;
	}

	private Estado gerarEstado(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Estado estado = new Estado();
		
		estado.setCodigo(res.getInt("est_codest"));
		estado.setNome(res.getString("est_nome"));
		estado.setUf(res.getString("est_uf"));
		estado.setPais(PaisDAO.getInstance().carregarPorCodigo(res.getInt("est_codpai")));

		return estado;
	}
	
}
