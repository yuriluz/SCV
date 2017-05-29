package com.scv.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Campanha;
import com.scv.javabean.Consulta;
import com.scv.javabean.Pessoa;
import com.scv.javabean.Registro;
import com.scv.javabean.Unidade;
import com.scv.javabean.Vacina;
import com.scv.javabean.Vacinador;
import com.scv.persistence.dao.ConsultaDAO;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.dao.RegistroDAO;
import com.scv.persistence.dao.UnidadeDAO;
import com.scv.persistence.dao.VacinaDAO;
import com.scv.persistence.exception.DAOException;

public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserRegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/user/page-register.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Integer codPessoa;
		Integer codUnidade;
		Pessoa pessoa = null;
		Unidade unidade = new Unidade();
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		codPessoa = Integer.parseInt(request.getParameter("pessoa"));
		codUnidade = Integer.parseInt(request.getParameter("unidade"));
		String[] vacinas = request.getParameterValues("vacina");
		String[] datas = request.getParameterValues("dataVacina");
		String[] lotes = request.getParameterValues("loteVacina");
		
		try {
			pessoa = PessoaDAO.getInstance().carregarPorCodigo(codPessoa);
			unidade = UnidadeDAO.getInstance().carregarPorCodigo(codUnidade);
			
			Consulta consulta = new Consulta(pessoa, unidade, new Vacinador(), new Campanha(), new Date());
			ConsultaDAO.getInstance().inserir(consulta);
			consulta.setCodigo(ConsultaDAO.getInstance().carregarCodigoPorConsulta(consulta));
			
			for (int i = 0; i < vacinas.length; i++) {
				Integer codVacina = null;
				codVacina = Integer.parseInt(vacinas[i]);
				Vacina vacina = VacinaDAO.getInstance().carregarPorCodigo(codVacina);
				String strDataVacina = datas[i];
				Date dataVacina = df.parse(strDataVacina);
				String lote = lotes[i];
					
				Registro registro = new Registro(pessoa, vacina, consulta, dataVacina, lote, false);
				RegistroDAO.getInstance().inserir(registro);
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.getRequestDispatcher("WEB-INF/user/page-register.jsp").forward(request, response);
		
	}

}
