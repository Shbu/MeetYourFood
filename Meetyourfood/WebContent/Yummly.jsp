<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript">
function get(){
	  
	  var e = document.getElementById("course");
	  var strUser = e.options[e.selectedIndex].value;

	  var ep = document.getElementById("cuisine");
	  var strUserw = ep.options[ep.selectedIndex].value;
	  
	  
$.ajax({
	  type: "GET",
	  url: "http://api.yummly.com/v1/api/recipes?_app_id=213bfb0c&_app_key=72e70f83283841e346d6902693eb92ff&q="+document.getElementById("dish").value+"&requirePictures=true&allowedCourse[]=course^course-"+strUser+"&allowedDiet[]=392^Vegetarian&allowedCuisine[]=cuisine^cuisine-"+strUserw,
	  jsonpCallback: 'callback',
	  contentType: "application/json",
	  async: false,
	  dataType: "jsonp",
	  success: function(data) {
		  //alert("hi");
		    var pl="<table>";
		 JSON.stringify(data.matches);
		  //alert(data.attribution);
		  $.each(data.matches, function(index,client) {
			  //alert(client.recipeName+" "+client.smallImageUrls);
			  var pr="<b>Ingredients:</b> ";
			  for(var i=0;i<client.ingredients.length;i++)
				  {
				   pr = pr+ client.ingredients[i]+"<br>";
					   
				  }
			  pl=pl+"<tr><td>"+client.recipeName+"</td></tr> <tr style=\"border:2px solid black;\"><td style=\"height:120px;width:90px;\"><img alt=\"food\" src=\""+client.smallImageUrls+"\"/></td><td style=\"word-wrap:break-word;height:120px;\">"+pr+"</td>";
			  
			  //alert(pl);
			   
		  });
		  pl=pl+"</table>";
		  $('#recipes').html(pl);
	  }
	});
}
	    </script>

</head>
<body>
<div id="options">

<input type="text" id="dish" style="height:20px;width:110px;border-radius:5px;"/>
<select id="course" style="height:20px;width:110px;border-radius:5px;">
<option value="Main Dishes">Main Dishes</option>
<option value="Desserts">Desserts</option>
<option value="Side Dishes">Side Dishes</option>
<option value="Lunch and Snacks">Lunch and Snacks</option>
<option value="Appetizers">Appetizers</option>
<option value="Salads">Salads</option>
<option value="Breads">Breads</option>
<option value="Breakfast and Brunch">Breakfast and Brunch</option>
<option value="Soups">Soups</option>
<option value="Beverages">Beverages</option>
<option value="Condiments and Sauces">Condiments and Sauces</option>
<option value="Cocktail">Cocktail</option>
</select>

<select id="cuisine" style="height:20px;width:110px;border-radius:5px;">
<option value="American">American</option>
<option value="Italian">Italian</option>
<option value="Asian">Asian</option>
<option value="Mexican">Mexican</option>
<option value="French">French</option>
<option value="Southwestern">Southwestern</option>
<option value="Barbecue">Barbecue</option>
<option value="Indian">Indian</option>
<option value="Chinese">Chinese</option>
<option value="English">English</option>
<option value="Mediterranean">Mediterranean</option>
<option value="Greek">Greek</option>
<option value="Spanish">Spanish</option>
<option value="German">German</option>
<option value="Thai">Thai</option>
<option value="Japanese">Japanese</option>
</select>
<input type="button" style="margin-top:2%;border-radius:5px;" value="Search" onclick="get();"/>
<img src="http://static.yummly.com/api-logo.png"/>
</div>
<div id="recipes">

</div>

</body>
</html>
