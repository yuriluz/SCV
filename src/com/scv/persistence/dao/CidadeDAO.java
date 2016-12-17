package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Cidade;
import com.scv.javabean.Estado;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CidadeDAO extends BaseDAO{
	
    private static CidadeDAO singleton;
    private static Logger LOGGER = Logger.getLogger(CidadeDAO.class.getName());

    public static CidadeDAO getInstance() {
        if (singleton == null) {
            singleton = new CidadeDAO();
        }
        return singleton;
    }
	
	public List<Cidade> carregarTodas() throws DAOException, ClassNotFoundException {
		
		List<Cidade> cidades = new ArrayList<Cidade>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM cidade_cid ORDER BY cid_nome";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            
            while (res.next()) {
                Cidade cidade = gerarCidade(res);
                cidades.add(cidade);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as cidades";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return cidades;
	}
	
	public List<Cidade> carregarPorEstado(Estado estado) throws DAOException, ClassNotFoundException {
		
		List<Cidade> cidades = new ArrayList<Cidade>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM cidade_cid WHERE cid_codest = ? ORDER BY cid_nome";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1,estado.getCodigo());
            
            res = pstmt.executeQuery();
            
            while (res.next()) {
                Cidade cidade = gerarCidade(res);
                cidades.add(cidade);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava as cidades do estado do " + estado.getNome();
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return cidades;
	}
	
	public Cidade carregarPorCodigo(Integer codigo) throws DAOException, ClassNotFoundException {
		
		Cidade cidade = new Cidade();
		
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM cidade_cid WHERE cid_codcid = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1,codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
                cidade = gerarCidade(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava a cidade (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return cidade;
	}

	private Cidade gerarCidade(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Cidade cidade = new Cidade();
		
		cidade.setCodigo(res.getInt("cid_codcid"));
		cidade.setNome(res.getString("cid_nome"));
		cidade.setEstado(EstadoDAO.getInstance().carregarPorCodigo(res.getInt("cid_codest")));

		return cidade;
	}
	
}
