package com.scv.servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Vacinador;
import com.scv.persistence.dao.VacinadorDAO;
import com.scv.persistence.exception.DAOException;

public class VacinadorFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(VacinadorFormServlet.class.getName());
       
    public VacinadorFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String documento;
		Vacinador vacinador = new Vacinador();
		
		documento = request.getParameter("documento");
		try {
			vacinador = VacinadorDAO.getInstance().carregarPorDocumento(documento);
		} catch (NumberFormatException | ClassNotFoundException | DAOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
		request.setAttribute("vacinador", vacinador);
		
		request.getRequestDispatcher("WEB-INF/adm/page-agent-form.jsp").forward(request, response);
	
	}

}
