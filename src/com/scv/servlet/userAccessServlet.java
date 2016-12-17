package com.scv.servlet;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Pessoa;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.exception.DAOException;

public class userAccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public userAccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String documento;
		Date dataNascimento;
		DateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy");
		Pessoa pessoa = new Pessoa();
		
		try {
			documento = request.getParameter("doc");
			dataNascimento = dateFormat.parse(request.getParameter("data"));
			pessoa = PessoaDAO.getInstance().carregarPorDocumentoENascimento(documento, dataNascimento);
			if (pessoa.getCodigo() == null) {
				request.getRequestDispatcher("index.html").forward(request, response);
			} else {
				request.setAttribute("usuario", pessoa);
				request.getRequestDispatcher("WEB-INF/home/user-home.jsp").forward(request, response);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (DAOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
	}

}
