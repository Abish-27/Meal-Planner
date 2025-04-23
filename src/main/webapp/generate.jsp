<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Meal Planner</title>
<link rel="stylesheet" href="styles.css">
<style>
input[type=text], [type=password], select {
  width: 60%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  
}

#formStyle {
  border-radius: 5px;
  margin: auto;
  width: 60%;
  box-shadow: 3px 3px 3px;
  background-color: #d5e5eb;
  padding: 4%;
  
}
#dataTable tr:hover {
            background-color: #f5f5f5;
            tr:nth-child(even){background-color: #f2f2f2;}
        }
        
 #dataTable th {
            background-color: #a8e3af;
            
        }

#formStyle label{
display: inline-block;
width: 20%;
padding-left: 40px;
}


#submitButton{
	background-color: #219c31;
	font-size: 18px;
	box-shadow: 10px 10px 5px #aaaaaa;


}

#submitButton:hover{
	background-color: #38cf4b;
}

input[type=submit] {
  width: 100%;
  background-color: #fc3550;
  color: white;
  padding: 14px 40px;
  margin: 8px 0;
  border: none;
  border-radius: 5px;
  cursor: pointer;

  
}

input[type=submit]:hover {
  background-color: #45a049;
}

.mailImage {
  transition: transform 0.3s; /* Add a smooth transition effect */
}

.mailImage:hover {
  transform: scale(1.1); /* Enlarge the image by 10% when hovered */
  /* You can add more styles here to change the appearance as needed */
}



</style>
<!--  jQuery Data Tables CSS -->
<!-- jQuery Data Tables JS -->


</head>

<body>

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="index.jsp">Home</a>
  <a href="generate.jsp">Meal Plan</a>
  <a href="cookbook.jsp">Cookbook</a>
  <a href="ingredients.jsp">Ingredients Hub</a>
  <a href="shopping.jsp">Shopping List</a>
</div>

<span style="font-size:50px;cursor:pointer;top:0%;" onclick="openNav()">&#9776;</span>

<h1 style="text-align: center; font-size: 45px; font-family: Impact; position: absolute; top: 0%; left: 40%">Meal Plan</h1><br>

<div>
<form action="mealGenerator" method="post">
<label style="top: 20%; left: 10%; position: absolute;"  class="container">Vegetarian<input name = "vegCheck" type="checkbox">
  <span class="checkmark"></span>
</label>

<div style="width: 20%; top: 15%; left: 70%; position: absolute;"class="slidecontainer">
	<p style="font-size: 22px;">Average Calorie Count</p>
  <input type="range" min="1" max="3000" value="50" class="slider" id="myRange">
  <p>Count: <span id="demo"></span></p>
</div>
<input style="width: 20%; position: absolute; left: 37%; top: 18%; " id="submitButton" type="submit" value="Generate">


<script>
var slider = document.getElementById("myRange");
var output = document.getElementById("demo");
output.innerHTML = slider.value;

slider.oninput = function() {
  output.innerHTML = this.value;
}
</script>
</form>


<table style="position: absolute; top: 40%"id="dataTable">
  <thead style="background-color: #a8e3af;" >
  	<th>Day</th>
    <th>Breakfast</th>
    <th>Lunch</th>
    <th>Dinner</th>
  </thead>
  <tbody>
  <%
  //Initialising Database Variables
  String mailBody = "";
  String jdbcUrl = "jdbc:mysql://localhost:3306/MealBase";  
  String username = "root";
  String password = "hello@123";
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet resultSet = null;

  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, username, password); //Connecting to database
      String[] Days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};   
      
      //Iterating Array Days, to print each day of the week one by one
      for(String day : Days){
    	  mailBody += "%0D%0A" + day + ":%20";//Creating body of mail to be sent to user containing plan
    	  //Selecting Meals assigned to that day and then ordering them by time; so breakfast, lunch then dinner
    	  stmt = conn.prepareStatement("SELECT * FROM MealPlan WHERE day = ? ORDER BY time");
    	  stmt.setString(1, day);
    	  resultSet = stmt.executeQuery();
    	  out.println("<tr>");
    	  out.println("<td>" + day + "</td>");
    	  while (resultSet.next()) {
    		  String dishName = resultSet.getString("dishName");
    		  mailBody+= dishName + ",%20";
              out.println("<td>" + dishName + "</td>");//outputing each dish in each table cell        
          }
    	  out.println("</tr>");  
      }
  } catch (Exception e) {
      out.println("Error: " + e.getMessage());//error handling
  }
  finally{
	  conn.close();
	  stmt.close();
	  resultSet.close();//closing open resources
  }%>
  </tbody>
</table>


</div>

<a href="mailto:kulka108202@gapps.uwcsea.edu.sg?subject=Meal%20Plan&body=<%=mailBody%>>">
<img src="images/greenMail.png" style="width: 6%; position: absolute; top: 85%; left: 85%;"alt="Mail Meal Plan" class="mailImage">
</a>

<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
</body>
</html>