package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Vacinador;
import com.scv.persistence.dao.VacinadorDAO;
import com.scv.persistence.exception.DAOException;

public class VacinadorDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(VacinadorDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Vacinador> vacinadores = new ArrayList<Vacinador>();
		
		try {
			vacinadores = (ArrayList<Vacinador>) VacinadorDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("VacinadorDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(vacinadores);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Vacinador vacinador = new Vacinador();
		
		try {
			vacinador = VacinadorDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("VacinadorDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(vacinador);
	}
	
	@Test
	public void testCarregarPorEmailEMatricula() throws ClassNotFoundException {
		Vacinador vacinador = new Vacinador();
		
		try {
			vacinador = VacinadorDAO.getInstance().carregarPorEmailEMatricula("", "");
		} catch (DAOException e) {
			fail("VacinadorDAO: Falha do teste de carregarPorEmailEMatricula()");
		}
		
		assertNotNull(vacinador);
	}

}
