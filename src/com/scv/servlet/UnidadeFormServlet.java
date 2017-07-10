package com.scv.servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Unidade;
import com.scv.persistence.dao.UnidadeDAO;
import com.scv.persistence.exception.DAOException;

public class UnidadeFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(UnidadeFormServlet.class.getName());
       
    public UnidadeFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Integer codigo;
		Unidade unidade = new Unidade();
		
		try {
			codigo = Integer.parseInt(request.getParameter("unidade"));
			unidade = UnidadeDAO.getInstance().carregarPorCodigo(codigo);
		} catch (NumberFormatException | ClassNotFoundException | DAOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
		request.setAttribute("unidade", unidade);
		
		request.getRequestDispatcher("WEB-INF/adm/page-center-form.jsp").forward(request, response);
	
	}

}
