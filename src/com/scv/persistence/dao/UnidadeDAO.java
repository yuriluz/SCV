package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Unidade;
import com.scv.javabean.Unidade.Gestao;
import com.scv.javabean.Unidade.TipoUnidade;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UnidadeDAO extends BaseDAO{
	
    private static UnidadeDAO singleton;
    private static Logger LOGGER = Logger.getLogger(UnidadeDAO.class.getName());

    public static UnidadeDAO getInstance() {
        if (singleton == null) {
            singleton = new UnidadeDAO();
        }
        return singleton;
    }
	
	public void inserir(Unidade unidade) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO unidade_uni (uni_nomefant, uni_razao, uni_dtcad, uni_cnes, uni_cnpj,"
	    	    + "uni_telefone, uni_tipo, uni_gestao, uni_logradouro, uni_bairro, uni_codcid,"
	    	    + "uni_codest, uni_cep, uni_codger, uni_status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, unidade.getNomeFantasia());
	        pstmt.setString(2, unidade.getRazaoSocial());
	        pstmt.setDate(3, (java.sql.Date) new Date());
	        pstmt.setString(4, unidade.getCnes());
	        pstmt.setString(5, unidade.getCnpj());
	        pstmt.setString(6, unidade.getTelefone());
	        pstmt.setString(7, unidade.getTipo().getValue());
	        pstmt.setString(8, unidade.getGestao().getValue());
	        pstmt.setString(9, unidade.getLogradouro());
	        pstmt.setString(10, unidade.getBairro());
	        pstmt.setInt(11, unidade.getCidade().getCodigo());
	        pstmt.setInt(12, unidade.getEstado().getCodigo());
	        pstmt.setString(13, unidade.getCep());
	        pstmt.setInt(14, unidade.getGerente().getCodigo());
	        pstmt.setBoolean(15, unidade.getStatus());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria nova unidade";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Unidade unidade) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE unidade_uni SET uni_nomefant=?, uni_razao=?, uni_cnes=?, uni_cnpj=?,"
	    	    + "uni_telefone=?, uni_tipo=?, uni_gestao=?, uni_logradouro=?, uni_bairro=?, uni_codcid=?,"
	    	    + "uni_codest=?, uni_cep=?, uni_codger=?, uni_status=? WHERE uni_coduni=?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, unidade.getNomeFantasia());
	        pstmt.setString(2, unidade.getRazaoSocial());
	        pstmt.setString(3, unidade.getCnes());
	        pstmt.setString(4, unidade.getCnpj());
	        pstmt.setString(5, unidade.getTelefone());
	        pstmt.setString(6, unidade.getTipo().getValue());
	        pstmt.setString(7, unidade.getGestao().getValue());
	        pstmt.setString(8, unidade.getLogradouro());
	        pstmt.setString(9, unidade.getBairro());
	        pstmt.setInt(10, unidade.getCidade().getCodigo());
	        pstmt.setInt(11, unidade.getEstado().getCodigo());
	        pstmt.setString(12, unidade.getCep());
	        pstmt.setInt(13, unidade.getGerente().getCodigo());
	        pstmt.setBoolean(14, unidade.getStatus());
	        pstmt.setInt(15, unidade.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no registro da unidade (" + unidade.getCodigo() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Unidade> carregarTodos() throws DAOException, ClassNotFoundException {
		List<Unidade> unidades = new ArrayList<Unidade>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM unidade_uni ORDER BY uni_coduni";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Unidade unidade = gerarUnidade(res);
                unidades.add(unidade);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as unidades";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return unidades;
	}
	
	public Unidade carregarPorCodigo(Integer codigo) throws DAOException, ClassNotFoundException {
		Unidade unidade = new Unidade();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM unidade_uni WHERE uni_coduni = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	unidade = gerarUnidade(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava a unidade (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return unidade;
	}

	private Unidade gerarUnidade(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Unidade unidade = new Unidade();
		
		unidade.setCodigo(res.getInt("uni_coduni"));
		unidade.setNomeFantasia(res.getString("uni_nomefant"));
		unidade.setRazaoSocial(res.getString("uni_razao"));
		unidade.setCnes(res.getString("uni_cnes"));
		unidade.setCnpj(res.getString("uni_cnpj"));
		unidade.setTelefone(res.getString("uni_telefone"));
		unidade.setTipo(TipoUnidade.getByValue(res.getString("uni_tipo")));
		unidade.setGestao(Gestao.getByValue(res.getString("uni_gestao")));
		unidade.setLogradouro(res.getString("uni_logradouro"));
		unidade.setBairro(res.getString("uni_bairro"));
		unidade.setCidade(CidadeDAO.getInstance().carregarPorCodigo(res.getInt("uni_codcid")));
		unidade.setEstado(EstadoDAO.getInstance().carregarPorCodigo(res.getInt("uni_codest")));
		unidade.setCep(res.getString("uni_cep"));
		unidade.setGerente(GerenteDAO.getInstance().carregarPorCodigo(res.getInt("uni_codger")));
		unidade.setStatus(res.getBoolean("uni_status"));
		
		return unidade;
	}
	
}
