package br.com.scv.persistence;

import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class ConnectionFactory {

	    public Connection getConnection() {
	        try {
	            return (Connection) DriverManager.getConnection("jdbc:mysql://localhost/dbscv", "admin", "admin");
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
	    }

}
