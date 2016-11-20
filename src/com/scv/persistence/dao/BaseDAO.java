package com.scv.persistence.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.logging.Logger;

import com.scv.persistence.ConnectionFactory;

public abstract class BaseDAO {

	private static Logger LOGGER = Logger.getLogger(BaseDAO.class.getName());
	
	protected Connection getConnection() {
		Connection connection = new ConnectionFactory().getConnection();
		return connection;
	}
		
	protected void close(Connection conn) {
		if(conn != null) try { conn.close(); } catch(Exception e) {}
	}
	
	protected void close(Connection conn, Statement stmt) {
		if(conn != null) try { conn.close(); } catch(Exception e) {}
		if(stmt != null) try { stmt.close(); } catch(Exception e) {}
	}
	
	protected void close(Connection conn, Statement stmt, ResultSet rset) {
		if(conn != null) try { conn.close(); } catch(Exception e) {}
		if(stmt != null) try { stmt.close(); } catch(Exception e) {}
		if(rset != null) try { rset.close(); } catch(Exception e) {}
	}
	
	protected void close(Statement stmt, ResultSet rset) {
		if(stmt != null) try { stmt.close(); } catch(Exception e) {}
		if(rset != null) try { rset.close(); } catch(Exception e) {}
	}
	
	protected void close(Statement stmt) {
		if(stmt != null) try { stmt.close(); } catch(Exception e) {}
	}
	
	protected void close(ResultSet rset) {
		if(rset != null) try { rset.close(); } catch(Exception e) {}
	}

	protected java.sql.Date toSqlDate(Date date) {
		if (date instanceof java.sql.Date) {
			return (java.sql.Date) date;
		} else {
			return new java.sql.Date(date.getTime());
		}
	}
}
