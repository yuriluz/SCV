package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Campanha;
import com.scv.javabean.Cidade;
import com.scv.javabean.Estado;
import com.scv.persistence.dao.CampanhaDAO;
import com.scv.persistence.dao.CidadeDAO;
import com.scv.persistence.dao.EstadoDAO;
import com.scv.persistence.exception.DAOException;

public class CampanhaDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(CampanhaDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Campanha> campanhas = new ArrayList<Campanha>();
		
		try {
			campanhas = (ArrayList<Campanha>) CampanhaDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("CampanhaDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(campanhas);
	}
	
	@Test
	public void testCarregarPorTodasNacionais() throws ClassNotFoundException {
		ArrayList<Campanha> campanhas = new ArrayList<Campanha>();
		
		try {
			campanhas = (ArrayList<Campanha>) CampanhaDAO.getInstance().carregarTodasNacionais();
		} catch (DAOException e) {
			fail("CampanhaDAO: Falha do teste de carregarTodasNacionais()");
		}
		
		assertNotNull(campanhas);
	}
	
	@Test
	public void testCarregarTodasPorCidade() throws ClassNotFoundException, DAOException {
		ArrayList<Campanha> campanhas = new ArrayList<Campanha>();
		Cidade cidade = CidadeDAO.getInstance().carregarPorCodigo(1);
		
		try {
			campanhas = (ArrayList<Campanha>) CampanhaDAO.getInstance().carregarTodasPorCidade(cidade);
		} catch (DAOException e) {
			fail("CampanhaDAO: Falha do teste de carregarTodasPorCidade()");
		}
		
		assertNotNull(campanhas);
	}
	
	@Test
	public void testCarregarTodasPorEstado() throws ClassNotFoundException, DAOException {
		ArrayList<Campanha> campanhas = new ArrayList<Campanha>();
		Estado estado = EstadoDAO.getInstance().carregarPorCodigo(1);
		
		try {
			campanhas = (ArrayList<Campanha>) CampanhaDAO.getInstance().carregarTodasPorEstado(estado);
		} catch (DAOException e) {
			fail("CampanhaDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(campanhas);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Campanha campanha = new Campanha();
		
		try {
			campanha = CampanhaDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("CampanhaDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(campanha);
	}

}
