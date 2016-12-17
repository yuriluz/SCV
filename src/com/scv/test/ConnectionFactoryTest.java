package com.scv.test;

import static org.junit.Assert.*;

import java.sql.Connection;

import org.junit.Test;

import com.scv.persistence.ConnectionFactory;

public class ConnectionFactoryTest {

	@Test
	public void testGetConnection() throws ClassNotFoundException {
		Connection connection = new ConnectionFactory().getConnection();
		assertNotNull(connection);
	}

}
