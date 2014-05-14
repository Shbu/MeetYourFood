package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

/**
 * Servlet implementation class Amzaon
 */
@WebServlet("/Amzaon")
public class Amzaon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final private String CONTENT_TYPE = "text/html";
	private static final String AWS_ACCESS_KEY_ID = "AKIAIDOEAKTX6DQH3J7Q";

	/*
	 * Your AWS Secret Key corresponding to the above ID, as taken from the AWS
	 * Your Account page.
	 */
	private static final String AWS_SECRET_KEY = "wacai1Xn4GvkXQGvKLfnlt7PMxrIOx3VmQ/dC/CX";

	/*
	 * Use one of the following end-points, according to the region you are
	 * interested in:
	 * 
	 * US: ecs.amazonaws.com CA: ecs.amazonaws.ca UK: ecs.amazonaws.co.uk DE:
	 * ecs.amazonaws.de FR: ecs.amazonaws.fr JP: ecs.amazonaws.jp
	 */
	private static final String ENDPOINT = "ecs.amazonaws.com";

	/*
	 * The Item ID to lookup. The value below was selected for the US locale.
	 * You can choose a different value if this value does not work in the
	 * locale of your choice.
	 */
	private static final String ITEM_ID = "B00008OE6I";
   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Amzaon() {
        super();
        
        
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		SignedRequestsHelper helper;
		try {
			helper = SignedRequestsHelper.getInstance(ENDPOINT,
					AWS_ACCESS_KEY_ID, AWS_SECRET_KEY);
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}

		String requestUrl = null;
		String title = null;

		/* The helper can sign requests in two forms - map form and string form */

		/*
		 * Here is an example in map form, where the request parameters are
		 * stored in a map.
		 */
		System.out.println("Map form example:");
		Map<String, String> params = new HashMap<String, String>();
		params.put("Service", "AWSECommerceService");
		params.put("Version", "2009-03-31");
		params.put("Operation", "ItemSearch");
		// params.put("ItemId", ITEM_ID);
		// params.put("ResponseGroup", "Small");
		params.put("AssociateTag", "meet0bd-20");
		params.put("Availability", "Available");
		params.put("SearchIndex", "Grocery");
		params.put("Keywords", request.getParameter("ingredient_type"));
		params.put("ResponseGroup", "Large");
		// params.put("ResponseGroup", "Offers");

		requestUrl = helper.sign(params);
		System.out.println("Signed Request is \"" + requestUrl + "\"");
		ArrayList<String> itemTitleArrayList = new ArrayList<String>();
		ArrayList<String> itemImageArrayList = new ArrayList<String>();
		ArrayList<String> itemPriceArrayList = new ArrayList<String>();
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(requestUrl);
			NodeList itemsList = doc.getElementsByTagName("Item");

			for (int i = 0; i < itemsList.getLength(); i++) {
				NodeList itemp = itemsList.item(i).getChildNodes();
				for (int k = 0; k < itemp.getLength(); k++) {
					if (itemp.item(k).getNodeName() == "ItemAttributes") {
						NodeList itemn = itemp.item(k).getChildNodes();

						for (int j = 0; j < itemn.getLength(); j++) {
							// System.out.println(itemn.item(j).getNodeName());
							if (itemn.item(j).getNodeName() == "Title") {
								itemTitleArrayList.add(itemn.item(j)
										.getTextContent());
								
								// System.out.println(n.getNodeValue());

							}
						}
					}

					if (itemp.item(k).getNodeName() == "OfferSummary") {
						NodeList itemn = itemp.item(k).getChildNodes();

						for (int j = 0; j < itemn.getLength(); j++) {
							// System.out.println(itemn.item(j).getNodeName());
							if (itemn.item(j).getNodeName() == "LowestNewPrice") {
								NodeList itemk = itemn.item(j).getChildNodes();
								for (int l = 0; l < itemk.getLength(); l++) {
									if (itemk.item(l).getNodeName() == "FormattedPrice") {
								
								
										itemPriceArrayList.add(itemk.item(l)
												.getTextContent());

									}
								}
							}
						}
					}

					if (itemp.item(k).getNodeName() == "MediumImage") {
						NodeList itemn = itemp.item(k).getChildNodes();

						for (int j = 0; j < itemn.getLength(); j++) {
							// System.out.println(itemn.item(j).getNodeName());
							if (itemn.item(j).getNodeName() == "URL") {
								
								
								itemImageArrayList.add(itemn.item(j)
										.getTextContent());
							}

						}
					}
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
		String table="<table>";
		for(int i =0;i<5;i++)
		{
			
			 table= table+"<tr><td><img src=\""+itemImageArrayList.get(i)+"\"></td><td>"+itemTitleArrayList.get(i)+"</td><td>"+itemPriceArrayList.get(i)+"</td></tr>";
			 
	    }
       table = table+"</table>";	
       response.setContentType(CONTENT_TYPE);
		PrintWriter out = response.getWriter();
		//String sample = request.getSession().getAttribute("title").toString();
		out.println("<html><head></head><body>"+ table+"</body></html>");
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
