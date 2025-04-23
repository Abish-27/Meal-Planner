

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation class DeleteDish
 */
@WebServlet("/DeleteDish")
public class DeleteDish extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteDish() {
       
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	    String id = request.getParameter("id");
	    int dishID = Integer.parseInt(id);
	    
	    String dishName = "";
	    int calories = 0;
	    int isVeg = 0;
	    String type = "";
	    String ingredients = "";
	    
	    try {
            Connection conn = getDatabaseConnection();   
            
            //Getting total number of entries
            String query = "SELECT COUNT(*) FROM Meals";
            PreparedStatement statement = conn.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            int rowCount = 0;
            if (resultSet.next()) {
                rowCount = resultSet.getInt(1);
                
            }
            
            //Getting the last dish
            query = "SELECT * FROM Meals WHERE dishID = ?";
            statement = conn.prepareStatement(query);
            statement.setInt(1, rowCount);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()){
          	   dishName = resultSet.getString("dishName");
          	   calories = resultSet.getInt("calorieCount");
          	   isVeg = resultSet.getInt("isVeg");
          	   type = resultSet.getString("dishType");
          	   ingredients = resultSet.getString("ingredients");
            }
            
            
            //Deleting last dish
            String sql = "DELETE FROM Meals WHERE dishID = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1,  rowCount);
            statement.executeUpdate();
            
            //Updating
            query = "UPDATE Meals SET dishName=?, calorieCount=?, isVeg=?, dishType=?, ingredients=? WHERE dishID=?";
            statement = conn.prepareStatement(query);
            statement.setString(1, dishName);
            statement.setInt(2, calories);
            statement.setInt(3,  isVeg);
            statement.setString(4, type);
            statement.setString(5, ingredients);
            statement.setInt(6,  dishID);
            statement.executeUpdate();
           
            statement.close();
            conn.close();
            response.sendRedirect("cookbook.jsp");

      
        } catch (SQLException e) {
            // Handle database errors
            e.printStackTrace();
        }
		
	

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
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
