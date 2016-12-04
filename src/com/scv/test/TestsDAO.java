package com.scv.test;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

@RunWith(Suite.class)
@SuiteClasses({ CampanhaDAOTest.class, CidadeDAOTest.class, ConsultaDAOTest.class, EstadoDAOTest.class,
		GerenteDAOTest.class, PaisDAOTest.class, PessoaDAOTest.class, RegistroDAOTest.class, UnidadeDAOTest.class,
		VacinaDAOTest.class, VacinadorDAOTest.class })
public class TestsDAO {

}
