package com.scv.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.scv.javabean.Pessoa;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.exception.DAOException;

public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String documento;
		String senha;
		Pessoa pessoa = new Pessoa();
		HttpSession session = request.getSession();
		
		try {
			documento = request.getParameter("doc");
			senha = request.getParameter("senha");
			pessoa = PessoaDAO.getInstance().validarAcesso(documento, senha);
			if (pessoa.getCodigo() == null) {
				request.getRequestDispatcher("index.html").forward(request, response);
			} else {
				session.setAttribute("usuario", pessoa);
				request.getRequestDispatcher("WEB-INF/home/user-home.jsp").forward(request, response);
			}
		} catch (DAOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
	}

}
