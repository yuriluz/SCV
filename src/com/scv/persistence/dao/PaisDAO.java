package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Pais;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PaisDAO extends BaseDAO{
	
    private static PaisDAO singleton;
    private static Logger LOGGER = Logger.getLogger(PaisDAO.class.getName());

    public static PaisDAO getInstance() {
        if (singleton == null) {
            singleton = new PaisDAO();
        }
        return singleton;
    }
	
	public List<Pais> carregarTodos() throws DAOException {
		
		List<Pais> paises = new ArrayList<Pais>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM pais_pai ORDER BY pai_nome";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            
            while (res.next()) {
                Pais pais = gerarPais(res);
                paises.add(pais);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todos os países";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return paises;
	}
	
	public Pais carregarPorCodigo(Integer codigo) throws DAOException {
		
		Pais pais = new Pais();
		
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM pais_pai WHERE pai_codpai = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	pais = gerarPais(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o país (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return pais;
	}

	private Pais gerarPais(ResultSet res) throws SQLException {
		Pais pais = new Pais();
		
		pais.setCodigo(res.getInt("pai_codpai"));
		pais.setNome(res.getString("pai_nome"));
		pais.setSigla(res.getString("pai_sigla"));

		return pais;
	}
	
}
