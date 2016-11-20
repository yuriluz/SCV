package com.scv.persistence.exception;

public class DAOException extends Exception {
	static final long serialVersionUID = 1L;
	
	public DAOException(String msg) {
		super(msg);
	}
	
	public DAOException(String msg, Throwable t) {
		super(msg, t);
	}
}
