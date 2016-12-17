package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Cidade;
import com.scv.javabean.Estado;
import com.scv.javabean.Pais;
import com.scv.persistence.dao.CidadeDAO;
import com.scv.persistence.exception.DAOException;

public class CidadeDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(CidadeDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodas() throws ClassNotFoundException {
		ArrayList<Cidade> cidades = new ArrayList<Cidade>();
		
		try {
			cidades = (ArrayList<Cidade>) CidadeDAO.getInstance().carregarTodas();
		} catch (DAOException e) {
			fail("CidadeDAO: Falha do teste de carregarTodas()");
		}
				
		assertNotNull(cidades);
	}

	@Test
	public void testCarregarPorEstado() throws ClassNotFoundException {
		Estado estado = new Estado(1, "Acre", "AC", new Pais(1, "Brasil", "BRA"));
		ArrayList<Cidade> cidades = new ArrayList<Cidade>();
		
		try {
			cidades = (ArrayList<Cidade>) CidadeDAO.getInstance().carregarPorEstado(estado);
		} catch (DAOException e) {
			fail("CidadeDAO: Falha do teste de carregarPorEstados()");
		}
		
		assertNotNull(cidades);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Cidade cidade = new Cidade();
		
		try {
			cidade = CidadeDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("CidadeDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(cidade);
	}

}
