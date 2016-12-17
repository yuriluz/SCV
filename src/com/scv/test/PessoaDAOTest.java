package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Date;

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
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Pessoa> pessoas = new ArrayList<Pessoa>();
		
		try {
			pessoas = (ArrayList<Pessoa>) PessoaDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("PessoaDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(pessoas);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Pessoa pessoa = new Pessoa();
		
		try {
			pessoa = PessoaDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("PessoaDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(pessoa);
	}
	
	@Test
	public void testCarregarPorDocumentoENascimento() throws ClassNotFoundException {
		Pessoa pessoa = new Pessoa();
		
		try {
			pessoa = PessoaDAO.getInstance().carregarPorDocumentoENascimento("", new Date());
		} catch (DAOException e) {
			fail("PessoaDAO: Falha do teste de carregarPorDocumentoENascimento()");
		}
		
		assertNotNull(pessoa);
	}
	

}
