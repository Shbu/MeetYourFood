package meetfood;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class DatabaseConnection {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
		String url = "jdbc:oracle:thin:@192.168.11.1:1521:";
		Properties props = new Properties();
        props.setProperty("user", "scott");
        props.setProperty("password", "tiger");

		Connection conn =
		         DriverManager.getConnection(url,props);
		Statement stmt = conn.createStatement();
			ResultSet rsltSet =stmt.executeQuery("SELECT * FROM TAB");
			while(rsltSet.next()){
				System.out.println("Data: " +rsltSet.getString(1));
			}
		
	}

}
