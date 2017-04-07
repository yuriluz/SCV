package com.scv.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserCardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserCardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.getRequestDispatcher("WEB-INF/user/page-card.jsp").forward(request, response);
	
	}

}
