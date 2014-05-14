package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.scribe.builder.ServiceBuilder;
import org.scribe.builder.api.TwitterApi;
import org.scribe.model.OAuthRequest;
import org.scribe.model.Response;
import org.scribe.model.Token;
import org.scribe.model.Verb;
import org.scribe.oauth.OAuthService;

import edu.stanford.nlp.io.EncodingPrintWriter.out;

/**
 * Servlet implementation class Yelp_review
 */
@WebServlet(description = "Sentiment", urlPatterns = { "/Yelp_review" })
public class Yelp_review extends HttpServlet {
	private SentimentAnalyzer sentimentAnalyzer = new SentimentAnalyzer();
	private static final long serialVersionUID = 1L;
	static final private String CONTENT_TYPE = "text/html";
	OAuthService service;
	Token accessToken;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Yelp_review() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Yelp_review(String consumerKey, String consumerSecret, String token,
			String tokenSecret) {
		this.service = (OAuthService) new ServiceBuilder()
				.provider(YelpApi2.class).apiKey(consumerKey)
				.apiSecret(consumerSecret).build();
		this.accessToken = new Token(token, tokenSecret);
	}

	public String search(String term, String loc) {
		/*
		 * OAuthRequest request1 = new OAuthRequest(Verb.GET,
		 * "http://api.yelp.com/v2/business/1886-cafe-and-bakery-austin");
		 */
		OAuthRequest request1 = new OAuthRequest(Verb.GET,
				"http://api.yelp.com/business_review_search");
		 request1.addQuerystringParameter("term", term);
		 request1.addQuerystringParameter("location", loc);
		//request1.addQuerystringParameter("term", request.getParameter("ingredient_type"));
		request1.addQuerystringParameter("limit", "5");
		request1.addQuerystringParameter("ywsid", "q-ZnZaRpB-Upw1fJ8nnKfQ");
		//request1.addQuerystringParameter("location", "Tucson");
		this.service.signRequest(this.accessToken, request1);
		Response reponse = request1.send();
		return reponse.getBody();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		

		/*
		 * response.setContentType(CONTENT_TYPE); PrintWriter out =
		 * response.getWriter();
		 */

		
		
	//	out.println("<!doctype html> <html> <head> <title>Bar Chart</title> <script src=\"Chart.js\"> </script> <meta name = \"viewport\" content = \"initial-scale = 1, user-scalable = no\"> <style> canvas{ 	} </style> </head> <body> <canvas id=\"canvas\" height=\"450\" width=\"600\"></canvas> <script> var barChartData = {"+label+", datasets : [ { fillColor : \"rgba(220,220,220,0.5)\", strokeColor : \"rgba(220,220,220,1)\", "+data1+ "},{ fillColor : \"rgba(151,187,205,0.5)\",strokeColor : \"rgba(151,187,205,1)\","+data2+"}]} ");
	//	out.println("var myLine = new Chart(document.getElementById(\"canvas\").getContext(\"2d\")).Bar(barChartData);</script> </body> </html>");
		
		try {
			String consumerKey = "YgCxN__gT3xLomQqD2LqHg";
			String consumerSecret = "V57KujRBinicVlhhzFTuF9qAYjw";
			String token = "0Ce_tOkX-70vMF66xVxbEtbtDpDkNkI6";
			String tokenSecret = "-7avLlFIGB5Zf8UsR1_Wbrx3R_I";
			Yelp_review yelp_review = new Yelp_review(consumerKey,
					consumerSecret, token, tokenSecret);
			String reponse = yelp_review.search(request.getParameter("term"),
					request.getParameter("location"));
			System.out.println("raw response" + reponse);
			// response.setContentType(CONTENT_TYPE);
			// PrintWriter out = response.getWriter();
			// out.println("<html><head></head><body>What if i have no clue"+
			// reponse+"</body></html>");
			// System.out.println(reponse);
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = null;
			try {
				jsonObject = (JSONObject) jsonParser.parse(reponse);
			} catch (org.json.simple.parser.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			JSONArray businesses = (JSONArray) jsonObject.get("businesses");
			String label = "labels : [";
			String data1 = "data : [";
			String data2 = "data : [";
			String table = "<table border=\"2\" style=\"margin-left:40%;\">";
			for (int i = 0; i < businesses.size(); i++) {
				JSONObject lang = (JSONObject) businesses.get(i);

				// System.out.print((String)lang.get("name")+"; address::");
				/*String address1 = (String) lang.get("address1");
				String address2 = (String) lang.get("address2");
				String address3 = (String) lang.get("address3");
				 */
				String businessname = (String) lang.get("name");
				Double avg_rating = (Double) lang.get("avg_rating");
				/*String city = (String) lang.get("city");
				Double distance = (Double) lang.get("distance");
				String phone = (String) lang.get("phone");
				String photo_url = (String) lang.get("photo_url");
				 */
				//String rating_img_url = (String) lang.get("rating_img_url");
				//String state = (String) lang.get("state");
				Long review_count = (Long) lang.get("review_count");
				//System.out.println("review_count: " + lang.get("review_count"));
				JSONArray reviewList = (JSONArray) lang.get("reviews");
				/*System.out.println("review object" +businessname +"|"+ address1 + "|" + address2
						+ "|" + address3 + "|" + city + "|" + distance + "|"
						+ phone + "|" + photo_url + "|" + rating_img_url + "|"
						+ state + "|");*/
				table = table + "<tr><td>" + businessname + "</td><td>"
						+ review_count + "</td>";
				label = label + "\"" + businessname + "\"";
				if (i != businesses.size() - 1) {
					label = label + ",";
					data1 = data1 + review_count + ",";
				}

				else {
					label = label + "]";
					data1 = data1 + review_count + "]";
				}

				for (int j = 0; j < reviewList.size(); j++) {
					JSONObject reviewItem = (JSONObject) reviewList.get(j);

					String text_excerpt = (String) reviewItem
							.get("text_excerpt");
					/*String user_name = (String) reviewItem.get("user_name");
					String user_photo_url = (String) reviewItem
							.get("user_photo_url");*/

					/*System.out
							.println("review object" + reviewItem + "|"
									+ text_excerpt + "|" + user_name + "|"
									+ user_photo_url);
					System.out.println("text_excerpt: " + text_excerpt);

					System.out
							.println("Final Values: "
									+ sentimentAnalyzer
											.calculateSentimentForGivenString(text_excerpt));
					System.out.println("avg rating" +sentimentAnalyzer.getTweetWithSentiment().getAvgRating());
					 */
					sentimentAnalyzer
							.calculateSentimentForGivenString(text_excerpt);
					if (i != businesses.size() - 1) {
						data2 = data2
								+ sentimentAnalyzer.getTweetWithSentiment()
										.getAvgRating() + ",";
					} else {
						data2 = data2
								+ sentimentAnalyzer.getTweetWithSentiment()
										.getAvgRating() + "]";
					}

					table = table
							+ "<td>"
							+ sentimentAnalyzer.getTweetWithSentiment()
									.getAvgRating() + "</td></tr>";
					/*System.out
							.println("----------------------------------------------------");*/
				}

			}
			table = table + "</table>";
			response.setContentType(CONTENT_TYPE);
			PrintWriter out = response.getWriter();
			//	out.println("<!doctype html> <html> <head> <title>Bar Chart</title> <script src=\"Chart.js\"> </script> <meta name = \"viewport\" content = \"initial-scale = 1, user-scalable = no\"> <style> canvas{ 	} </style> </head> <body> <canvas id=\"canvas\" height=\"450\" width=\"600\"></canvas> <script> var barChartData = {"+label+", datasets : [ { fillColor : \"rgba(220,220,220,0.5)\", strokeColor : \"rgba(220,220,220,1)\", "+data1+ "},{ fillColor : \"rgba(151,187,205,0.5)\",strokeColor : \"rgba(151,187,205,1)\","+data2+"}]} ");
			//	out.println("var myLine = new Chart(document.getElementById(\"canvas\").getContext(\"2d\")).Bar(barChartData);</script> </body> </html>");
			out.println("<html> <head> <title>Bar Chart</title> <script src=\"Chart.js\"> </script> <meta name = \"viewport\" content = \"initial-scale = 1, user-scalable = no\"> <style> canvas{ 	} </style> </head> <body> <div style=\"float:left\"> <div style=\"float:left\"> <canvas id=\"canvas\" height=\"450\" width=\"540\"></canvas> </div> <div style=\"float:left\"> <canvas id=\"canvas1\" height=\"450\" width=\"540\"></canvas> </div> </div> <script> var barChartData = { "
					+ label
					+ ", datasets : [ { fillColor : \"rgba(214,159,23,0.5)\", strokeColor : \"rgba(214,159,23,1)\", "
					+ data1 + "}]}");
			out.println("var myLine = new Chart(document.getElementById(\"canvas\").getContext(\"2d\")).Bar(barChartData)");
			out.println("var barChartData1 = { "
					+ label
					+ ", datasets : [ { fillColor : \"rgba(59,89,72,0.5)\",strokeColor : \"rgba(59,89,72,1)\","
					+ data2 + " }]}");
			out.println("var myLine = new Chart(document.getElementById(\"canvas1\").getContext(\"2d\")).Bar(barChartData1) </script>"
					+ table + " </body> </html>");
		} catch (Exception e) {
			// TODO: handle exception
			out.println("<html> <head></head><body> Sorry for the Inconvenience Caused... Try Again </body></html>");
		}

		/*
		 * String add = ""; for (int k = 0; k < structures.size(); k++) { add +=
		 * structures.get(k).toString() + "</br>"; } table = table +
		 * "<tr><td><img src='" + (String) lang.get("image_url") + "'</td><td>"
		 * + (String) lang.get("name") + "<img src='" + (String)
		 * lang.get("rating_img_url") + "'><br><b>Phone</b>:" + (String)
		 * lang.get("display_phone") + "<br><b>Address</b>:" + add +
		 * "</td></tr><tr></tr>";
		 * 
		 * } table = table + "</table>";
		 * System.out.println("<html><head></head><body>" + table +
		 * "</body></html>");
		 */

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
