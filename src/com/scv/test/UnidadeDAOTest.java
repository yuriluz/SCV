package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Cidade;
import com.scv.javabean.Unidade;
import com.scv.persistence.dao.UnidadeDAO;
import com.scv.persistence.exception.DAOException;

public class UnidadeDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(UnidadeDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Unidade> unidades = new ArrayList<Unidade>();
		
		try {
			unidades = (ArrayList<Unidade>) UnidadeDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("UnidadeDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(unidades);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Unidade unidade = new Unidade();
		
		try {
			unidade = UnidadeDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("UnidadeDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(unidade);
	}
	
	@Test
	public void testCarregarPorCidade() throws ClassNotFoundException {
		List<Unidade> unidades = new ArrayList<Unidade>();
		Cidade cidade = new Cidade();
		cidade.setCodigo(3658);
		
		try {
			unidades = UnidadeDAO.getInstance().carregarPorCidade(cidade);
		} catch (DAOException e) {
			fail("UnidadeDAO: Falha do teste de carregarPorCidade()");
		}
		
		assertNotNull(unidades);
	}

}
