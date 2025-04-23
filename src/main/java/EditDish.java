

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditDish
 */
@WebServlet("/EditDish")
public class EditDish extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditDish() {
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
		//doGet(request, response);
		int isVeg = 0;
		String id = request.getParameter("dishID");
		int dishID = Integer.parseInt(id);
		String dishName = request.getParameter("name");
		String type = request.getParameter("type");
		String vegCheck = request.getParameter("vegCheck");
		String calorieSlider = request.getParameter("calories");
		String[] selectedIngredients = request.getParameterValues("selectedIngredients");
	        
	    String ingredients = ""; //Empty string of ingredients
	    //Checking if any ingredients have been selected
	    if (selectedIngredients != null) {
	    	for (String ingredient : selectedIngredients) {
	    		ingredients += ingredient;//Adding each ingredient to string
	            ingredients += ",";//Adding a comma to separate ingredients
	        }
	    }
		//Getting calorie count from slider value
		int calorieCount = Integer.parseInt(calorieSlider);
		//Checking if vegCheck value exists and was check box was clicked
		if (vegCheck != null && vegCheck.equals("on")) {
			isVeg = 1;
		}
		
		try {
            Connection conn = getDatabaseConnection();         
            String sql = "UPDATE Meals SET dishName=?, calorieCount=?, isVeg=?, dishType=?, ingredients=? WHERE dishID=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement = conn.prepareStatement(sql);
            statement.setString(1, dishName);
            statement.setInt(2, calorieCount);
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
