package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.entities.enums.Sexo;
import com.scv.javabean.Gerente;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GerenteDAO extends BaseDAO{
	
    private static GerenteDAO singleton;
    private static Logger LOGGER = Logger.getLogger(GerenteDAO.class.getName());

    public static GerenteDAO getInstance() {
        if (singleton == null) {
            singleton = new GerenteDAO();
        }
        return singleton;
    }
	
	public void inserir(Gerente gerente) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO gerente_ger (ger_matger,ger_nome,ger_dtmat,ger_sexo,"
	    		+ "ger_nacional,ger_natural,ger_doc,ger_dtnasc,ger_telefone,ger_email,"
	    		+ "ger_logradouro,ger_bairro,ger_codcid,ger_codest,ger_cep) "
	    		+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, gerente.getMatricula());
	        pstmt.setString(2, gerente.getNome());
	        pstmt.setDate(3, (java.sql.Date) new Date());
	        pstmt.setString(4, gerente.getSexo().getValue());
	        pstmt.setString(5, gerente.getNacionalidade());
	        pstmt.setString(6, gerente.getNaturalidade());
	        pstmt.setString(7, gerente.getDocumento());
	        pstmt.setDate(8, (java.sql.Date) gerente.getDataNascimento());
	        pstmt.setString(9, gerente.getTelefone());
	        pstmt.setString(10, gerente.getEmail());
	        pstmt.setString(11, gerente.getLogradouro());
	        pstmt.setString(12, gerente.getBairro());
	        pstmt.setInt(13, gerente.getCidade().getCodigo());
	        pstmt.setInt(14, gerente.getEstado().getCodigo());
	        pstmt.setString(15, gerente.getCep());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria novo gerente";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Gerente gerente) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE gerente_ger SET ger_codger = ?, ger_matger = ?, ger_nome = ?, "
	    		+ "ger_sexo = ?, ger_nacional = ?, ger_natural = ?, ger_doc = ?, ger_dtnasc = ?, "
	    		+ "ger_telefone = ?, ger_email = ?, ger_logradouro = ?, ger_bairro = ?, ger_codcid = ?, "
	    		+ "ger_codest = ?, ger_cep = ? WHERE ger_codger = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, gerente.getMatricula());
	        pstmt.setString(2, gerente.getNome());
	        pstmt.setString(3, gerente.getSexo().getValue());
	        pstmt.setString(4, gerente.getNacionalidade());
	        pstmt.setString(5, gerente.getNaturalidade());
	        pstmt.setString(6, gerente.getDocumento());
	        pstmt.setDate(7, (java.sql.Date) gerente.getDataNascimento());
	        pstmt.setString(8, gerente.getTelefone());
	        pstmt.setString(9, gerente.getEmail());
	        pstmt.setString(10, gerente.getLogradouro());
	        pstmt.setString(11, gerente.getBairro());
	        pstmt.setInt(12, gerente.getCidade().getCodigo());
	        pstmt.setInt(13, gerente.getEstado().getCodigo());
	        pstmt.setString(14, gerente.getCep());
	        pstmt.setInt(15, gerente.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no registro do gerente (" + gerente.getCodigo() +")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Gerente> carregarTodos() throws DAOException {
		List<Gerente> gerentes = new ArrayList<Gerente>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from gerente_ger order by ger_codger";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Gerente gerente = gerarGerente(res);
                gerentes.add(gerente);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as unidades";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return gerentes;
	}
	
	public Gerente carregarPorCodigo(Integer codigo) throws DAOException {
		Gerente gerente = new Gerente();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM gerente_ger WHERE ger_codger = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	gerente = gerarGerente(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o gerente (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return gerente;
	}

	private Gerente gerarGerente(ResultSet res) throws SQLException, DAOException {
		Gerente gerente = new Gerente();
		
		gerente.setCodigo(res.getInt("ger_codger"));
		gerente.setMatricula(res.getString("ger_matger"));
		gerente.setNome(res.getString("ger_nome"));
		gerente.setSexo(Sexo.getByValue(res.getString("ger_sexo")));
		gerente.setNacionalidade(res.getString("ger_nacional"));
		gerente.setNaturalidade(res.getString("ger_natural"));
		gerente.setDocumento(res.getString("ger_doc"));
		gerente.setDataNascimento(res.getDate("ger_dtnasc"));
		gerente.setTelefone(res.getString("ger_telefone"));
		gerente.setEmail(res.getString("ger_email"));
		gerente.setLogradouro(res.getString("ger_logradouro"));
		gerente.setBairro(res.getString("ger_bairro"));
		gerente.setCidade(CidadeDAO.getInstance().carregarPorCodigo(res.getInt("ger_codcid")));
		gerente.setEstado(EstadoDAO.getInstance().carregarPorCodigo(res.getInt("ger_codest")));
		gerente.setCep(res.getString("ger_cep"));
		
		return gerente;
	}
	
}
