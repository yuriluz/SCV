package com.scv.persistence;

import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class ConnectionFactory {

	    public Connection getConnection() throws ClassNotFoundException {
	        try {
	        	Class.forName("com.mysql.jdbc.Driver");
	            return (Connection) DriverManager.getConnection("jdbc:mysql://localhost/dbscv?autoReconnect=true&useSSL=false", "admin", "admin");
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
	    }

}
