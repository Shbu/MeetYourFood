<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="Servlet.Amzaon" language="java" %>
<!DOCTYPE HTML>
<html>
  <head>
	  <title>Meet Your Food | Host</title>
	  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	  <link href="css/style.css" rel="stylesheet" type="text/css"  media="all" />
	  <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
	  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	  <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script> 
  <script type="text/javascript" src="js/jquery.easing.1.3.js"></script> 
  <script type="text/javascript" src="js/tabs.js"></script>
  <script type="text/javascript" src="js/camera.min.js"></script>
  <script src="http://platform.fatsecret.com/js?key=783510b2f98c46f9abefa3fca16797e2&theme=grey&auto_nav=false"></script>

  <script> 
fatsecret.setContainer("tabpage_4"); 
fatsecret.setCanvas("home"); 
</script>

  <script type="text/javascript">
  $(document).ready(function() {  
	    
	  
	  $("#search_button").click(function(){
		 
		 if (document.getElementById('search').value=='') 
			 {
			 alert("Kindly Enter name of ingredient");
			 }
		 else
			 {
			 var url = "Amzaon?ingredient_type="+document.getElementById('search').value;
			 $('#amazon').attr('src',url);
			 }
	  });
	  
	  
	    $("#Step1").click(function(){
	    	//document.getElementById("step").innerHTML = "Step 2:";
	    	
	        $('#hilarious').animate({
	        	"margin-top":'-45%',
	        	"z-index":'0'
	        },"slow");
	   
	        
		    $('#hilarious1').animate({
	        	"margin-top":'10%',
	        	"z-index":'0'
	        },"slow");
		    
	      });
	    $("#back").click(function(){
	    	
	    	//document.getElementById("step").innerHTML = "Step 1:";
	        $('#hilarious').animate({
	        	"margin-top":'10%',
	        	"z-index":'0'
	        },"slow");
	   
	        
		    $('#hilarious1').animate({
	        	"margin-top":'70%',
	        	"z-index":'0'
	        },"slow");
		    
	      });
    	
      });
	      
  </script>
 </head>
	<body>
	

	
	
	<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
  FB.init({
    appId      : '1482052032023494',
    status     : true, // check login status
    cookie     : true, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
   
  });

  // Here we subscribe to the auth.authResponseChange JavaScript event. This event is fired
  // for any authentication related change, such as login, logout or session refresh. This means that
  // whenever someone who was previously logged out tries to log in again, the correct case below 
  // will be handled. 
  
  
  
  FB.Event.subscribe('auth.authResponseChange', function(response) {
    // Here we specify what we do with the response anytime this event occurs. 
    if (response.status === 'connected') {
      // The response object is returned with a status field that lets the app know the current
      // login status of the person. In this case, we're handling the situation where they 
      // have logged in to the app.
      testAPI();
      
    } else if (response.status === 'not_authorized') {
      // In this case, the person is logged into Facebook, but not into the app, so we call
      // FB.login() to prompt them to do so. 
      // In real-life usage, you wouldn't want to immediately prompt someone to login 
      // like this, for two reasons:
      // (1) JavaScript created popup windows are blocked by most browsers unless they 
      // result from direct interaction from people using the app (such as a mouse click)
      // (2) it is a bad experience to be continually prompted to login upon page load.
    	FB.login(function(response) {
    		   // handle the response
    		 }, {scope: 'email,user_likes'});
      
    } else {
      // In this case, the person is not logged into Facebook, so we call the login() 
      // function to prompt them to do so. Note that at this stage there is no indication
      // of whether they are logged into the app. If they aren't then they'll see the Login
      // dialog right after they log in to Facebook. 
      // The same caveats as above apply to the FB.login() call here.
    	FB.login(function(response) {
    		   // handle the response
    		   
    		   
    		 }, {scope: 'email,user_likes'});
      
    }
  });
  
  
  function getUserInfo(){
	  FB.api('/me/picture?width=64&height=64',function(response){
		 document.getElementById("myimg").setAttribute("src", response.data.url);
		 $('#myimg').css("display","block");
		 $('#myimg_').css("display","block");
		 $('#myimg').css("background",response.data.url);
		  
	  });
	  
	  FB.api('/me',function(response){
		  document.getElementById("username").value = response.name;
		  document.getElementById("Username").innerHTML = "Welcome,"+response.name;
		  
		  
			// alert("name:"+response.name+" age:"+response.birthday+" gender:"+response.gender);
			  
		  });
	  
	  
  }
  
  FB.Event.subscribe('auth.statusChange', function(response) {
	  if (response.status === 'connected') {
	    // the user is logged in and has authenticated your
	    // app, and response.authResponse supplies
	    // the user's ID, a valid access token, a signed
	    // request, and the time the access token 
	    // and signed request each expire
	    var uid = response.authResponse.userID;
	    var accessToken = response.authResponse.accessToken;
	   //document.getElementById("Login").setAttribute("value", "Logout");
	   $('#social_login').css("display","none");
	   $('#social_logout').css("display","block");
	   //$('#google').css("display","none");
	   //document.getElementById("FBLogin").setAttribute("onClick", "FB.logout()");
	  //document.getElementById("Login").setAttribute("onClick", "FB.logout()");

	    FB.login(function(response) {
 		   // handle the response
 		   if(response.authResponse)
 			   {
 			 
 			   getUserInfo();
 			   }
 			   
 		   
 		 }, {scope: 'email,user_photos,publish_actions,user_birthday'});
	    
	    
	    
	    //alert("running"+uid);
	  } else if (response.status === 'not_authorized') {
	    // the user is logged in to Facebook, 
	    // but has not authenticated your app
		  //alert("running1");
	  } else {
	    // the user isn't logged in to Facebook.
		  //alert("running2");
	   $('#social_logout').css("display","none");
	    $('#social_login').css("display","block");
	    $('#myimg').css("display","none");
		 $('#myimg_').css("display","none");
	   
	   //$('#google').css("display","block");
	    document.getElementById("Username").innerHTML = " ";
		  document.getElementById("FBLogin").setAttribute("onClick", "FB.login()");
		  //document.getElementById("Login").setAttribute("value", "Logout");
		  //document.getElementById("profileImage").setAttribute("src", "");
	  }
	 });
  
  
  
 };

  // Load the SDK asynchronously
  (function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
  }(document));

  // Here we run a very simple test of the Graph API after login is successful. 
  // This testAPI() function is only called in those cases. 
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Good to see you, ' + response.name + '.');
    });
    
    
    
    
  }
  
  function Display()
  {
	  //alert("hi");
	  $('.callout').css("display","block");
	
  }
</script>
	<!----start-header----->
	  <div class="header">
	     <div class="wrap">
			<div class="top-header">
				<div class="logo">
					<img src="images/Picture1.png" style="height:96px;width:96px;float:left;"/>
					<a href="index.html" style="color:#D69F17; margin-top:20px; font-size:45px;float:left; position:absolute;font-family:harlow solid italic">MeetYourFood</a>
					
				</div>
				<div class="social-icons"  >
					<ul id="social_login">
					
						<li><a  onClick="FB.login()" href="javascript:void(0);"><img src="images/facebook.png" title="facebook" /></a></li>
						<li id="twitter"><a href="#"><img src="images/twitter.png" title="twitter" /></a></li>
						<li id="google"><a href="#"><img src="images/google.png" title="google pluse" /></a></li>
							
					</ul>
				
					<div style="display:inline;">
					<a href="About.jsp"><img class="circular" id="myimg" style="display:none; margin-left:30px; float:left;"" src="" alt="link" /></a>
					
					<a href="Javascript:void(0);" onClick="FB.logout()" ><p id="myimg_"style="display:none; color:white; margin-top:20px;margin-left:10px;height:64px;width:64px;float:left;position:relative;" alt="link"> Sign Out </p></a>
					</div>
					
					<div id="Username" style="margin-top:60px; float:right; font-family:Segoe ui light; color:white;position:absolute;"> </div>
					
				</div>
				<div class="clear"> </div>
			</div>
			<!---start-top-nav---->
			<div class="top-nav">
				<div class="top-nav-left">
					<ul>
						<li><a href="Facebook.jsp">Home</a></li>
						
						<li><a href="Guest.jsp">Analysis</a></li>
						<li > <a href="Host.jsp">Host</a></li>
						<li><a href="contact.html">Contact</a></li>
						<div class="clear"> </div>
					</ul>
				</div>
				<div class="top-nav-right">
					<form>
						<input type="text"><input type="submit" value="" />
					</form>
				</div>
				<div class="clear"> </div>
			</div>
			<!---End-top-nav---->
		</div>
	</div>
   <!----End-header----->
   
		<div style="margin-top:0px;background-image:url('images/dining.jpg');height:508px;">
		
		<div id="tabContainer">
						<div class="tabs"style="z-index:100;">
						<ul>
						<li class="tabActiveHeader" id="tabHeader_1" style="float:left;margin-left:60%;margin-top:2%;z-index:100;border-radius:10px;">Create an Event</li>
						<li id="tabHeader_2" style="float:left;margin-left:10px;margin-top:2%;border-radius:10px;">Ingredients</li>
						<li id="tabHeader_3" style="float:left;margin-left:10px;margin-top:2%;border-radius:10px;">Recipes</li>
						<li id="tabHeader_4" style="float:left;margin-left:10px;margin-top:2%;border-radius:10px;">Recipe Analysis</li>
						</ul>
						</div>
				      <div id="clear" ></div>
				      <div class="tabscontent">
					
		<div class="tabpage" id="tabpage_1" style="overflow:hidden;float:right;position:absolute;margin-left:60%;z-index:10;margin-top:2%;background:#ffffff;width:36%;border-radius:10px;height:62%;"></br>				
		<Form method="GET" action="Connect" >
		<div id="hilarious" style="z-iindex:20;margin-top:10%;margin-left:10%;">
		<table >
		<tr>
		<td style="color:black;">Name:</td><td><input type="text" name="username" style="color:black;" id="username"></input></td></tr>
		<tr><td style="color:black;">Title:</td> <td><input name="title" id="title" type="text" /></td></tr>
		<tr><td style="color:black;">City:</td> <td> <input name = "city" id="city" type ="text" /> </td></tr>
		<tr> <td style="color:black;">County:</td> <td><input name="county" id="county" type="text" /></td></tr>
		<tr> <td style="color:black;"> Country:</td> <td> <input name="country" id="country" type="text" /></td></tr>
		<tr/>
		<tr><td> </td> <td> <input id="Step1" type="button" value="Next" style="border-radius:10px;color:#4a4444;background:white"></td></tr>
		</table>
		</div>
		
		<div id="hilarious1" style="z-iindex:20;margin-top:60%;margin-left:10%;">
		<table >
		<tr><td style="color:black;">Meal Type:</td> <td> <input name="Mealtype" type ="text"/> </td></tr>
		<tr><td style="color:black;">Meal Details:</td><td> <textarea name="MealDetails" rows="4" cols="16"> </textarea></td></tr>
		<tr><td style="color:black;">MEAL INGD1: </td> <td> <input name="ming1" type ="text"/> </td></tr>
		<tr> <td style="color:black;"> MEAL INGD2: </td> <td> <input  name="ming2" type="text"/> </td></tr>
		<tr> <td style="color:black;"> MEAL INGD3: </td> <td> <input name="ming3" type ="text"/> </td></tr>
		<tr> <td style="color:black;"> MEAL INGD4: </td> <td> <input name="ming4" type="text"/></td></tr>
		<tr> <td style="color:black;"> MEAL INGD5: </td> <td>  <input name="ming5" type ="text"/> </td></tr>
		<tr><td style="color:black;"> ALCOHOL SERVED: </td> <td>  <input name="alchser" type="text"/></td></tr>
		<tr> <td><input id="back" type="button" style="border-radius:10px;color:#4a4444;background:white" value="Back"> </td> <td> <input type="submit" name="Submit" style="border-radius:10px;color:#4a4444;background:white"value="Submit"></td></tr>
		</table>
		</div>
		</Form>
		</div>
		
<div class="tabpage" id="tabpage_2" style="overflow:hidden;float:right;position:absolute;margin-left:60%;z-index:10;margin-top:2%;background:#ffffff;width:36%;border-radius:10px;height:60%;"> 
<div style="display:inline;"> <input id="search" style="margin-top:2%;border-radius:5px;" type="text"> <input style="margin-top:2%;border-radius:5px;" id="search_button" type="button" value="Search">
<img style="height:60px;width:90px;"src="images/amazon.png"/> </div>
<iframe id="amazon" style="height:100%;width:100%;" src="Amzaon?ingredient_type=chocolate"></iframe>
</div>
<div class="tabpage" id="tabpage_3" style="overflow:hidden;float:right;position:absolute;margin-left:60%;z-index:10;margin-top:2%;background:#ffffff;width:36%;border-radius:10px;height:62%;"></br>
<iframe id="amazon" style="height:100%;width:100%;" src="Yummly.jsp"></iframe>
</div>
<div class="tabpage fatsecret_container" id="tabpage_4" style="overflow:scroll;float:right;position:absolute;margin-left:60%;z-index:10;margin-top:2%;background:#ffffff;width:36%;border-radius:10px;height:62%;"></br>				
</div>				
</div>
	
		
		
		
		 <!---End-footer---->
	</body>
</html>