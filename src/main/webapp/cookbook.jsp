<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">

<!--  jQuery Data Tables CSS -->
<!-- jQuery Data Tables JS -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">

<title>Cookbook</title>
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

#formStyle label{
display: inline-block;''
width: 20%;
padding-left: 40px;
}





input[type=submit] {
  width: 100%;
  background-color: #e82c4b;
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

#dataTable {
            width: 100%;
            border-collapse: collapse;
        }

        #dataTable th,
        #dataTable td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        #dataTable th {
            background-color: #f2f2f2;
        }

        #dataTable tr:hover {
            background-color: #f5f5f5;
            tr:nth-child(even) {background-color: #f2f2f2;}
        }

        #dataTable_filter {
            float: right;
            margin-bottom: 10px;
        }
        
        .slider {
  -webkit-appearance: none;
  width: 100%;
  height: 15px;
  border-radius: 5px;
  background: #f7f0f0;
  outline: none;
  opacity: 0.7;
  -webkit-transition: .2s;
  transition: opacity .2s;
}

.slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 25px;
  height: 25px;
  border-radius: 50%;
  background: #ba1a1a;
  cursor: pointer;
}

.slider::-moz-range-thumb {
  width: 25px;
  height: 25px;
  border-radius: 50%;
  background: #d44848;
  cursor: pointer;
}
#submitButton{
	background-color: #e84343;
	font-size: 18px;
	box-shadow: 10px 10px 5px #aaaaaa;


}

#submitButton:hover{
	background-color: #f55858;
}


#editButton{
	background-color: #286dc7;

}


#editButton:hover{
	background-color: #45a049;
	
}

.button2 {
  background-color: #bd2bc2;
  border: none;
  color: white;
  padding: 2px 2px;
  text-align: center;
  font-size: 14px;
  margin: 4px 2px;
  transition: 0.3s;
  display: inline-block;
  text-decoration: none;
  cursor: pointer;
  border-radius: 12px;
  width: 9%;
  height: 5%;
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
 
  
  
}
.button2:hover {
	background-color: #ea4af0;
}

.box{
	width: 225px;
    height: 230px;
    background-color: #fcc7d1;
    position: absolute;
    border-top-right-radius: 20px;
    border-bottom-right-radius: 20px;
}

.popup {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
    z-index: 1;
    overflow: auto;
}

.popup-content {
    background-color: #f7f0f0;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #ba1a1a;
    border-radius: 5px;
    width: 60%;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
    position: relative;
    text-align: center;
}

.close {
    position: absolute;
    top: 0;
    right: 0;
    padding: 10px;
    cursor: pointer;
}

/* Add a smooth transition effect */
.popup {
    transition: all 0.3s;
}

/* Center the popup vertically and horizontally */
.popup-content {
    transform: translate(0%, 50%);
    text-align: center;
    margin: 15% auto 15% auto;
}

.ingredient-checkbox {
    display: block; /* Ensure checkboxes are displayed in a block format */
    margin-bottom: 10px;
}

/* Style the checkbox input */
.ingredient-checkbox input[type="checkbox"] {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    width: 18px;
    height: 18px;
    border: 2px solid #333;
    border-radius: 4px;
    vertical-align: middle;
    margin-right: 10px;
    cursor: pointer;
}

/* Style the checkbox when checked */
.ingredient-checkbox input[type="checkbox"]:checked {
    background-color: #45a049; /* Change this color to your preferred color */
    border: 2px solid #45a049; /* Change this color to your preferred color */
}

/* Style the label text for the checkboxes */
.ingredient-checkbox label {
    font-size: 16px;
    display: inline-block;
    vertical-align: middle;
    margin-right: 10px;
}

/* Add space between individual checkboxes and labels */
.ingredient-checkbox {
    margin-bottom: 10px;
}

/* Additional spacing for the checkbox label text */
.ingredient-checkbox label {
    padding-left: 5px;
}

/* 

/* Style for the "Cancel" button */
.buttonI[type="button"] {
    background-color: #bd2bc2;
    border: none;
    color: white;
    padding: 8px 16px;
    font-size: 16px;
    margin-top: 10px;
    cursor: pointer;
    border-radius: 5px;
}

.buttonI[type="button"]:hover {
    background-color: #ea4af0;
}



        
</style>
<!--  jQuery Data Tables CSS -->
<!-- jQuery Data Tables JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

</head>

<body>

<img style="position: absolute; top: 12%; width: 50%; left: 20%;"" src="images/cookbook1.png" >

<div style="position: absolute; border-top: 5px solid #000; bottom: 0%; width: 99%; height: 25%; background-color: #fcc7d1"></div>

<div id="mySidenav" class="sidenav">
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="index.jsp">Home</a>
  <a href="generate.jsp">Meal Plan</a>
  <a href="cookbook.jsp">Cookbook</a>
  <a href="ingredients.jsp">Ingredients Hub</a>
  <a href="shopping.jsp">Shopping List</a>
</div>

<span style="font-size:50px;cursor:pointer;top:0%;" onclick="openNav()">&#9776;</span>

<h1 style="text-align: center; font-size: 45px; font-family: Impact; position: absolute; top: 0%; left: 43%">Cookbook</h1><br>

<br>
<table style="width: 46%; position: absolute; left: 22%; top: 37%" border="2" id="dataTable">
  <thead style="background-color: #8148c2;" >
  	<th >Name</th>
    <th>Calories</th>
    <th>Vegetarian</th>
    <th>Type</th>

  </thead>
  <tbody>
  <%
  //Establishing Database Connection
  String jdbcUrl = "jdbc:mysql://localhost:3306/MealBase";  
  String username = "root";
  String password = "hello@123";
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet resultSet = null;

  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, username, password);
      stmt = conn.prepareStatement("SELECT * FROM Meals"); //Getting all meals 
      resultSet = stmt.executeQuery();
      String tableRows = "";
      
      while (resultSet.next()){
    	  int id = resultSet.getInt("dishID");
    	  String name = resultSet.getString("dishName");
    	  int calories = resultSet.getInt("calorieCount");
    	  int vegBool = resultSet.getInt("isVeg");
    	  String type = resultSet.getString("dishType");
    	  String isVeg = "No";
    	  if(vegBool == 1){
    		  isVeg = "Yes";
    	  }
    	  tableRows += "<tr><td><a href='editDish.jsp?id=" +
    	  id + "' style='text-decoration: none; color: #333;' >" + 
    	  name + "</td><td>" + calories + "</td><td>" + isVeg + "</td><td>" + 
    	  type + "</td>";
    	  
    	  tableRows += "</tr>";
      }
      out.println(tableRows);
  } catch (Exception e) {
      out.println("Error: " + e.getMessage());
  }
  finally{
	  conn.close();
	  stmt.close();
	  resultSet.close();
  }  
  %>
  </tbody>
</table>

<script>
$(document).ready(function() {
    $('#dataTable').DataTable();
});
</script>
<script>

function createDataTable() {
    var dataTable = document.getElementById('dataTable');  
    // Convert the table into a DataTable
    var dataTableObj = new window.DataTable(dataTable);

    // Add search functionality
    searchInput.addEventListener('input', function () {
        dataTableObj.search(this.value).draw();
    });
}

// Call the function to create the DataTable with search and show entries
//createDataTable();
</script>

<div style="position: absolute; background-color: #FFFFFF; height: 20%; width: 20%; top: 10%;">
</div>

<br><br>

<form action="insertMeal" method="post">
	<label style="top: 82%; left: 32%; position: absolute;" class="container">Vegetarian<input type="checkbox" name="vegCheck">
	  <span class="checkmark"></span>
	</label>
	
	<div style="position: absolute; left: 2%; top: 80%;">
	<label for="user" style="font-size: 22px;">Dish name: </label>
		<input style="font-size: 18px;" type="text" name="dishName" required><br>
	</div>
	
	<div style="width: 20%; top: 77%; left: 73%; position: absolute;"class="slidecontainer" >
		<p style="font-size: 22px;">Total Calorie Count</p>
	  <input type="range" min="1" max="100" value="50" class="slider" name="calorieCount" id="myRange">
	  <p>Count: <span id="demo"></span></p>
	</div>
	
	<div style="position: absolute; top: 81%; left: 50%;">
		<label style="font-size: 22px;" for="type">Meal Type: </label>
			<select style="font-size: 18px;" name="type" id="type" required>
				<option value="Breakfast">Breakfast</option>
				<option value="Lunch">Lunch</option>
				<option value="Dinner">Dinner</option>
				<option value="Lunch/Dinner">Lunch/Dinner</option>
			</select>
	</div>
	
	<div  style="position: absolute; top: 91%; left: 6%;">
	<button type="button" class="buttonI"  onclick="toggleIngredientsSection()">Choose Ingredients</button>
	</div>
	
	<div id="ingredientSection" class="popup">
		<div class="popup-content">
	        <span class="close" onclick="toggleIngredientsSection()">&times;</span>
	        <h2>Select Ingredients</h2>
	   
	   
	            <!-- Retrieve and display ingredients from your database -->
	            <%
	                // Add your code to fetch ingredients from the database here
	                // Example code: 
	                
	  
	  				conn = null;
	  				stmt = null;
	  				resultSet = null;
	
	                try {
	                    Class.forName("com.mysql.cj.jdbc.Driver");
	                    conn = DriverManager.getConnection(jdbcUrl, username, password);
	                    stmt = conn.prepareStatement("SELECT * FROM Ingredients");
	                    resultSet = stmt.executeQuery();
	
	                    while (resultSet.next()) {
	                        String ingredientName = resultSet.getString("ingredientName");
	            %>
	                        <!-- Display ingredients as checkboxes -->
	                        
	                        
	                        <label class="ingredient-checkbox">
            					<input type="checkbox" name="selectedIngredients" value="<%= ingredientName %>">
            					<%= ingredientName %>
       						 </label>
        					<br>
	            <%
	                    }
	                } catch (Exception e) {
	                    out.println("Error: " + e.getMessage());
	                } finally {
	                    conn.close();
	                    stmt.close();
	                    resultSet.close();
	                }
	            %>
	            <button type="button" class="buttonI" onclick="toggleIngredientsSection()">OK</button>
	            
            </div>
        </div>
	
	
	<input style="width: 20%; position: absolute; left: 37%; top: 92%; " id="submitButton" type="submit" value="Add Dish">
	
	<script>
        function toggleIngredientsSection() {
            var ingredientSection = document.getElementById("ingredientSection");
            if (ingredientSection.style.display === "none") {
                ingredientSection.style.display = "block";
            } else {
                ingredientSection.style.display = "none";
            }
        }
    </script>
	<script>
	var slider = document.getElementById("myRange");
	var output = document.getElementById("demo");
	output.innerHTML = slider.value;
	
	slider.oninput = function() {
	  output.innerHTML = this.value;
	}
	</script>
</form>
 
<div id="box" style="left: 0%; top:18%;;"class="box"></div>

<a href="ingredients.jsp">
	<img style="position: absolute; top: 25%; width:15%; height: 23%;" src="images/ingredient.png" >
	<button class="button2" style="top: 20%; left: 3%; position: absolute;">Ingredient Hub</button>
</a >





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