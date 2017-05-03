package com.scv.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Gerente;
import com.scv.persistence.dao.GerenteDAO;
import com.scv.persistence.exception.DAOException;

public class GerenteFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GerenteFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String documento;
		Gerente gerente = new Gerente();
		
		documento = request.getParameter("documento");
		try {
			gerente = GerenteDAO.getInstance().carregarPorDocumento(documento);
		} catch (NumberFormatException | ClassNotFoundException | DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("gerente", gerente);
		
		request.getRequestDispatcher("WEB-INF/adm/page-manager-form.jsp").forward(request, response);
	
	}

}
