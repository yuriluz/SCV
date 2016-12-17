package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Registro;
import com.scv.persistence.dao.RegistroDAO;
import com.scv.persistence.exception.DAOException;

public class RegistroDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(RegistroDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Registro> registros = new ArrayList<Registro>();
		
		try {
			registros = (ArrayList<Registro>) RegistroDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("RegistroDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(registros);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Registro registro = new Registro();
		
		try {
			registro = RegistroDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("RegistroDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(registro);
	}

}
