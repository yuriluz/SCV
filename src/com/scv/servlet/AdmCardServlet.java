package com.scv.servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Pessoa;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.exception.DAOException;

public class AdmCardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(AdmCardServlet.class.getName());
       
    public AdmCardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.getRequestDispatcher("WEB-INF/adm/page-card.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String idPessoa;
		Pessoa pessoa = new Pessoa();
		
		idPessoa = request.getParameter("idPessoa");
		
		try {
			pessoa = PessoaDAO.getInstance().carregarPorDocumento(idPessoa);
		} catch (NumberFormatException | ClassNotFoundException | DAOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
		if (!(pessoa.getCodigo() == null)) {
			request.setAttribute("pessoa", pessoa);
		}

		request.getRequestDispatcher("WEB-INF/adm/page-card.jsp").forward(request, response);
	
	}

}
