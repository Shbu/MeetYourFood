/* *********************************************************************************************
 * Copyright 2009 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file 
 * except in compliance with the License. A copy of the License is located at
 *
 *       http://aws.amazon.com/apache2.0/
 *
 * or in the "LICENSE.txt" file accompanying this file. This file is distributed on an "AS IS"
 * BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under the License. 
 *
 * ********************************************************************************************
 *
 *  Amazon Product Advertising API
 *  Signed Requests Sample Code
 *
 *  API Version: 2009-03-31
 *
 */

package Servlet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

/*
 * This class shows how to make a simple authenticated ItemLookup call to the
 * Amazon Product Advertising API.
 * 
 * See the README.html that came with this sample for instructions on
 * configuring and running the sample.
 */
public class ItemSearch {
	/*
	 * Your AWS Access Key ID, as taken from the AWS Your Account page.
	 */
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

	public static void main(String[] args) {
		/*
		 * Set up the signed requests helper
		 */
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
		params.put("Keywords", "vegetables");
		params.put("ResponseGroup", "Large");
		// params.put("ResponseGroup", "Offers");

		requestUrl = helper.sign(params);
		System.out.println("Signed Request is \"" + requestUrl + "\"");

		title = fetchTitle(requestUrl);
		// System.out.println("Signed Title is \"" + title + "\"");
		// System.out.println();

		/*
		 * Here is an example with string form, where the requests parameters
		 * have already been concatenated into a query string.
		 */
		/*
		 * System.out.println("String form example:"); String queryString =
		 * "Service=AWSECommerceService&Version=2009-03-31&Operation=ItemSearch&ResponseGroup=Small&ItemId="
		 * + ITEM_ID; requestUrl = helper.sign(queryString);
		 * System.out.println("Request is \"" + requestUrl + "\"");
		 * 
		 * title = fetchTitle(requestUrl); System.out.println("Title is \"" +
		 * title + "\""); System.out.println();
		 */

	}

	/*
	 * Utility function to fetch the response from the service and extract the
	 * title from the XML.
	 */
	private static String fetchTitle(String requestUrl) {
		String title = null;
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
								System.out.println(itemn.item(j)
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
										System.out.println(itemk.item(l)
												.getTextContent());
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
								System.out.println(itemn.item(j)
										.getTextContent());
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
		return title;
	}

}
