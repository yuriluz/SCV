package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.entities.enums.Sexo;
import com.scv.javabean.Pessoa;
import com.scv.javabean.Pessoa.Escolaridade;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PessoaDAO extends BaseDAO{
	
    private static PessoaDAO singleton;
    private static Logger LOGGER = Logger.getLogger(PessoaDAO.class.getName());

    public static PessoaDAO getInstance() {
        if (singleton == null) {
            singleton = new PessoaDAO();
        }
        return singleton;
    }
	
	public void inserir(Pessoa pessoa) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO pessoa_pes (pes_nome, pes_dtmat, pes_sexo, pes_nacional, pes_natural, "
	    		+ "pes_cpf, pes_documento, pes_dtnasc, pes_escolaridade, pes_telefone, pes_email, "
	    		+ "pes_logradouro, pes_complemento, pes_bairro, pes_codcid, pes_codest, pes_cep) "
	    		+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, pessoa.getNome());
	        pstmt.setDate(2, (java.sql.Date) new Date());
	        pstmt.setString(3, pessoa.getSexo().getValue());
	        pstmt.setString(4, pessoa.getNacionalidade());
	        pstmt.setString(5, pessoa.getNaturalidade());
	        pstmt.setString(6, pessoa.getCpf());
	        pstmt.setString(7, pessoa.getDocumento());
	        pstmt.setDate(8, (java.sql.Date) pessoa.getDataNascimento());
	        pstmt.setInt(9, pessoa.getEscolaridade().getValue());
	        pstmt.setString(10, pessoa.getTelefone());
	        pstmt.setString(11, pessoa.getEmail());
	        pstmt.setString(12, pessoa.getLogradouro());
	        pstmt.setString(13, pessoa.getComplemento());
	        pstmt.setString(14, pessoa.getBairro());
	        pstmt.setInt(15, pessoa.getCidade().getCodigo());
	        pstmt.setInt(16, pessoa.getEstado().getCodigo());
	        pstmt.setString(17, pessoa.getCep());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria nova pessoa";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Pessoa pessoa) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE pessoa_pes SET pes_nome = ?, pes_sexo = ?, pes_nacional = ?, "
	    		+ "pes_natural = ?, pes_cpf = ?, pes_documento = ?, pes_dtnasc = ?, pes_telefone = ?, pes_email = ?, pes_escolaridade = ?, "
	    		+ "pes_logradouro = ?, pes_complemento = ?, pes_bairro = ?, pes_codcid = ?, pes_codest = ?, pes_cep = ? "
	    		+ "WHERE pes_codpes = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, pessoa.getNome());
	        pstmt.setString(2, pessoa.getSexo().getValue());
	        pstmt.setString(3, pessoa.getNacionalidade());
	        pstmt.setString(4, pessoa.getNaturalidade());
	        pstmt.setString(5, pessoa.getCpf());
	        pstmt.setString(6, pessoa.getDocumento());
	        pstmt.setDate(7, (java.sql.Date) pessoa.getDataNascimento());
	        pstmt.setString(8, pessoa.getTelefone());
	        pstmt.setString(9, pessoa.getEmail());
	        pstmt.setInt(10, pessoa.getEscolaridade().getValue());
	        pstmt.setString(11, pessoa.getLogradouro());
	        pstmt.setString(12, pessoa.getComplemento());
	        pstmt.setString(13, pessoa.getBairro());
	        pstmt.setInt(14, pessoa.getCidade().getCodigo());
	        pstmt.setInt(15, pessoa.getEstado().getCodigo());
	        pstmt.setString(16, pessoa.getCep());
	        pstmt.setInt(17, pessoa.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no registro da pessoa (" + pessoa.getCodigo() +")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Pessoa> carregarTodos() throws DAOException {
		List<Pessoa> pessoas = new ArrayList<Pessoa>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from pessoa_pes order by pes_codpes";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Pessoa pessoa = gerarPessoa(res);
                pessoas.add(pessoa);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as pessoas";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return pessoas;
	}
	
	public Pessoa carregarPorCodigo(Integer codigo) throws DAOException {
		Pessoa pessoa = new Pessoa();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM pessoa_pes WHERE pes_codpes = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	pessoa = gerarPessoa(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava a pessoa (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return pessoa;
	}

	private Pessoa gerarPessoa(ResultSet res) throws SQLException, DAOException {
		Pessoa pessoa = new Pessoa();
		
		pessoa.setCodigo(res.getInt("pes_codpes"));
		pessoa.setNome(res.getString("pes_nome"));
		pessoa.setSexo(Sexo.getByValue(res.getString("pes_sexo")));
		pessoa.setNacionalidade(res.getString("pes_nacional"));
		pessoa.setNaturalidade(res.getString("pes_natural"));
		pessoa.setCpf(res.getString("pes_cpf"));
		pessoa.setDocumento(res.getString("pes_documento"));
		pessoa.setDataNascimento(res.getDate("pes_dtnasc"));
		pessoa.setTelefone(res.getString("pes_telefone"));
		pessoa.setEmail(res.getString("pes_email"));
		pessoa.setEscolaridade(Escolaridade.getByValue(res.getInt("pes_escolaridade")));
		pessoa.setLogradouro(res.getString("pes_logradouro"));
		pessoa.setComplemento(res.getString("pes_complemento"));
		pessoa.setBairro(res.getString("pes_bairro"));
		pessoa.setCidade(CidadeDAO.getInstance().carregarPorCodigo(res.getInt("pes_codcid")));
		pessoa.setEstado(EstadoDAO.getInstance().carregarPorCodigo(res.getInt("pes_codest")));
		pessoa.setCep(res.getString("pes_cep"));
		
		return pessoa;
	}
	
}
