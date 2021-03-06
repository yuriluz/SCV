package com.scv.test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;

import com.scv.entities.enums.Sexo;
import com.scv.javabean.Vacina;
import com.scv.persistence.dao.VacinaDAO;
import com.scv.persistence.exception.DAOException;

public class VacinaDAOTest {

	@Test
	public void testGetInstance() {
		assertNotNull(VacinaDAO.getInstance());
	}

	@Test
	public void testCarregarTodos() throws ClassNotFoundException {
		ArrayList<Vacina> vacinas = new ArrayList<Vacina>();
		
		try {
			vacinas = (ArrayList<Vacina>) VacinaDAO.getInstance().carregarTodos();
		} catch (DAOException e) {
			fail("VacinaDAO: Falha do teste de carregarTodos()");
		}
				
		assertNotNull(vacinas);
	}

	@Test
	public void testCarregarPorCodigo() throws ClassNotFoundException {
		Vacina vacina = new Vacina();
		
		try {
			vacina = VacinaDAO.getInstance().carregarPorCodigo(1);
		} catch (DAOException e) {
			fail("VacinaDAO: Falha do teste de carregarPorCodigo()");
		}
		
		assertNotNull(vacina);
	}
	
	@Test
	public void testCarregarPorSexoEIdade() throws ClassNotFoundException {
		ArrayList<Vacina> vacinas = new ArrayList<Vacina>();
		
		try {
			vacinas = (ArrayList<Vacina>) VacinaDAO.getInstance().carregarPorSexoEIdade(Sexo.MASCULINO, 25);
		} catch (DAOException e) {
			fail("VacinaDAO: Falha do teste de carregarPorSexoEIdade()");
		}
		
		assertNotNull(vacinas);
	}

}
