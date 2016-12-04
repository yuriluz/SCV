package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Campanha;
import com.scv.persistence.dao.CampanhaDAO;
import com.scv.persistence.exception.DAOException;

public class CampanhaDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(CampanhaDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodos() {
		ArrayList<Campanha> campanhas = new ArrayList<Campanha>();
		
		try {
			campanhas = (ArrayList<Campanha>) CampanhaDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("CampanhaDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(campanhas);
	}

	@Test
	public void testCarregarPorCodigo() {
		Campanha campanha = new Campanha();
		
		try {
			campanha = CampanhaDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("CampanhaDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(campanha);
	}

}
