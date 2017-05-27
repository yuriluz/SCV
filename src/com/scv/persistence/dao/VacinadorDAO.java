package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.entities.enums.Sexo;
import com.scv.entities.enums.TipoDocumento;
import com.scv.javabean.Vacinador;
import com.scv.javabean.Vacinador.TipoVacinador;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VacinadorDAO extends BaseDAO{
	
    private static VacinadorDAO singleton;
    private static Logger LOGGER = Logger.getLogger(VacinadorDAO.class.getName());

    public static VacinadorDAO getInstance() {
        if (singleton == null) {
            singleton = new VacinadorDAO();
        }
        return singleton;
    }
	
	public void inserir(Vacinador vacinador) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO vacinador_vac (vac_matvac, vac_nome, vac_dtmat, vac_sexo,"
	    		+ "vac_nacional, vac_natural, vac_cpf, vac_tipo, vac_crm, vac_documento, vac_tipodoc, vac_emissordoc, vac_dtnasc, vac_telefone, vac_email,"
	    		+ "vac_logradouro, vac_complemento, vac_bairro, vac_codcid, vac_codest, vac_cep, vac_coduni, vac_status) "
	    		+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, vacinador.getMatricula());
	        pstmt.setString(2, vacinador.getNome());
	        pstmt.setDate(3, new java.sql.Date(new Date().getTime()));
	        pstmt.setString(4, vacinador.getSexo().getValue());
	        pstmt.setString(5, vacinador.getNacionalidade());
	        pstmt.setString(6, vacinador.getNaturalidade());
	        pstmt.setString(7, vacinador.getCpf());
	        pstmt.setInt(8, vacinador.getTipoVacinador().getValue());
	        pstmt.setString(9, vacinador.getCrm());
	        pstmt.setString(10, vacinador.getDocumento());
	        pstmt.setInt(11, vacinador.getTipoDocumento().getValue());
	        pstmt.setString(12, vacinador.getEmissor());
	        pstmt.setDate(13, new java.sql.Date(vacinador.getDataNascimento().getTime()));
	        pstmt.setString(14, vacinador.getTelefone());
	        pstmt.setString(15, vacinador.getEmail());
	        pstmt.setString(16, vacinador.getLogradouro());
	        pstmt.setString(17, vacinador.getComplemento());
	        pstmt.setString(18, vacinador.getBairro());
	        pstmt.setInt(19, vacinador.getCidade().getCodigo());
	        pstmt.setInt(20, vacinador.getEstado().getCodigo());
	        pstmt.setString(21, vacinador.getCep());
	        pstmt.setInt(22, vacinador.getUnidade().getCodigo());
	        pstmt.setBoolean(23, vacinador.getStatus().booleanValue());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria novo vacinador";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Vacinador vacinador) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE vacinador_vac SET vac_matvac = ?, vac_nome = ?, "
	    		+ "vac_sexo = ?, vac_nacional = ?, vac_natural = ?, vac_cpf = ?, vac_tipo = ?, vac_crm = ?, vac_documento = ?, vac_tipodoc = ?, vac_emissordoc = ?, vac_dtnasc = ?, "
	    		+ "vac_telefone = ?, vac_email = ?, vac_logradouro = ?, vac_complemento = ?, vac_bairro = ?, vac_codcid = ?, "
	    		+ "vac_codest = ?, vac_cep = ?, vac_coduni = ?, vac_status = ? WHERE vac_codvac = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, vacinador.getMatricula());
	        pstmt.setString(2, vacinador.getNome());
	        pstmt.setString(3, vacinador.getSexo().getValue());
	        pstmt.setString(4, vacinador.getNacionalidade());
	        pstmt.setString(5, vacinador.getNaturalidade());
	        pstmt.setString(6, vacinador.getCpf());
	        pstmt.setInt(7, vacinador.getTipoVacinador().getValue());
	        pstmt.setString(8, vacinador.getCrm());
	        pstmt.setString(9, vacinador.getDocumento());
	        pstmt.setInt(10, vacinador.getTipoDocumento().getValue());
	        pstmt.setString(11, vacinador.getEmissor());
	        pstmt.setDate(12, new java.sql.Date(vacinador.getDataNascimento().getTime()));
	        pstmt.setString(13, vacinador.getTelefone());
	        pstmt.setString(14, vacinador.getEmail());
	        pstmt.setString(15, vacinador.getLogradouro());
	        pstmt.setString(16, vacinador.getComplemento());
	        pstmt.setString(17, vacinador.getBairro());
	        pstmt.setInt(18, vacinador.getCidade().getCodigo());
	        pstmt.setInt(19, vacinador.getEstado().getCodigo());
	        pstmt.setString(20, vacinador.getCep());
	        pstmt.setInt(21, vacinador.getUnidade().getCodigo());
	        pstmt.setBoolean(22, vacinador.getStatus().booleanValue());
	        pstmt.setInt(23, vacinador.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no registro do vacinador (" + vacinador.getCodigo() +")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Vacinador> carregarTodos() throws DAOException, ClassNotFoundException {
		List<Vacinador> vacinadores = new ArrayList<Vacinador>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from vacinador_vac order by vac_codvac";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
            	Vacinador vacinador = gerarVacinador(res);
                vacinadores.add(vacinador);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todos os vacinadores";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return vacinadores;
	}
	
	public Vacinador carregarPorCodigo(Integer codigo) throws DAOException, ClassNotFoundException {
		Vacinador vacinador = new Vacinador();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM vacinador_vac WHERE vac_codvac = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	vacinador = gerarVacinador(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o vacinador (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return vacinador;
	}
	
	public Vacinador carregarPorDocumento(String documento) throws DAOException, ClassNotFoundException {
		Vacinador vacinador = new Vacinador();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM vacinador_vac WHERE vac_matvac = ? OR vac_cpf = ? OR vac_documento = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, documento);
            pstmt.setString(2, documento);
            pstmt.setString(3, documento);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	vacinador = gerarVacinador(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o vacinador (" + documento + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return vacinador;
	}

	public Vacinador carregarPorEmailEMatricula(String email, String matricula) throws ClassNotFoundException, DAOException {
		Vacinador vacinador = new Vacinador();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM vacinador_vac WHERE vac_email = ? AND vac_matvac = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, email);
            pstmt.setString(2, matricula);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	vacinador = gerarVacinador(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o vacinador (" + email + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return vacinador;
        
	}

	private Vacinador gerarVacinador(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Vacinador vacinador = new Vacinador();
		
		vacinador.setCodigo(res.getInt("vac_codvac"));
		vacinador.setMatricula(res.getString("vac_matvac"));
		vacinador.setNome(res.getString("vac_nome"));
		vacinador.setSexo(Sexo.getByValue(res.getString("vac_sexo")));
		vacinador.setNacionalidade(res.getString("vac_nacional"));
		vacinador.setNaturalidade(res.getString("vac_natural"));
		vacinador.setCpf(res.getString("vac_cpf"));
		vacinador.setTipoVacinador(TipoVacinador.getByValue(res.getInt("vac_tipo")));
		vacinador.setCrm(res.getString("vac_crm"));
		vacinador.setDocumento(res.getString("vac_documento"));
		vacinador.setTipoDocumento(TipoDocumento.getByValue(res.getInt("vac_tipodoc")));
		vacinador.setEmissor(res.getString("vac_emissordoc"));
		vacinador.setDataNascimento(res.getDate("vac_dtnasc"));
		vacinador.setTelefone(res.getString("vac_telefone"));
		vacinador.setEmail(res.getString("vac_email"));
		vacinador.setLogradouro(res.getString("vac_logradouro"));
		vacinador.setComplemento(res.getString("vac_complemento"));
		vacinador.setBairro(res.getString("vac_bairro"));
		vacinador.setCidade(CidadeDAO.getInstance().carregarPorCodigo(res.getInt("vac_codcid")));
		vacinador.setEstado(EstadoDAO.getInstance().carregarPorCodigo(res.getInt("vac_codest")));
		vacinador.setCep(res.getString("vac_cep"));
		vacinador.setUnidade(UnidadeDAO.getInstance().carregarPorCodigo(res.getInt("vac_coduni")));
		vacinador.setStatus(res.getBoolean("vac_status"));
		
		return vacinador;
	}
	
}
