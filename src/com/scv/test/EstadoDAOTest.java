package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;

import com.scv.javabean.Estado;
import com.scv.javabean.Pais;
import com.scv.persistence.dao.EstadoDAO;
import com.scv.persistence.exception.DAOException;

public class EstadoDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(EstadoDAO.getInstance());
	}

	@Test
	public void testCarregarTodos() {
		ArrayList<Estado> estados = new ArrayList<Estado>();
		
		try {
			estados = (ArrayList<Estado>) EstadoDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("EstadoDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(estados);
	}

	@Test
	public void testCarregarPorPais() {
		Pais pais = new Pais(1, "Brasil", "BRA");
		ArrayList<Estado> estados = new ArrayList<Estado>();
		
		try {
			estados = (ArrayList<Estado>) EstadoDAO.getInstance().carregarPorPais(pais);
		} catch (DAOException e) {
			fail("EstadoDAO: Falha do teste de carregarPorPais()");
		}
		
		assertNotNull(estados);
	}

	@Test
	public void testCarregarPorCodigo() {
		Estado estado = new Estado();
		
		try {
			estado = EstadoDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("EstadoDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(estado);
	}

}
