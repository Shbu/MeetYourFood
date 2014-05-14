<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<table style="margin-left:20px;padding:5px;">
		<tr>
		<td style="color:white;">Username:</td><td><p style="color:white;" id="username"></p></td></tr>
		<tr><td style="color:white;">Title:</td> <td><input name="title" id="title" type="text" /></td></tr>
		<tr><td style="color:white;">City:</td> <td> <input name = "city" id="city" type ="text" /> </td></tr>
		<tr> <td style="color:white;">County:</td> <td><input name="county" id="county" type="text" /></td></tr>
		<tr> <td style="color:white;"> Country:</td> <td> <input name="country" id="country" type="text" /></td></tr>
		<tr/>
		<tr><td> </td> <td> <input id="Step1" type="button" value="Next" style="border-radius:10px;color:#4a4444;background:white"></td></tr>
		</table>
		
		<table style="margin-left:20px;padding:5px;">
		<tr><td style="color:white;">Meal Type:</td> <td> <input name="Mealtype" type ="text"/> </td></tr>
		<tr><td style="color:white;">Meal Details:</td><td> <textarea name="MealDetails" rows="4" cols="16"> </textarea></td></tr>
		<tr><td style="color:white;">MEAL INGD1: </td> <td> <input name="ming1" type ="text"/> </td></tr>
		<tr> <td style="color:white;"> MEAL INGD2: </td> <td> <input  name="ming2" type="text"/> </td></tr>
		<tr> <td style="color:white;"> MEAL INGD3: </td> <td> <input name="ming3" type ="text"/> </td></tr>
		<tr> <td style="color:white;"> MEAL INGD4: </td> <td> <input name="ming4" type="text"/></td></tr>
		<tr> <td style="color:white;"> MEAL INGD5: </td> <td>  <input name="ming5" type ="text"/> </td></tr>
		<tr><td style="color:white;"> ALCOHOL SERVED: </td> <td>  <input name="alchser" type="text"/></td></tr>
		<tr> <td><input id="back" type="button" style="border-radius:10px;color:#4a4444;background:white" value="Back"> </td> <td> <input type="submit" name="Submit" style="border-radius:10px;color:#4a4444;background:white"value="Submit"></td></tr>
		</table>


</body>
</html>