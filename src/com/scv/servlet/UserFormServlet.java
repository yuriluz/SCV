package com.scv.servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Estado;
import com.scv.persistence.dao.EstadoDAO;
import com.scv.persistence.exception.DAOException;

public class UserFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(UserFormServlet.class.getName());
       
    public UserFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String estadoId;
		Estado estado = new Estado();
		
		estadoId = request.getParameter("estado");
		try {
			estado = EstadoDAO.getInstance().carregarPorCodigo(Integer.parseInt(estadoId));
		} catch (NumberFormatException | ClassNotFoundException | DAOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
		if (!(estado.getCodigo() == null)) {
			request.setAttribute("estado", estado);
		}

		request.getRequestDispatcher("WEB-INF/includes/cities-select.jsp").forward(request, response);
	
	}

}
