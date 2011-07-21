package com.thirdchimpanzee.exportmydoc;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

@SuppressWarnings("serial")
public class ReassignMyDocServlet extends HttpServlet {
	public static final String CLIENT_ID = "571378304146.apps.googleusercontent.com";
	public static final String CLIENT_SECRET = "LVcLBa1Nbng2zXVtPhlclXB8";
	public static final String CALLBACK = "http://reassigndocs.appspot.com/oauth2callback";
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
/*		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");
*/	
	String code = req.getParameter("code");
	String error = req.getParameter("error");
	if (code != null) {
		String strURL = "https://accounts.google.com/o/oauth2/token";

	    String PARAMS = URLEncoder.encode("client_id","UTF-8") + "=" + URLEncoder.encode(CLIENT_ID,"UTF-8");
	    PARAMS += "&" + URLEncoder.encode("client_secret","UTF-8") + "=" + URLEncoder.encode(CLIENT_SECRET,"UTF-8");
		PARAMS += "&" + URLEncoder.encode("redirect_uri","UTF-8") + "=" + URLEncoder.encode(CALLBACK,"UTF-8");
        PARAMS += "&" + URLEncoder.encode("grant_type","UTF-8") + "=" + URLEncoder.encode("authorization_code","UTF-8");
		PARAMS += "&" + URLEncoder.encode("code","UTF-8") + "=" + URLEncoder.encode(code,"UTF-8");
try {
            
            // Send the request
            URL url = new URL(strURL);
            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
            
            //write parameters
            writer.write(PARAMS);
            writer.flush();
            
            // Get the response
            StringBuffer answer = new StringBuffer();
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                answer.append(line);
            }
            writer.close();
            reader.close();
            
            //Output the response
            System.out.println(answer.toString());
            try {
            	JSONObject obj = new JSONObject(answer.toString());
            	String OAuthToken = obj.getString("access_token");
            	//resp.sendRedirect("doclist.jsp?oauthtoken="+OAuthToken);
            	resp.sendRedirect("docform.jsp?oauthtoken="+OAuthToken);
            }
            catch (Exception e) {
				//It is not a JSON Object
            	resp.sendRedirect("error.jsp?reason="+answer.toString());
			}
            //Extract out the access_token and get the list of documents that belong to this user.
            //String strResult = answer.toString();
            /*int i = strResult.indexOf("access_token");
            if (i != -1) {
            	String strRem = strResult.substring(i+"access_token".length()+4);
            	String OAuthToken = strRem.substring(0,strRem.indexOf("\""));
            	resp.sendRedirect("doclist.jsp?oauthtoken="+OAuthToken);
            }*/
            
        } catch (MalformedURLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }	}
	else { //Error
	resp.sendRedirect("error.jsp?reason="+error);
	}
	}
}
