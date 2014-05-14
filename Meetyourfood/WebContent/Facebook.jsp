<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Meet Your Food | Home</title>
<link rel="icon" href="images/Picture1.ico" type="image/x-icon">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link href="css/style.css" rel="stylesheet" type="text/css"   />
  <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
  <link href="css/slider.css" rel="stylesheet" type="text/css"  media="all" />
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
  <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="js/jquery.easing.1.3.js"></script> 
  <script type="text/javascript" src="js/camera.min.js"></script>
  <script type="text/javascript" src="js/jquery.lightbox.js"></script> 
  <link rel="stylesheet" type="text/css" href="css/lightbox.css" media="screen" />
	  <script type="text/javascript">
		  $(function() {
			$('.gallery a').lightBox();
		  });
	  </script>
	 <script type="text/javascript">
	 		   jQuery(function(){
				jQuery('#camera_wrap_1').camera({
					pagination: false,
				});
			});
			   
			   function get(){
					  
					 // window.location.replace("Profile.jsp");
					 var image = document.getElementById("myimg").getAttribute("src");
					  window.location.replace("Profile.jsp?image="+image);
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





<!--
  Below we include the Login Button social plugin. This button uses the JavaScript SDK to
  present a graphical Login button that triggers the FB.login() function when clicked. -->

<div class="callout" style="background-color:white; border:black 2px solid; margin-top:40px;z-index:100000;position:absolute;display:none;height:100px;width:100px;margin-left:80%;"> Values shown
</br>
 <input type="button" value="close">
 </div>




<!----start-header----->
	 <div class="header">
	     <div class="wrap">
			<div class="top-header">
				<div class="logo">
					<img src="images/Picture1.png" style="height:96px;width:96px;float:left;"/>
					<a href="index.html" style="color:#D69F17; margin-top:20px; font-size:45px;float:left; position:absolute;font-family:harlow solid italic">MeetYourFood</a>
					
				</div>
				<div class="social-icons" style="float:right;">
				<div id="google_translate_element" style="float:left;"></div><script type="text/javascript">
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				
					<ul id="social_login" style="float:right;">
					
						<li><a  onClick="FB.login()" href="javascript:void(0);"><img src="images/facebook.png" title="facebook" /></a></li>
						<li id="twitter"><a href="#"><img src="images/twitter.png" title="twitter" /></a></li>
						<li id="google"><a href="#"><img src="images/google.png" title="google pluse" /></a></li>
							
					</ul>
				
					<div style="display:inline;">
					<a href="About.jsp"><img class="circular" id="myimg" style="display:none; margin-left:30px; float:left;"" src="" alt="link" /></a>
					
					<a href="Javascript:void(0);" onClick="FB.logout()" ><p id="myimg_"style="display:none; color:white; margin-top:20px;margin-left:10px;height:64px;width:64px;float:left;position:relative;" alt="link"> Sign Out </p></a>
					</div>
					
					<div id="Username" style="margin-top:60px; margin-left:10%; font-family:Segoe ui light; color:white;position:absolute;"> </div>
					
				</div>
				<div class="clear"> </div>
			</div>
			<!---start-top-nav---->
			
			<div class="top-nav" style=" margin-left:0px; opacity:0.95; position:absolute; margin-top:400px; z-index:99999 ; width:inherit; ">
				<div class="top-nav-left">
					<ul>
						<li class="active"><a href="Facebook.jsp">Home</a></li>
						
						<li><a href="Guest.jsp">Analysis</a></li>
						<li><a href="Host.jsp">Be a Host</a></li>
						<li><a href="contact.html">Contact</a></li>
						
					</ul>
				</div>
				<div class= "top-nav-right">
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
	       <!--start-image-slider---->
			    <div class="slider">					     
					<div class="camera_wrap camera_azure_skin" id="camera_wrap_1">									           
						<div data-src="images/slider1.jpg">  </div> 
						<div data-src="images/slider2.jpg">  </div>
						<div data-src="images/slider3.jpg">  </div>
						<div data-src="images/slider4.jpg">  </div>
					</div>
					<div class="clear"> </div>					       
			</div>					
         <!--End-image-slider---->
		 <!---start-content---->
		 <div class="content">
		 	<div class="top-grids">
		 		<div class="wrap">
			 		<div class="top-grid">
			 			<a href="#"><img src="images/icon1.png" title="icon-name"></a>
			 			<h3>Guest</h3>
			 			<p>Being a guest in someone's home is a great way to get an authentic local perspective in a different city or country. </p>
			 			<a class="button" href="#">Know More</a>
			 		</div>
			 		<div class="top-grid">
			 			<a href="#"><img src="images/icon2.png" title="icon-name"></a>
			 			<h3>Be a Host</h3>
			 			<p>As an MYF host, you can nurture your passion for cooking and hosting, show off your cooking skills and connect with people from around the globe.
  </p>
			 			<a class="button" href="#">Know More</a>
			 		</div>
			 		<div class="top-grid last-topgrid">
			 			<a href="#"><img src="images/icon3.png" title="icon-name"></a>
			 			<h3>Event Location</h3>
			 			<p>Get to know about locations where current events are being hosted, visit events and have time of your life and unforgetable memories </p>
			 			<a class="button" href="About.jsp">Know More</a>
			 		</div>
			 		<div class="clear"> </div>
		 		</div>
		 	</div>
		 	<div class="mid-grid">
		 		<div class="wrap">
			 		<h1>Welcome to our site!</h1>
			 		<h2>A Delicious New Way to Travel</h2>
			 		<p>" MYF is a global community that invites you to dine in homes around the world. Connect with amazing hosts, share stories and unforgettable experiences, and enjoy delicious homemade cuisine. "</p>
			 		<a class="button1" href="#">Read More</a>
		 		</div>
		 	</div>
		 	<div class="bottom-grids">
							<div class="wrap">
								<div class="bottom-grid1">
									<h3>POPULAR VIDEO</h3>
									<iframe width="350" height="415" src="//www.youtube.com/embed/1MG4G28SxRU" frameborder="0" allowfullscreen></iframe>
								</div>
								<div class="bottom-grid2 bottom-mid">
									<h3>Today Special</h3>
									<span>Some of the Best Home Made Cuisines</span>
									<p>Meet amazing people, eat great food and enjoy unforgettable experiences!</p>
									<div class="gallery">
										<ul>
												<li><a href="images/slider1.jpg"><img src="images/slider1.jpg" alt=""></a></li>
												<li><a href="images/slider2.jpg"><img src="images/slider2.jpg" alt=""></a></li>
												<li><a href="images/slider3.jpg"><img src="images/slider3.jpg" alt=""></a></li>
												<li><a href="images/slider4.jpg"><img src="images/slider4.jpg" alt=""></a></li>
												<li><a href="images/slider1.jpg"><img src="images/slider1.jpg" alt=""></a></li>
												<li><a href="images/slider2.jpg"><img src="images/slider2.jpg" alt=""></a></li>											
											<div class="clear"> </div>
										</ul>										
								 </div>
								 <a class="button" href="gallery.html">Read More</a>
							</div>
							<div class="bottom-grid1 bottom-last">
									<h3>Latest INFO</h3>
<a class="twitter-timeline" href="https://twitter.com/Meet_Your_Food" style="background:#4a4444;height:40%;" data-widget-id="452716395877240832">Tweets by @Meet_Your_Food</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

								</div>
								
								<div class="clear"> </div>
							</div>
							<div class="clear"> </div>
	<!--end-wrap--->
	 </div>
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