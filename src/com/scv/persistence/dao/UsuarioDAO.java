package com.scv.persistence.dao;

import java.sql.SQLException;
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

	private Usuario gerarUsuario(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Usuario usuario = new Usuario();
		
		usuario.setCodigo(res.getInt("usr_codusr"));
		usuario.setCodUsuario(res.getInt("usr_usuario"));
		usuario.setEmail(res.getString("usr_email"));
		usuario.setTipo(TipoUsuario.getByValue(res.getString("usr_tipo")));

		return usuario;
	}
	
}
