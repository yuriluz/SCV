package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Consulta;
import com.scv.persistence.dao.ConsultaDAO;
import com.scv.persistence.exception.DAOException;

public class ConsultaDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(ConsultaDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Consulta> consultas = new ArrayList<Consulta>();
		
		try {
			consultas = (ArrayList<Consulta>) ConsultaDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("ConsultaDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(consultas);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Consulta consulta = new Consulta();
		
		try {
			consulta = ConsultaDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("ConsultaDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(consulta);
	}

}
