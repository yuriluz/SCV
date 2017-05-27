package com.scv.persistence.dao;

import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Usuario;
import com.scv.javabean.Usuario.TipoUsuario;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO extends BaseDAO{
	
    private static UsuarioDAO singleton;
    private static Logger LOGGER = Logger.getLogger(UsuarioDAO.class.getName());

    public static UsuarioDAO getInstance() {
        if (singleton == null) {
            singleton = new UsuarioDAO();
        }
        return singleton;
    }
    
    public void inserir(Usuario usuario) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO usuarioadm_usr (usr_nome, usr_usuario, usr_email, usr_senha, usr_tipo, usr_dtcadastro) "
	    		+ "VALUES(?,?,?,MD5(?),?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, usuario.getNome());
	        if (usuario.getTipo().equals(TipoUsuario.ADMINISTRADOR)) {
	        	pstmt.setNull(2, Types.INTEGER);
	        } else {
		        pstmt.setInt(2, usuario.getCodUsuario());
	        }
	        pstmt.setString(3, usuario.getEmail());
	        pstmt.setString(4, usuario.getSenha());
	        pstmt.setString(5, usuario.getTipo().getValue());
	        pstmt.setDate(6, new java.sql.Date(new Date().getTime()));
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria novo usuário";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
    public Usuario validarAcesso(String email, String senha) throws DAOException, ClassNotFoundException {
		Usuario usuario = new Usuario();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM usuarioadm_usr WHERE usr_email = ? AND usr_senha = MD5(?)";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, email);
            pstmt.setString(2, senha);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	usuario = gerarUsuario(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto validava acesso administrativo (" + email + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return usuario;
	}
    
    public Usuario carregarPorCodigo(Integer codigo) throws DAOException, ClassNotFoundException {
		Usuario usuario = new Usuario();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM usuarioadm_usr WHERE usr_codusr = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	usuario = gerarUsuario(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava usuário por código(" + codigo + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return usuario;
	}
    
	public void alterarSenha(Usuario usuario, String novaSenha) throws ClassNotFoundException, DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE usuarioadm_usr SET usr_senha = MD5(?) WHERE usr_codusr = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, novaSenha);
		    pstmt.setInt(2, usuario.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria novo usuário";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
		
	}

	private Usuario gerarUsuario(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Usuario usuario = new Usuario();
		
		usuario.setCodigo(res.getInt("usr_codusr"));
		usuario.setNome(res.getString("usr_nome"));
		usuario.setCodUsuario(res.getInt("usr_usuario"));
		usuario.setEmail(res.getString("usr_email"));
		usuario.setSenha(res.getString("usr_senha"));
		usuario.setTipo(TipoUsuario.getByValue(res.getString("usr_tipo")));

		return usuario;
	}
	
}
