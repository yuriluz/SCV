package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;

import com.scv.javabean.Pais;
import com.scv.persistence.dao.PaisDAO;
import com.scv.persistence.exception.DAOException;

public class PaisDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(PaisDAO.getInstance());
	}

	@Test
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Pais> paises = new ArrayList<Pais>();
		
		try {
			paises = (ArrayList<Pais>) PaisDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("PaisDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(paises);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Pais pais = new Pais();
		
		try {
			pais = PaisDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("PaisDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(pais);
	}

}
