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

<link rel="stylesheet" href="styles.css">

<title>Ingredient Hub</title>
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
  background: #731a96;
  cursor: pointer;
}
#submitButton{
	background-color: #bd2bc2;
	font-size: 18px;
	box-shadow: 10px 10px 5px #aaaaaa;


}

#submitButton:hover{
	background-color: #ea4af0;
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
	width: 225px;`
    height: 230px;
    background-color: #eba0a0;
    position: absolute;
    border-top-right-radius: 20px;
    border-bottom-right-radius: 20px;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

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

<span style="font-size:50px;cursor:pointer;" onclick="openNav()">&#9776;</span>
<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>

<h1 style="text-align: center; font-size: 45px; font-family: Impact; position: absolute; top: 0%; left: 40%">Ingredients Hub</h1><br>
<div style="position: absolute; border-top: 5px solid #000; bottom: 0%; width: 99%; height: 25%; background-color: #dfbae0"></div>

<br><br><br>
<table style="width: 10%; position: absolute; left: 45%; top: 32%;" border="2" id="dataTable">
  <thead style="background-color: #8148c2;" >
  	<th >Name</th>
  </thead>
  <tbody>
  <%
  String jdbcUrl = "jdbc:mysql://localhost:3306/MealBase";  // Use your desired schema name here
  String username = "root";
  String password = "hello@123";
  
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet resultSet = null;

  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, username, password);
      stmt = conn.prepareStatement("SELECT * FROM Ingredients");
      resultSet = stmt.executeQuery();
      String tableRows = "";
      
      while (resultSet.next()){
    	  int id = resultSet.getInt("ingredientID");
    	  String name = resultSet.getString("ingredientName");
    	  tableRows += "<tr><td>" + name + "</td>";
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


<!--  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>-->


<script>

function createDataTable() {
    var dataTable = document.getElementById('dataTable');

    
    
    // Convert the table into a DataTable
    var dataTableObj = new window.DataTable(dataTable);

    // Add search functionality
    searchInput.addEventListener('input', function () {
        dataTableObj.search(this.value).draw();
    });

    //Add show entries functionality
 
    
    
}

// Call the function to create the DataTable with search and show entries
//createDataTable();
</script>

<div style="position: absolute; background-color: #FFFFFF; height: 20%; width: 20%; top: 10%;">
</div>
</div>
<br><br>
<form action="AddIngredient" method="post">
	
	
	<div style="position: absolute; left: 37%; top: 81%;">
	<label for="user" style="font-size: 22px;">Name: </label>
		<input style="font-size: 18px;" type="text" name="ingredientName" required><br>
	</div>
	
	
	
	<input style="width: 20%; position: absolute; left: 37%; top: 92%; " id="submitButton" type="submit" value="Add Ingredient">
	
	
	<script>
	var slider = document.getElementById("myRange");
	var output = document.getElementById("demo");
	output.innerHTML = slider.value;
	
	slider.oninput = function() {
	  output.innerHTML = this.value;
	}
	</script>
</form>

</body>
</html>