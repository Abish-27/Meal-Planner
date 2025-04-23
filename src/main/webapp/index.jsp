<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Meal Planner</title>
<link rel="stylesheet" href="styles.css">

<style>

#dataTable tr:hover {
            background-color: #f5f5f5;
            tr:nth-child(even){background-color: #f2f2f2;}
        }
.button1 {
  background-color: #17c267;
  border: none;
  color: white;
  padding: 26px 22px;
  text-align: center;
  font-size: 25px;
  margin: 4px 2px;
  transition: 0.3s;
  display: inline-block;
  text-decoration: none;
  cursor: pointer;
  border-radius: 60%;
  width: 20%;
  height: 10%;
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  
  
}

.button1:hover {
	background-color: #2deb85;
}

.button2 {
  background-color: #3c7bde;
  border: none;
  color: white;
  padding: 16px 22px;
  text-align: center;
  font-size: 20px;
  margin: 4px 2px;
  transition: 0.3s;
  display: inline-block;
  text-decoration: none;
  cursor: pointer;
  border-radius: 12px;
  width: 15%;
  height: 8%;
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
 
  
  
}
.button2:hover {
	background-color: #679ef5;
}

.button3 {
  background-color: #ba0725;
  border: none;
  color: white;
  padding: 16px 22px;
  text-align: center;
  font-size: 20px;
  margin: 4px 2px;
  transition: 0.3s;
  display: inline-block;
  text-decoration: none;
  cursor: pointer;
  border-radius: 12px;
  width: 15%;
  height: 8%;
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
 
  
  
}
.button3:hover {
	background-color: #de3552;
}

.button4 {
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
.button4:hover {
	background-color: #ea4af0;
}
body {
  background-image: url('images/back.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: 100% 100%;
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

<h1 style="text-align: center; font-size: 45px; font-family: Impact; position: absolute; top: 0%; left: 40%">Meal Planner</h1><br>
<a href="generate.jsp">
	<img style="position: absolute; top: 40%; width: 38%; left: 32%;" src="images/taco.png" >
	<button class="button1" style="top: 30%; left: 39%; position: absolute;">Meal Plan</button>
</a >

<a href="shopping.jsp">
<img src="images/list.png" style="width: 25%; position: absolute; top: 30%; left: 5%;"alt="Shopping List">

	<button class="button2" style="top: 19%; left: 10%; position: absolute;">Shopping List</button>
</a>

	
<a href="cookbook.jsp">
	<button class="button3" style="bottom: 39%; right: 3%; position: absolute;">Cookbook</button>
	 <img  style=" position: absolute; bottom: 1%; right: 1%; width: 20%;" src="images/book.png" alt="Cookbook">
</a>

<a href="ingredients.jsp">
	<img style="position: absolute; top: 75%; width:15%; height: 23%;" src="images/ingredient.png" >
	<button class="button4" style="top: 70%; left: 3%; position: absolute;">Ingredient Hub</button>
</a >

</body>
</html>