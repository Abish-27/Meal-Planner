

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

/**
 * Servlet implementation class insertMeal
 */
@WebServlet("/insertMeal")
public class insertMeal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

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
		System.out.println("made it here");
		
		int isVeg = 0;
		String dishName = request.getParameter("dishName");
		String type = request.getParameter("type");
		String vegCheck = request.getParameter("vegCheck");
		String calorieSlider = request.getParameter("calorieCount");
		int calorieCount = Integer.parseInt(calorieSlider);
		
        String[] selectedIngredients = request.getParameterValues("selectedIngredients");
        
        String ingredients = ","; 

        if (selectedIngredients != null) {
            for (String ingredient : selectedIngredients) {
            	
            	ingredients += ingredient;
            	ingredients += ",";
            }
        }
		if (vegCheck != null && vegCheck.equals("on")) {
			isVeg = 1;
		}
		
		try {
            Connection conn = getDatabaseConnection();//getting DB connection
            
            String query = "SELECT COUNT(*) FROM Meals";
            PreparedStatement statement = conn.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();//Getting no of meals already in data base
            int rowCount = 0;
            if (resultSet.next()) {
                rowCount = resultSet.getInt(1);
                rowCount+=1;//Increases by 1 so we have now have the primary key of the new entry
            }
            //Inserting new record
            String sql = "INSERT INTO Meals (dishName, calorieCount, isVeg, dishType, dishID, ingredients) VALUES (?, ?, ?, ?, ?, ?)";
            statement = conn.prepareStatement(sql);
            statement.setString(1, dishName);
            statement.setInt(2, calorieCount);
            statement.setInt(3,  isVeg);
            statement.setString(4, type);
            statement.setInt(5,  rowCount);
            statement.setString(6,  ingredients);
            int rowsInserted = statement.executeUpdate();
            statement.close();
            conn.close();
            resultSet.close();//Closing open resources
            response.sendRedirect("cookbook.jsp");//Redirecting back to the cook book page

         
        } catch (SQLException e) {
            // Handle database errors
            e.printStackTrace();
            response.sendRedirect("cookbook.jsp");
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

