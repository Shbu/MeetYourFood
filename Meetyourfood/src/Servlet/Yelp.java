package Servlet;



import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.scribe.builder.ServiceBuilder;
import org.scribe.model.*;
import org.scribe.oauth.*;
import org.scribe.model.Verb;

import edu.stanford.nlp.io.EncodingPrintWriter.out;





/**
 * Servlet implementation class Yelp
 */
@WebServlet("/Yelp")
public class Yelp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final private String CONTENT_TYPE = "text/html";
	
	 OAuthService service;
	  Token accessToken;

       
    /**
     * @see HttpServlet#HttpServlet()
     */
	  public Yelp(String consumerKey, String consumerSecret, String token, String tokenSecret) {
		    this.service = (OAuthService) new ServiceBuilder().provider(YelpApi2.class).apiKey(consumerKey).apiSecret(consumerSecret).build();
		    this.accessToken = new Token(token, tokenSecret);
		  }
    public Yelp() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public String search(String term, String loc) {
        OAuthRequest request1 = new OAuthRequest(Verb.GET, "http://api.yelp.com/v2/search");
        request1.addQuerystringParameter("term", term);
        request1.addQuerystringParameter("location", loc);
        this.service.signRequest(this.accessToken, request1);
        Response reponse = request1.send();
        return reponse.getBody();
      }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
		String consumerKey = "YgCxN__gT3xLomQqD2LqHg";
	    String consumerSecret = "V57KujRBinicVlhhzFTuF9qAYjw";
	    String token = "0Ce_tOkX-70vMF66xVxbEtbtDpDkNkI6";
	    String tokenSecret = "-7avLlFIGB5Zf8UsR1_Wbrx3R_I";

	    Yelp yelp = new Yelp(consumerKey, consumerSecret, token, tokenSecret);
	    String reponse = yelp.search("taxi", request.getParameter("loc"));
	    //response.setContentType(CONTENT_TYPE);
		//PrintWriter out = response.getWriter();
	    //out.println("<html><head></head><body>What if i have no clue"+ reponse+"</body></html>");
	   // System.out.println(reponse);
	  
	    JSONParser jsonParser = new JSONParser();
	    JSONObject jsonObject = null;
		try {
			jsonObject = (JSONObject) jsonParser.parse(reponse);
		} catch (org.json.simple.parser.ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		JSONArray structure = (JSONArray) jsonObject.get("businesses");
		response.setContentType(CONTENT_TYPE);
		PrintWriter out = response.getWriter();
		
		String table ="<table>";
		
		for (int i=0;i<structure.size();i++)
		{
			JSONObject lang= (JSONObject) structure.get(i);
			
	   // System.out.print((String)lang.get("name")+"; address::");
		JSONObject location = (JSONObject) lang.get("location");
		JSONArray structures = (JSONArray) location.get("display_address");
		
		
		String add=""; 
		for(int k=0;k<structures.size();k++)
		{
		   add+=structures.get(k).toString()+"</br>";
		}
		table = table +"<tr><td><img src='"+(String)lang.get("image_url")+"'</td><td>"+(String)lang.get("name")+"<img src='"+(String)lang.get("rating_img_url")+"'><br><b>Phone</b>:"+(String)lang.get("display_phone")+"<br><b>Address</b>:"+add+"</td></tr><tr></tr>";
		
		}
table= table+"</table>";
out.println("<html><head></head><body>"+ table+"</body></html>");
		}
		catch (Exception e)
		{
			out.println("<html><head></head><body> Sorry for the Inconvenience Caused .... Try Again</body></html>");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
