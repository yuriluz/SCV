package com.scv.servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.scv.javabean.Gerente;
import com.scv.javabean.Usuario;
import com.scv.javabean.Vacinador;
import com.scv.persistence.dao.GerenteDAO;
import com.scv.persistence.dao.UsuarioDAO;
import com.scv.persistence.dao.VacinadorDAO;
import com.scv.persistence.exception.DAOException;

public class AdmLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(AdmLoginServlet.class.getName());
       
    public AdmLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email;
		String senha;
		String tipo;
		Usuario usuario = new Usuario();
		HttpSession session = request.getSession();
		
		try {
			email = request.getParameter("email");
			senha = request.getParameter("senha");
			tipo = request.getParameter("tipo");
			usuario = UsuarioDAO.getInstance().validarAcesso(email, senha);
			if (usuario.getEmail() == null) {
				request.getRequestDispatcher("/adm-access.jsp?t=".concat(tipo).concat("&sucesso=0")).forward(request, response);
			} else {
				session.setAttribute("login", usuario);
				if (usuario.getTipo().equals(Usuario.TipoUsuario.GERENTE)){
					Gerente gerente = GerenteDAO.getInstance().carregarPorCodigo(usuario.getCodUsuario());
					session.setAttribute("gerente", gerente);
					session.setAttribute("tipoUsuario", Usuario.TipoUsuario.GERENTE);
				} else if (usuario.getTipo().equals(Usuario.TipoUsuario.VACINADOR)){
					Vacinador vacinador = VacinadorDAO.getInstance().carregarPorCodigo(usuario.getCodUsuario());
					session.setAttribute("vacinador", vacinador);
					session.setAttribute("tipoUsuario", Usuario.TipoUsuario.VACINADOR);
				} else if (usuario.getTipo().equals(Usuario.TipoUsuario.ADMINISTRADOR)){
					session.setAttribute("tipoUsuario", Usuario.TipoUsuario.ADMINISTRADOR);
				}
				request.getRequestDispatcher("WEB-INF/home/adm-home.jsp").forward(request, response);
			}
		} catch (DAOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		} catch (ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}	
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Usuario usuario = new Usuario();
		HttpSession session = request.getSession();
		
		usuario = (Usuario) session.getAttribute("login");
		if (usuario.getCodigo() == null) {
			request.getRequestDispatcher("adm-access.jsp").forward(request, response);
		} else {
			request.getRequestDispatcher("WEB-INF/home/adm-home.jsp").forward(request, response);
		}
		
	}

}
