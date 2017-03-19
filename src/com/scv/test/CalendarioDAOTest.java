package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;

import com.scv.javabean.Calendario;
import com.scv.persistence.dao.CalendarioDAO;
import com.scv.persistence.exception.DAOException;

public class CalendarioDAOTest {
	
	@Test
	public void testGetInstance() {
		assertNotNull(CalendarioDAO.getInstance());
	}
	
	@Test
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Calendario> calendarios = new ArrayList<Calendario>();
		
		try {
			calendarios = (ArrayList<Calendario>) CalendarioDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("CalendarioDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(calendarios);
	}
	
	@Test
	public void testCarregarPorAno() throws ClassNotFoundException {
		Calendario calendario = new Calendario();
		
		try {
			calendario = CalendarioDAO.getInstance().carregarPorAno("2017");
		} catch (DAOException e) {
			fail("CalendarioDAO: Falha do teste de carregarPorAno()");
		}
		
		assertNotNull(calendario);
	}
	
	@Test
	public void testCarregarMaisAtual() throws ClassNotFoundException {
		Calendario calendario = new Calendario();
		
		try {
			calendario = CalendarioDAO.getInstance().carregarMaisAtual();
		} catch (DAOException e) {
			fail("CalendarioDAO: Falha do teste de carregarMaisAtual()");
		}
		
		assertNotNull(calendario);
	}
	
}
