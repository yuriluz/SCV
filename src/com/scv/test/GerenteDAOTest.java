package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Gerente;
import com.scv.persistence.dao.GerenteDAO;
import com.scv.persistence.exception.DAOException;

public class GerenteDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(GerenteDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodos() {
		ArrayList<Gerente> gerentes = new ArrayList<Gerente>();
		
		try {
			gerentes = (ArrayList<Gerente>) GerenteDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("GerenteDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(gerentes);
	}

	@Test
	public void testCarregarPorCodigo() {
		Gerente gerente = new Gerente();
		
		try {
			gerente = GerenteDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("GerenteDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(gerente);
	}

}
