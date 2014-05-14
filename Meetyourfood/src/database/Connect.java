package database;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.annotation.RegEx;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




import oracle.jdbc.driver.OracleDriver;

/**
 * Servlet implementation class Connect
 */
@WebServlet("/Connect")
public class Connect extends HttpServlet {
	static final private String CONTENT_TYPE = "text/html";
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Connect() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String title = request.getParameter("title");
		String Username = "sacoolsurfer242@gmail.com";
		String city = request.getParameter("city");
		String county = request.getParameter("county");
		String country = request.getParameter("country");
		String Mealtype = request.getParameter("Mealtype");
		String MealDetails = request.getParameter("MealDetails");
		String ming1 = request.getParameter("ming1");
		String ming2 = request.getParameter("ming2");
		String ming3 = request.getParameter("ming3");
		String ming4 = request.getParameter("ming4");
		String ming5 = request.getParameter("ming5");
		char alchser = request.getParameter("alchser").charAt(0);
		
		//String 
		
		//username=Sidharth+Agarwal&title=&city=&county=&country=&Mealtype=&MealDetails=+&ming1=&ming2=&ming3=&ming4=&ming5=&alchser=&Submit=Submit
		 
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		
		
		String url = "jdbc:oracle:thin:@localhost:1521"; 
	      
        //properties for creating connection to Oracle database
        Properties props = new Properties();
        props.setProperty("user", "scott");
        props.setProperty("password", "tiger");
      
        //creating connection to Oracle database using JDBC
        Connection conn = null;
			conn = DriverManager.getConnection(url,props);
			Statement stmt = conn.createStatement();
			String sql ="Insert into event values ('"+Username+"','"+title+"','"+city+"','"+county+"','"+country+"','"+Mealtype+"','"+MealDetails+"','"+ming1+"','"+ming2+"','"+ming3+"','"+ming4+"','"+ming5+"','"+alchser+",SYSDATE)";	
			stmt.execute(sql);
        //creating PreparedStatement object to execute query
		response.sendRedirect("Host.jsp");
		
		
		
		
		} catch (ClassNotFoundException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType(CONTENT_TYPE);
		PrintWriter out = response.getWriter();
		String title = request.getParameter("title");
		//String sample = request.getSession().getAttribute("title").toString();
		out.println("The sample value is " + title);
		
		
	}

}
