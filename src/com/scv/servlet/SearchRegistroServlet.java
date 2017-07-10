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

public class SearchRegistroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(SearchRegistroServlet.class.getName());
       
    public SearchRegistroServlet() {
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
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
		request.setAttribute("pessoa", pessoa);
		
		request.getRequestDispatcher("WEB-INF/includes/search-registers.jsp").forward(request, response);
	
	}

}
