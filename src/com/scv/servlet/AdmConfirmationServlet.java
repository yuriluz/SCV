package com.scv.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Registro;
import com.scv.javabean.Vacinador;
import com.scv.persistence.dao.RegistroDAO;
import com.scv.persistence.exception.DAOException;

public class AdmConfirmationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdmConfirmationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/adm/page-confirmation.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		Vacinador vacinador = (Vacinador) request.getSession().getAttribute("vacinador");
		String[] confRegistros = request.getParameterValues("confRegistros");
		String strDataConfirmacao = request.getParameter("dtConfirmacao");
		
		
		try {
			Date dataConfirmacao = df.parse(strDataConfirmacao);
			
			for (int i = 0; i < confRegistros.length; i++) {
				Integer codRegistro = Integer.parseInt(confRegistros[i]);
				Registro registro = RegistroDAO.getInstance().carregarPorCodigo(codRegistro);
				registro.setVerificado(true);
				registro.setVerificador(vacinador);
				registro.setDataVerificacao(dataConfirmacao);
				RegistroDAO.getInstance().alterar(registro);
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

		
		request.getRequestDispatcher("WEB-INF/adm/page-confirmation.jsp").forward(request, response);
		
	}

}
