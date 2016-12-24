package com.scv.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Gerente;
import com.scv.javabean.Usuario;
import com.scv.javabean.Vacinador;
import com.scv.persistence.dao.GerenteDAO;
import com.scv.persistence.dao.UsuarioDAO;
import com.scv.persistence.dao.VacinadorDAO;
import com.scv.persistence.exception.DAOException;

public class admAccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public admAccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email;
		String senha;
		Usuario usuario = new Usuario();
		
		try {
			email = request.getParameter("email");
			senha = request.getParameter("senha");
			usuario = UsuarioDAO.getInstance().validarAcesso(email, senha);
			if (usuario.getCodigo() == null) {
				request.getRequestDispatcher("index.html").forward(request, response);
			} else {
				request.setAttribute("login", usuario);
				if (usuario.getTipo().equals(Usuario.TipoUsuario.ADMINISTRATIVO)){
					request.getRequestDispatcher("WEB-INF/home/adm-home.jsp").forward(request, response);
				} else if (usuario.getTipo().equals(Usuario.TipoUsuario.GERENTE)){
					Gerente gerente = GerenteDAO.getInstance().carregarPorCodigo(usuario.getCodUsuario());
					request.setAttribute("usuario", gerente);
				} else if (usuario.getTipo().equals(Usuario.TipoUsuario.VACINADOR)){
					Vacinador vacinador = VacinadorDAO.getInstance().carregarPorCodigo(usuario.getCodUsuario());
					request.setAttribute("usuario", vacinador);
				}
				
			}
		} catch (DAOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
	}

}
