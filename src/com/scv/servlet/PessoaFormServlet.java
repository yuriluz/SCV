package com.scv.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Pessoa;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.exception.DAOException;

public class PessoaFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PessoaFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String documento;
		Pessoa pessoa = new Pessoa();
		
		documento = request.getParameter("documento");
		try {
			pessoa = PessoaDAO.getInstance().carregarPorDocumento(documento);
		} catch (NumberFormatException | ClassNotFoundException | DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("pessoa", pessoa);
		
		request.getRequestDispatcher("WEB-INF/includes/page-user-form.jsp").forward(request, response);
	
	}

}
