package com.scv.test;

import static org.junit.Assert.*;

import org.junit.Test;

import com.scv.javabean.Usuario;
import com.scv.persistence.dao.UsuarioDAO;
import com.scv.persistence.exception.DAOException;

public class UsuarioDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(UsuarioDAO.getInstance());
	}
	
	@Test
	public void testValidarAcesso() throws ClassNotFoundException {
		Usuario usuario = new Usuario();
		
		try {
			usuario = UsuarioDAO.getInstance().validarAcesso("", "");
		} catch (DAOException e) {
			fail("UsuarioDAO: Falha do teste de validarAcesso()");
		}
		
		assertNotNull(usuario);
	}
	

}
