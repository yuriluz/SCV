package com.scv.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Usuario;
import com.scv.javabean.Usuario.TipoUsuario;
import com.scv.persistence.dao.UsuarioDAO;
import com.scv.persistence.exception.DAOException;

public class NewAdmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NewAdmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		try {
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String senha = request.getParameter("senha1");
			
			Usuario usuario = new Usuario(nome, email, senha, TipoUsuario.ADMINISTRADOR);
			
			UsuarioDAO.getInstance().inserir(usuario);
			
		} catch (ClassNotFoundException | DAOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
		}
		
		request.getRequestDispatcher("adm-registration.html").forward(request, response);
		
	}

}
