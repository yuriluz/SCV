package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Vacina;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VacinaDAO extends BaseDAO{
	
    private static VacinaDAO singleton;
    private static Logger LOGGER = Logger.getLogger(VacinaDAO.class.getName());

    public static VacinaDAO getInstance() {
        if (singleton == null) {
            singleton = new VacinaDAO();
        }
        return singleton;
    }
	
	public void inserir(Vacina vacina) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO vacina_vcn (vcn_nome, vcn_descricao, vcn_nodoses, "
	    		+ "vcn_idademin, vcn_idademax, vcn_validade, vcn_obrigatoria) "
	    		+ "VALUES(?,?,?,?,?,?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, vacina.getNome());
	        pstmt.setString(2, vacina.getDescricao());
	        pstmt.setInt(3, vacina.getNumeroDoses());
	        pstmt.setInt(4, vacina.getIdadeMin());
	        pstmt.setInt(5, vacina.getIdadeMax());
	        pstmt.setInt(6, vacina.getValidade());
	        pstmt.setBoolean(7, vacina.getObrigatoria());

	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria nova vacina";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Vacina vacina) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE vacina_vcn SET vcn_nome = ?, vcn_descricao = ?, "
	    		+ "vcn_nodoses = ?, vcn_idademin = ?, vcn_idademax = ?, vcn_validade = ?, vcn_obrigatoria = ? "
	    		+ "WHERE vcn_codvcn = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, vacina.getNome());
	        pstmt.setString(2, vacina.getDescricao());
	        pstmt.setInt(3, vacina.getNumeroDoses());
	        pstmt.setInt(4, vacina.getIdadeMin());
	        pstmt.setInt(5, vacina.getIdadeMax());
	        pstmt.setInt(6, vacina.getValidade());
	        pstmt.setBoolean(7, vacina.getObrigatoria());
	        pstmt.setInt(8, vacina.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no registro da vacina (" + vacina.getCodigo() +")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Vacina> carregarTodos() throws DAOException {
		List<Vacina> vacinas = new ArrayList<Vacina>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from vacina_vcn order by vcn_codvcn";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Vacina vacina = gerarVacina(res);
                vacinas.add(vacina);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as vacinas";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return vacinas;
	}
	
	public Vacina carregarPorCodigo(Integer codigo) throws DAOException {
		Vacina vacina = new Vacina();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM vacina_vcn WHERE vcn_codvcn = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	vacina = gerarVacina(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava a vacina (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return vacina;
	}

	private Vacina gerarVacina(ResultSet res) throws SQLException, DAOException {
		Vacina vacina = new Vacina();
		
		vacina.setCodigo(res.getInt("vcn_codvcn"));
		vacina.setNome(res.getString("vcn_nome"));
		vacina.setDescricao(res.getString("vcn_descricao"));
		vacina.setNumeroDoses(res.getInt("vcn_nodoses"));
		vacina.setIdadeMin(res.getInt("vcn_idademin"));
		vacina.setIdadeMax(res.getInt("vcn_idademax"));
		vacina.setValidade(res.getInt("vcn_validade"));
		vacina.setObrigatoria(res.getBoolean("vcn_obrigatoria"));
		
		return vacina;
	}
	
}
