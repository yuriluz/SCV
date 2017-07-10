package com.scv.servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.scv.javabean.Pessoa;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.exception.DAOException;

public class UserPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(UserPasswordServlet.class.getName());
       
    public UserPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/user/page-password.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		try {
			Pessoa pessoa = (Pessoa) session.getAttribute("usuario");
			String senhaAtual = request.getParameter("senhaAtual");
			String novaSenha = request.getParameter("novaSenha1");
			
			if (!pessoa.getDocumento().isEmpty()) {
				pessoa = PessoaDAO.getInstance().validarAcesso(pessoa.getDocumento(), senhaAtual);
			} else if (!pessoa.getCpf().isEmpty()) {
				pessoa = PessoaDAO.getInstance().validarAcesso(pessoa.getCpf(), senhaAtual);
			} else {
				pessoa = new Pessoa();
			}
			
			if (pessoa.getCodigo() != null) {
				PessoaDAO.getInstance().alterarSenha(pessoa, novaSenha);
				request.getRequestDispatcher("WEB-INF/user/page-password.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("WEB-INF/user/page-password.jsp").forward(request, response);
			}
			
		} catch (ClassNotFoundException | DAOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
				
	}

}
