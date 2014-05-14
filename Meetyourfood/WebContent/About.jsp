<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<html>
<head>
  <title>Meet Your Food | Profile</title>
  <link rel="icon" href="images/Picture1.ico" type="image/x-icon">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link href="css/style.css" rel="stylesheet" type="text/css"  media="all" />
  <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script> 
  <script type="text/javascript" src="js/jquery.easing.1.3.js"></script> 
  <script type="text/javascript" src="js/camera.min.js"></script>
  <script type="text/javascript" src="js/tabs.js"></script>
  <script type="text/javascript" src="js/jquery.lightbox.js"></script> 
  <link rel="stylesheet" type="text/css" href="css/lightbox.css" media="screen" />
  <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
      <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB9x6T4twyQpLLivvNdHN4m_41FmatEH8U&sensor=false">
    </script>

<script type="text/javascript">
var geocoder;
  var map;
  function initialize() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(-34.397, 150.644);
    var mapOptions = {
      zoom: 8,
      center: latlng
    }
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
  }

  $(document).ready(function(){
  
	  initialize();
	  
  });
  
  
  function codeAddress(address) {
    //var address = document.getElementById("address").value;
    $('#yelp').attr('src',"Yelp?loc="+address);
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
        });
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  }
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
		//  alert (response.data.url);
		  document.getElementById("Username").innerHTML = "Welcome,"+response.name;
		  document.getElementById("Name").innerHTML = "Name: "+response.name;
		  document.getElementById("emailid").innerHTML = "Email ID: "+response.email;
		  document.getElementById("birthdate").innerHTML = "Birth Date: "+response.birthday;
		  document.getElementById("gender").innerHTML = "Gender: "+response.gender;
		  
			// alert("name:"+response.name+" age:"+response.birthday+" gender:"+response.gender);
			  
		  });
	  
	  FB.api('/me/picture?width=240&height=240',function(response){
			 document.getElementById("myimg_pic").setAttribute("src", response.data.url);
			  
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
						
						<li><a href="Guest.jsp">Be a Guest</a></li>
						<li><a href="Host.jsp">Be a Host</a></li>
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
		 <!---start-content---->
		 <div class="content">
		 	<!---start-about---->
		 	<div class="about-us">
		 			<div class="wrap">
						<div class="about-header" style="margin-left:20px;">
							<h3>Profile</h3>
							<div class="clear"> </div>
						</div>
					
					<div id="profile_pic" style="float:left;">
					<img id="myimg_pic" class="circular_1">
					</div>
						
						<div class="about-info" style="float:left;margin-left:30px; ">
						<p id="Name"></p>
						<p id="emailid"></p>
						<p id="birthdate"></p>
						<p id="gender"></p>
						<p>Level: Foodie </p>
						</div>
						<div class="Your recent activity" style="float:right;margin-right:20%;margin-top:-3%;">
						<h3 style="font-family: 'Open Sans', sans-serif;font-size: 1.5em; color: #4a4444; text-transform: uppercase;">Your Recent Activity</h3>
						<div id="tabContainer">
						<div class="tabs">
						<ul>
						<li class="tabActiveHeader" id="tabHeader_1" style="float:left;margin-left:10px;border-radius:10px;">Guest</li>
						<li id="tabHeader_2" style="float:left;margin-left:10px;border-radius:10px;">Host</li>
						</ul>
						</div>
				      <div id="clear" ></div>
				      <div class="tabscontent">
					<div class="tabpage" id="tabpage_1" style="border-radius:20px;border:1px solid gray;color:#ffffff;background:#4a4444; height:120px;width:450px;"></br>This is Guest Activity</div>	
					<div class="tabpage" id="tabpage_2" style="border-radius:20px;display:none;border:1px solid gray;color:#ffffff;background:#4a4444; height:120px;width:450px;"> </br>Host Activity</div>
						</div>				
						</div>
						</div>
					<div class="specials">
					<div class="specials-heading" style="margin-top:140px;position:absolute;margin-left:5px;">
						<h3>Today Events Destination</h3>
						<div class="clear"> </div>
					</div>
					<div class="clear"> </div>
					<div class="specials-grids" style="margin:40px;">
						<div class="special-grid">
							<select style="background:#4a4444;font-family:segoe ui light;color:white;width:900px;border-radius:20px;padding-left:4px;height:35px;"onchange="codeAddress(this.value)">
 							 <option value="San Jose, California,USA">Event 1</option>
  							<option value="San Francisco, California,USA">Event 2</option>
  							<option value="San Diego, California,USA">Event 3</option>
  							<option value="San Antonio, Texas,USA">Event 4</option>
							</select>
							
							<div id="map-canvas" style="float:left;width: 800px; height: 280px;"></div>
							<div style="overflow:scroll;margin-left:800px;border:2px solid gray;border-radius:5px;width: 435px; height: 280px;position:absolute;">
							Taxi For Guest
							<img style="height:30px;width:30px;" src="http://s3-media1.ak.yelpcdn.com/assets/2/www/img/e0bcd848f6ae/structural/header_logo.png">
							<br><iframe style="height:80%;width:100%;" id="yelp" src="Yelp?loc=San Jose"></iframe>
							</div>
							
						</div>
						<div class="clear"> </div>
					</div>
					<div class="clear"> </div>
					</div>
					</div>
					<div class="testmonials">
						<div class="wrap">
							<div class="testmonial-grid">
								<h3>TESTIMONIALS :</h3>
								<p>" Lorem ipsum dolor sit amet, consectetur adipiscing elit. In volutpat luctus eros ac placerat. Quisque erat metus, facilisis non felis eu, aliquam hendrrit quam. Donec ut lectus vel dolor adipiscing tincidunt. Ut auctor diam at est iaculis, vitae interdum magna sagittis."</p>
								<a href="#"> - Lorem ipsum</a>
							</div>
						</div>
					</div>
		 	<!---End-about---->
		 </div>
		 <!---End-content---->
		 <!---start-footer---->
		 <div class="footer">
		<div class="wrap">
			<div class="footer-grid">
				<h3>About us</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,  consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
				<a href="#">ReadMore</a>
			</div>
			<div class="footer-grid center-grid">
				<h3>Recent posts</h3>
				<ul>
					<li><a href="#">eiusmod tempor incididunt</a></li>
					<li><a href="#">adipisicing elit, sed</a></li>
					<li><a href="#">mod tempor incididunt ut</a></li>
					<li><a href="#">dipisicing elit, sed do</a></li>
					<li><a href="#">econsectetur adipisicing</a></li>
				</ul>
			</div>
			<div class="footer-grid twitts">
				<h3>Latest Tweets</h3>
				<p><label>@Lorem ipsum</label>dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
				<span>10 minutes ago</span>
				<p><label>@consectetur</label>dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
				<span>15 minutes ago</span>
			</div>
			<div class="footer-grid">
				<h3>DID YOU KNOW?</h3>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
				<a href="#">ReadMore</a>
			</div>
			<div class="clear"> </div>
		</div>
		<div class="clear"> </div>
	</div>
	<div class="copy-right">
		<div class="top-to-page">
						<a href="#top" class="scroll"> </a>
						<div class="clear"> </div>
					</div>
		<p>Design by <a href="http://w3layouts.com/"> W3layouts</a></p>
	</div>
		 <!---End-footer---->
	</body>
</html>

