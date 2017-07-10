package com.scv.servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.scv.javabean.Usuario;
import com.scv.persistence.dao.UsuarioDAO;
import com.scv.persistence.exception.DAOException;

public class AdmPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(AdmPasswordServlet.class.getName());
       
    public AdmPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/adm/page-password.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		try {
			Usuario usuario = (Usuario) session.getAttribute("login");
			String senhaAtual = request.getParameter("senhaAtual");
			String novaSenha = request.getParameter("novaSenha1");
			
			usuario = UsuarioDAO.getInstance().validarAcesso(usuario.getEmail(), senhaAtual);
			
			if (usuario.getCodigo() != null) {
				UsuarioDAO.getInstance().alterarSenha(usuario, novaSenha);
				request.getRequestDispatcher("WEB-INF/adm/page-password.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("WEB-INF/adm/page-password.jsp").forward(request, response);
			}
			
		} catch (ClassNotFoundException | DAOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
	}

}
