package org.zerock.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;



import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

	
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	//static end
	
	@Test
	public void testConnection() {
		String url = "jdbc:mysql://localhost:3306/BBS";
		try(Connection con = 
				DriverManager.getConnection(url, "root", "sinsiway")) {
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}	//testConnection end
}	//JDBCTests end
