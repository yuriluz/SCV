package com.scv.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Cidade;
import com.scv.persistence.dao.CidadeDAO;
import com.scv.persistence.exception.DAOException;

public class CentersSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CentersSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String cidadeId;
		Cidade cidade = new Cidade();
		
		cidadeId = request.getParameter("cidade");
		try {
			cidade = CidadeDAO.getInstance().carregarPorCodigo(Integer.parseInt(cidadeId));
		} catch (NumberFormatException | ClassNotFoundException | DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if (!(cidade.getCodigo() == null)) {
			request.setAttribute("cidade", cidade);
		}

		request.getRequestDispatcher("WEB-INF/includes/centers-select.jsp").forward(request, response);
	
	}

}
