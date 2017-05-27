package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.entities.enums.Sexo;
import com.scv.entities.enums.TipoDocumento;
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
	
	public void inserir(Gerente gerente) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO gerente_ger (ger_matger, ger_nome, ger_dtmat, ger_sexo,"
	    		+ "ger_nacional, ger_natural, ger_cpf, ger_documento, ger_tipodoc, ger_emissordoc, ger_dtnasc, ger_telefone, ger_email,"
	    		+ "ger_logradouro, ger_complemento, ger_bairro, ger_codcid, ger_codest, ger_cep, ger_coduni, ger_status) "
	    		+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, gerente.getMatricula());
	        pstmt.setString(2, gerente.getNome());
	        pstmt.setDate(3, new java.sql.Date(new Date().getTime()));
	        pstmt.setString(4, gerente.getSexo().getValue());
	        pstmt.setString(5, gerente.getNacionalidade());
	        pstmt.setString(6, gerente.getNaturalidade());
	        pstmt.setString(7, gerente.getCpf());
	        pstmt.setString(8, gerente.getDocumento());
	        pstmt.setInt(9, gerente.getTipoDocumento().getValue());
	        pstmt.setString(10, gerente.getEmissor());
	        pstmt.setDate(11, new java.sql.Date(gerente.getDataNascimento().getTime()));
	        pstmt.setString(12, gerente.getTelefone());
	        pstmt.setString(13, gerente.getEmail());
	        pstmt.setString(14, gerente.getLogradouro());
	        pstmt.setString(15, gerente.getComplemento());
	        pstmt.setString(16, gerente.getBairro());
	        pstmt.setInt(17, gerente.getCidade().getCodigo());
	        pstmt.setInt(18, gerente.getEstado().getCodigo());
	        pstmt.setString(19, gerente.getCep());
	        pstmt.setInt(20, gerente.getUnidade().getCodigo());
	        pstmt.setBoolean(21, gerente.getStatus().booleanValue());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria novo gerente";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Gerente gerente) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE gerente_ger SET ger_matger = ?, ger_nome = ?, "
	    		+ "ger_sexo = ?, ger_nacional = ?, ger_natural = ?, ger_cpf = ?, ger_documento = ?, ger_tipodoc = ?, ger_emissordoc = ?, ger_dtnasc = ?, "
	    		+ "ger_telefone = ?, ger_email = ?, ger_logradouro = ?, ger_complemento = ?, ger_bairro = ?, ger_codcid = ?, "
	    		+ "ger_codest = ?, ger_cep = ?, ger_coduni = ?, ger_status = ? WHERE ger_codger = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, gerente.getMatricula());
	        pstmt.setString(2, gerente.getNome());
	        pstmt.setString(3, gerente.getSexo().getValue());
	        pstmt.setString(4, gerente.getNacionalidade());
	        pstmt.setString(5, gerente.getNaturalidade());
	        pstmt.setString(6, gerente.getCpf());
	        pstmt.setString(7, gerente.getDocumento());
	        pstmt.setInt(8, gerente.getTipoDocumento().getValue());
	        pstmt.setString(9, gerente.getEmissor());
	        pstmt.setDate(10, new java.sql.Date(gerente.getDataNascimento().getTime()));
	        pstmt.setString(11, gerente.getTelefone());
	        pstmt.setString(12, gerente.getEmail());
	        pstmt.setString(13, gerente.getLogradouro());
	        pstmt.setString(14, gerente.getComplemento());
	        pstmt.setString(15, gerente.getBairro());
	        pstmt.setInt(16, gerente.getCidade().getCodigo());
	        pstmt.setInt(17, gerente.getEstado().getCodigo());
	        pstmt.setString(18, gerente.getCep());
	        pstmt.setInt(19, gerente.getUnidade().getCodigo());
	        pstmt.setBoolean(20, gerente.getStatus().booleanValue());
	        pstmt.setInt(21, gerente.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no registro do gerente (" + gerente.getCodigo() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Gerente> carregarTodos() throws DAOException, ClassNotFoundException {
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
	
	public Gerente carregarPorCodigo(Integer codigo) throws DAOException, ClassNotFoundException {
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
	
	public Gerente carregarPorDocumento(String documento) throws DAOException, ClassNotFoundException {
		Gerente gerente = new Gerente();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM gerente_ger WHERE ger_matger = ? OR ger_cpf = ? OR ger_documento = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, documento);
            pstmt.setString(2, documento);
            pstmt.setString(3, documento);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	gerente = gerarGerente(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o gerente por documento(" + documento + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return gerente;
        
	}
	
	public Gerente carregarPorEmailEMatricula(String email, String matricula) throws ClassNotFoundException, DAOException {
		Gerente gerente = new Gerente();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM gerente_ger WHERE ger_email = ? AND ger_matger = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, email);
            pstmt.setString(2, matricula);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	gerente = gerarGerente(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o gerente por email e matrícula(" + email + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return gerente;
        
	}

	private Gerente gerarGerente(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Gerente gerente = new Gerente();
		
		gerente.setCodigo(res.getInt("ger_codger"));
		gerente.setMatricula(res.getString("ger_matger"));
		gerente.setNome(res.getString("ger_nome"));
		gerente.setSexo(Sexo.getByValue(res.getString("ger_sexo")));
		gerente.setNacionalidade(res.getString("ger_nacional"));
		gerente.setNaturalidade(res.getString("ger_natural"));
		gerente.setCpf(res.getString("ger_cpf"));
		gerente.setDocumento(res.getString("ger_documento"));
		gerente.setTipoDocumento(TipoDocumento.getByValue(res.getInt("ger_tipodoc")));
		gerente.setEmissor(res.getString("ger_emissordoc"));
		gerente.setDataNascimento(res.getDate("ger_dtnasc"));
		gerente.setTelefone(res.getString("ger_telefone"));
		gerente.setEmail(res.getString("ger_email"));
		gerente.setLogradouro(res.getString("ger_logradouro"));
		gerente.setComplemento(res.getString("ger_complemento"));
		gerente.setBairro(res.getString("ger_bairro"));
		gerente.setCidade(CidadeDAO.getInstance().carregarPorCodigo(res.getInt("ger_codcid")));
		gerente.setEstado(EstadoDAO.getInstance().carregarPorCodigo(res.getInt("ger_codest")));
		gerente.setCep(res.getString("ger_cep"));
		gerente.setUnidade(UnidadeDAO.getInstance().carregarPorCodigo(res.getInt("ger_coduni")));
		gerente.setStatus(res.getBoolean("ger_status"));
		
		return gerente;
	}
	
}
