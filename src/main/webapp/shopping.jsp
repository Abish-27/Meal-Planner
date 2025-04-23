<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping List</title>
<link rel="stylesheet" href="styles.css">

<style>

/* Add your custom CSS styles here */
table {
    width: 70%;
    margin: 0 auto;
    border-collapse: collapse;
}

th, td {
    padding: 10px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
}

.mailImage {
  transition: transform 0.3s; /* Add a smooth transition effect */
}

.mailImage:hover {
  transform: scale(1.1); /* Enlarge the image by 10% when hovered */
  /* You can add more styles here to change the appearance as needed */
}

</style>

</head>
<body>


<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="index.jsp">Home</a>
  <a href="generate.jsp">Meal Plan</a>
  <a href="cookbook.jsp">Cookbook</a>
  <a href="ingredients.jsp">Ingredients Hub</a>
  <a href="#">Shopping List</a>
  
</div>

<span style="font-size:50px;cursor:pointer;" onclick="openNav()">&#9776;</span>
<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
<h1 style="text-align: center; font-size: 45px; font-family: Impact; position: absolute; top: 0%; left: 40%">Shopping List</h1><br>
<br><br>

<img src="images/blue.png" style="position: absolute; width:60%; left:22%; z-index: -1;">

  <%
  
  String jdbcUrl = "jdbc:mysql://localhost:3306/MealBase";  // Use your desired schema name here
  String username = "root";
  String password = "hello@123";
  
  
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;
  
  int[] IDs = new int[21];
  int count = 0;
  String ingredients;
  String[] allIngredients = new String[100];
  int[] quantity = new int[100];
  int total = 0;

  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, username, password);
      stmt = conn.prepareStatement("SELECT * FROM MealPlan");
      rs = stmt.executeQuery();
      
      while(rs.next()){
    	  IDs[count] = rs.getInt("dishID");
    	  count++;
      }
      
      StringBuilder queryBuilder = new StringBuilder("SELECT * FROM Meals WHERE dishID IN (");
      for (int i = 0; i < count; i++) {
          queryBuilder.append(IDs[i]);
          if (i < count - 1) {
              queryBuilder.append(",");
          }
      }
      queryBuilder.append(")");
      
      stmt = conn.prepareStatement(queryBuilder.toString());
      rs = stmt.executeQuery();

      while (rs.next()) {
          ingredients = rs.getString("ingredients");
          if(!(ingredients.equals(",")) || !(ingredients.equals(" "))){
        	  String[] selectedIngredients = ingredients.split(",", 0);
        	  for(String x : selectedIngredients){
        		  if(x.equals(" ") || x.equals("")){
        			  continue;
        		  }
        		  else{
        			  boolean exists = false;
            		  for(int i=0; i<total; i++){
            			  if (allIngredients[i].equals(x)){
            				  int num = quantity[i];
            				  num += 1;
            				  quantity[i] = num;
            				  exists = true;
            				  break;
            			  }
            		  }
            		  if(!exists){
            			  allIngredients[total] = x;
            			  quantity[total] = 1;
            			  total++;
            		  }
        		  }
        		  
        	  }
          }
          
      }    
      
  } catch (Exception e) {
      out.println("Error: " + e.getMessage());
  }
  finally{
	  conn.close();
	  stmt.close();
	  rs.close();
  }
  String mailBody = "";
  %>
  
  <table style="position: absolute; width: 45%; top: 25%; left: 30%;">
    <tr>
        <th>Ingredient</th>
        <th style="text-align: right;">Quantity</th>
    </tr>
    <%
    for (int i = 0; i < total; i++) {
    	mailBody += allIngredients[i] + "%20x%20" + quantity[i] + "%0D%0A";
        %>
        <tr>
            <td><%= allIngredients[i] %></td>
            <td style="text-align: right;"><%= quantity[i] %></td>
        </tr>
        <%
    }
    %>
</table>
<a href="mailto:kulka108202@gapps.uwcsea.edu.sg?subject=Shopping%20List&body=<%=mailBody%>>">
<img src="images/blueMail.png" style="width: 8%; position: absolute; top: 20%; left: 85%;"alt="Mail Shopping List" class="mailImage">
</a>
</body>
</html>