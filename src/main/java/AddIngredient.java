

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation class AddIngredient
 */
@WebServlet("/AddIngredient")
public class AddIngredient extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddIngredient() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String ingredientName = request.getParameter("ingredientName");
		try {
            Connection conn = getDatabaseConnection();
            
            String query = "SELECT COUNT(*) FROM Ingredients";
            PreparedStatement statement = conn.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            int rowCount = 0;
            if (resultSet.next()) {
                rowCount = resultSet.getInt(1);
            }
            rowCount ++;
            
            
            String sql = "INSERT INTO Ingredients (ingredientID, ingredientName) VALUES (?, ?)";
            statement = conn.prepareStatement(sql);
            statement.setInt(1,  rowCount);
            statement.setString(2, ingredientName);
  
            
            int rowsInserted = statement.executeUpdate();
            statement.close();
            conn.close();
            resultSet.close();
            response.sendRedirect("ingredients.jsp");

         
        } catch (SQLException e) {
            // Handle database errors
            e.printStackTrace();
        }
		
	}
	
	public Connection getDatabaseConnection() throws SQLException {
		String jdbcUrl = "jdbc:mysql://localhost:3306/MealBase";  // Use your desired schema name here
		String username = "root";
		String password = "hello@123";
		
	    Connection connection = null;
	    try {
	        // Load the JDBC driver (make sure the driver JAR is in your classpath)
	    	Class.forName("com.mysql.cj.jdbc.Driver");

	        // Create a database connection
	        connection = DriverManager.getConnection(jdbcUrl, username, password);
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	        throw new SQLException("JDBC driver not found.");
	    }
	    return connection;
	}

}
