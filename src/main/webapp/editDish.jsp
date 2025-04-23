<%@ page  import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>JSP Project- Edit Data</title>
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

/* Style the checkbox container */
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
.recipieImage {
  transition: transform 0.3s; /* Add a smooth transition effect */
}

.recipieImage:hover {
  transform: scale(1.1); /* Enlarge the image by 10% when hovered */
  /* You can add more styles here to change the appearance as needed */
}

/* Style for the "OK" button in the popup */


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

</head>
<body bgcolor="#cef5f5">
<script>
function validateEntry(){
	var valid = true;
	var name = document.getElementById("name").value;
	var statusDesc = document.getElementById("statusDesc").value;
	var add = document.getElementById("add").value;
	var ifs = document.getElementById("ifs").value;
	
	var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if(!add.match(mailformat)){
		alert("Enter a valid email address");
		valid = false;
	}
	
	if(!(statusDesc === "Failure" || statusDesc === "Success")){
		alert("The Status Description can only be Success or Failure");
		valid = false;
	}
	
	
	var ifscFormat = /[ `!@#$%^&*()_+\-=\[\]{};:\\|,.<>\/?~]/;
	if(ifscFormat.test(ifs)){
		alert("The IFSC Code cannot contain any special characters");
		valid = false;
	}
	

	return valid;
}
</script>
<%
//Retrieve the 'id' parameter from the URL
String id = request.getParameter("id");

//Use the 'id' value in your JSP page as needed
//HttpSession session1 = request.getSession();
String jdbcUrl = "jdbc:mysql://localhost:3306/MealBase";  // Use your desired schema name here
String username = "root";
String password = "hello@123";

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
String name = "hello";
int calories = 9;
String isVeg = "";
String type = "";
String ingredients = "";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, username, password);
    stmt = conn.prepareStatement("SELECT * FROM Meals WHERE dishID = ?");
    stmt.setString(1, id);
    rs = stmt.executeQuery();
    String tableRows = "";
    
    while (rs.next()){
  	 
  	  name = rs.getString("dishName");
  	  calories = rs.getInt("calorieCount");
  	  int vegBool = rs.getInt("isVeg");
  	  type = rs.getString("dishType");
  	  ingredients = rs.getString("ingredients");
  	  isVeg = "No";
  	  if(vegBool == 1){
  		  isVeg = "Yes";
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
//onsubmit="return validateEntry()"
String[] selectedIngredients = ingredients.split(",", 0);

%>
<h1 style="text-align: center; font-size: 45px; font-family: Impact;"><u>Edit Dish</u></h1>

<div id="formStyle">
<h2 style="text-align: center; font-size: 35px; font-family: Impact;"><%= name %> </h2>

<form action="EditDish" method="post" >
	<label style="font-size: 22px;" for="name">Dish Name: </label>
	<input style="font-size: 15px;" type="text" name="name" id="name"  value="<%= name %>" required><br><br>
	
	
	<div >
		<label style="font-size: 22px;" for="type">Meal Type: </label>
			<select style="font-size: 15px;" name="type" id="type" "required>
				<option value="Breakfast">Breakfast</option>
				<option value="Lunch">Lunch</option>
				<option value="Dinner">Dinner</option>
				<option value="Lunch/Dinner">Lunch/Dinner</option>
			</select>
	</div><br>

	
	<label  style="font-size: 22px;" for="calories">Calories: </label>
	<input style="font-size: 15px;" type="text" name="calories" id="calories" value="<%= calories %>" required><br>
	<br><br>
	<label  class="container">Vegetarian<input type="checkbox" name="vegCheck" >
	  <span class="checkmark"></span>
	</label><br>
	
	<div  style="position: absolute; top: 65%; left: 35%;">
	<button type="button" class="buttonI"  onclick="toggleIngredientsSection()">View Ingredients</button>
	</div>
	
	<div id="ingredientSection" class="popup">
		<div class="popup-content">
	        <span class="close" onclick="toggleIngredientsSection()">&times;</span>
	        <h2>Edit Ingredients</h2>
	   
	            <!-- Retrieve and display ingredients from your database -->
	            <%
	                // Add your code to fetch ingredients from the database here
	                // Example code: 
	                
	  
	  				conn = null;
	  				stmt = null;
	  				rs = null;
	  				boolean shouldBeChecked = false;
	
	                try {
	                    Class.forName("com.mysql.cj.jdbc.Driver");
	                    conn = DriverManager.getConnection(jdbcUrl, username, password);
	                    stmt = conn.prepareStatement("SELECT * FROM Ingredients");
	                    rs = stmt.executeQuery();
	
	                    while (rs.next()) {
	                    	shouldBeChecked = false;
	                        String ingredientName = rs.getString("ingredientName");
	                        for(String s : selectedIngredients){
	                        	if(ingredientName.equals(s)){
	                        		shouldBeChecked = true;
	                        	}
	                        }
	        
	                        
	            %>
	          
	                        <label class="ingredient-checkbox">
    <input type="checkbox" name="selectedIngredients" value="<%= ingredientName %>" <%= shouldBeChecked ? "checked" : "" %>>
    <%= ingredientName %>
</label>
<br><br>

	            <%
	                    }
	                } catch (Exception e) {
	                    out.println("Error: " + e.getMessage());
	                } finally {
	                    conn.close();
	                    stmt.close();
	                    rs.close();
	                }
	            %>
	            <button type="button" class="buttonI" onclick="toggleIngredientsSection()">OK</button>
	            
            </div>
        </div>
	
	
	
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
	
	<input type="hidden" name="dishID"  value="<%= id %>" required><br>
	
	<input style="font-size: 15px;"type="submit" value="Update">

	<script>
	var slider = document.getElementById("myRange");
	var output = document.getElementById("demo");
	output.innerHTML = slider.value;
	
	slider.oninput = function() {
	  output.innerHTML = this.value;
	}
	</script>
</form>

<a href="javascript:void(0);" onclick="confirmAndSubmit(<%= id %>)">
	<img style="position: absolute; top: 16%; left: 75%; width:8%; height: 14%;" src="images/deleteIcon.png" >
</a >

<script>
function confirmAndSubmit(id) {
    // Show a confirmation dialog
    var confirmation = confirm("Are you sure you want to delete this dish?");
    
    if (confirmation) {
    
        window.location.href= "DeleteDish?id=" + id;
        	
        // OR
        // document.getElementById("your-form-id").submit(); // Replace with your form ID
    } else {
        // The user clicked "Cancel" (false), do nothing or handle as needed
    }
}
</script>

</div>
<a href="https://www.epicurious.com/search/<%=name%>>">
<img src="images/recipie.png" style="width: 8%; position: absolute; top: 60%; left: 85%;"alt="Mail Shopping List" class="mailImage">
</a>
<br><br>
</body>
