

import java.io.IOException;
import java.util.Random;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
/**
 * Servlet implementation class mealGenerator
 */
@WebServlet("/mealGenerator")
public class mealGenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mealGenerator() {
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
		String vegCheck = request.getParameter("vegCheck");
		boolean isVeg = false;
		if (vegCheck != null && vegCheck.equals("on")) {
			isVeg = true;
		}
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			Connection conn = getDatabaseConnection();
			
			//Wiping database first
			PreparedStatement truncate = null;
			String truncateQuery = "TRUNCATE TABLE MealPlan";
			truncate = conn.prepareStatement(truncateQuery);
			truncate.executeUpdate();
			
			//Getting all Meals
			stmt = conn.prepareStatement("SELECT * FROM Meals");
		    rs = stmt.executeQuery();
		    
		   
		    Dish[] breakfastList = new Dish[100];
		    Dish[] lunchList = new Dish[100];
		    Dish[] dinnerList = new Dish[100];
		    int bCount = 0;
		    int lCount = 0;
		    int dCount = 0;
		    
		   
		    while (rs.next()){
		    	int vegNum = rs.getInt("isVeg");
		    	//System.out.println(isVeg);
		    	//If statement to filter only Veg dishes
		    	if(!(isVeg) || (isVeg && (vegNum == 1))) {
		    	
		    		//Getting data for each meal
			    	boolean v = true;
			    	int i = rs.getInt("dishID");
			    	String n = rs.getString("dishName");
			    	int c = rs.getInt("calorieCount");
			    	if(vegNum == 0) {v = false;}
			    	String t = rs.getString("dishType");
			    	
			    	//Inserting dishes into arrays based on their type
			    	if(t.equals("Breakfast")) {
			    		breakfastList[bCount] = new Dish(i, n, c, v, t);
			    		bCount ++;
			    	}
			    	else if(t.equals("Lunch")) {
			    		lunchList[lCount] = new Dish(i, n, c, v, t);
			    		lCount ++;
			    	}
			    	else if(t.equals("Dinner")) {
			    		dinnerList[dCount] = new Dish(i, n, c, v, t);
			    		dCount ++;
			    	}
			    	else if(t.equals("Lunch/Dinner")) {
			    		lunchList[lCount] = new Dish(i, n, c, v, t);
			    		dinnerList[dCount] = new Dish(i, n, c, v, t);
			    		lCount ++;
			    		dCount ++;
			    	}				    	
		    	}		    	
		    }	
			//Calling a function to generate meal plan
		    Meal[] MealPlan = getMealPlan(conn, breakfastList, lunchList, dinnerList, bCount, lCount, dCount);
		    //Preparing SQL query statement to insert values
		    String insertQuery = "INSERT INTO MealPlan (dishID, dishName, day, time) VALUES (?, ?, ?, ?)";
		    PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
		    
		    //Inserting each value from the Meal Plan one by one
		    for(int i = 0; i < 21; i++) {
		    	insertStmt.setInt(1, MealPlan[i].getDishId()); // Set your values here
		    	insertStmt.setString(2, MealPlan[i].getDishName());
		    	insertStmt.setString(3, MealPlan[i].getDay());
		    	insertStmt.setString(4, MealPlan[i].getTime());	              
		    	insertStmt.executeUpdate();
		    }
			//Closing resources
			conn.close();
			truncate.close();
			insertStmt.close();
			//Redirecting user
			response.sendRedirect("generate.jsp");
			
		} catch (SQLException e) {
            // Handle database errors
            e.printStackTrace();
            //response.sendRedirect("cookbook.j");
        }
		finally {
			try {
				rs.close();
				stmt.close();
				
			}
			catch (SQLException e) {
	            e.printStackTrace();   
	        }
		}
		//response.sendRedirect("generate.jsp");
		
	}
	
	public Connection getDatabaseConnection() throws SQLException {
		String jdbcUrl = "jdbc:mysql://localhost:3306/MealBase";
		String username = "root";//User name to DB
		String password = "hello@123";//Password to DB
		
	    Connection connection = null;
	    try {
	        // Loading the JDBC driver 
	    	Class.forName("com.mysql.cj.jdbc.Driver");

	        // Establishing a connection using info above
	        connection = DriverManager.getConnection(jdbcUrl, username, password);
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	        throw new SQLException("JDBC driver not found.");//Error handling
	    }
	    return connection;//Returning connection to be used elsewhere
	}

	public Meal[] getMealPlan(Connection conn, Dish[] breakfastList, Dish[] lunchList, Dish[] dinnerList, int bCount, int lCount, int dCount) {
		Meal[] MealPlan = new Meal[21];//Initializing the array that will contain the final meal plan
		int planCount = 0;//No. of dishes in the meal plan
		String[] Days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};//String array for days of the week
		
		int[] randList = randomArray(0, bCount-1, 7);//Getting a random set of integers
		for(int i = 0; i < 7; i++) {//looping 7 times for 7 days of the week
			MealPlan[planCount] = new Meal(breakfastList[randList[i]].getDishId(), breakfastList[randList[i]].getDishName(), Days[i], "Breakfast" );
			planCount ++;//Using the random integers to create new Breakfast Meal objects and populate MealPlan Array
		}
		
		randList = randomArray(0, lCount-1, 7);//Getting a  new random set of integers
		for(int i = 0; i < 7; i++) {
			MealPlan[planCount] = new Meal(lunchList[randList[i]].getDishId(), lunchList[randList[i]].getDishName(), Days[i], "Lunch");
			planCount ++;//Using the random integers to create new Lunch Meal objects and populate MealPlan Array
		}
		
		randList = randomArray(0, dCount-1, 7);//Getting a new random set of integers
		for(int i = 0; i < 7; i++) {
			MealPlan[planCount] = new Meal(dinnerList[randList[i]].getDishId(), dinnerList[randList[i]].getDishName(), Days[i], "Dinner");
			planCount ++;//Using the random integers to create new Dinner Meal objects and populate MealPlan Array
		}
		return MealPlan;
	}
	
	public static int[] randomArray(int min, int max, int length) {
       
        int[] randomNumbers = new int[length];//Initializing array of given length

        for (int i = 0; i < length; i++) {//Iterating the array
        	//Using Math module and min/max to generate new random integer in array
            randomNumbers[i] = (int)Math.floor(Math.random() * (max - min + 1) + min);
        }
        return randomNumbers;
    }
}


