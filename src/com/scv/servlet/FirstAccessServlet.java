package com.scv.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Gerente;
import com.scv.javabean.Usuario;
import com.scv.javabean.Usuario.TipoUsuario;
import com.scv.javabean.Vacinador;
import com.scv.persistence.dao.GerenteDAO;
import com.scv.persistence.dao.UsuarioDAO;
import com.scv.persistence.dao.VacinadorDAO;
import com.scv.persistence.exception.DAOException;

public class FirstAccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FirstAccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		try {
			String email = request.getParameter("email");
			String matricula = request.getParameter("matricula");
			String senha = request.getParameter("senha1");
			
			Vacinador vacinador = new Vacinador();
			Gerente gerente = new Gerente();
			
			vacinador = VacinadorDAO.getInstance().carregarPorEmailEMatricula(email, matricula);
			gerente = GerenteDAO.getInstance().carregarPorEmailEMatricula(email, matricula);
			
			if (vacinador.getCodigo() != null) {
				Usuario usuario = new Usuario(vacinador.getNome(), vacinador.getCodigo(), email, senha, TipoUsuario.VACINADOR);
				UsuarioDAO.getInstance().inserir(usuario);
				request.getRequestDispatcher("adm-access.jsp?t=1").forward(request, response);
			} else if (gerente.getCodigo() != null) {
				Usuario usuario = new Usuario(gerente.getNome(), gerente.getCodigo(), email, senha, TipoUsuario.GERENTE);
				UsuarioDAO.getInstance().inserir(usuario);
				request.getRequestDispatcher("adm-access.jsp?t=1").forward(request, response);
			} else {
				request.getRequestDispatcher("first-access.html").forward(request, response);
			}
			
		} catch (ClassNotFoundException | DAOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
		}
		
		
	}

}
