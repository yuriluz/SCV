package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Ignore;
import org.junit.Test;

import com.scv.javabean.Pessoa;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.exception.DAOException;

public class PessoaDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(PessoaDAO.getInstance());
	}

	@Ignore
	public void testCarregarTodos() {
		ArrayList<Pessoa> pessoas = new ArrayList<Pessoa>();
		
		try {
			pessoas = (ArrayList<Pessoa>) PessoaDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("PessoaDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(pessoas);
	}

	@Test
	public void testCarregarPorCodigo() {
		Pessoa pessoa = new Pessoa();
		
		try {
			pessoa = PessoaDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("PessoaDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(pessoa);
	}

}
