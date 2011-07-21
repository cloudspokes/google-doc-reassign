<%@ page import="com.google.gdata.client.docs.DocsService" %>
<%@ page import="com.google.gdata.data.DateTime" %>
<%@ page import="com.google.gdata.data.docs.DocumentListEntry" %>
<%@ page import="com.google.gdata.data.docs.DocumentListFeed" %>
<%@ page import="com.google.gdata.client.DocumentQuery" %>
<%@ page import="com.google.gdata.data.Link" %>
<%@ page import="com.google.gdata.data.extensions.LastModifiedBy" %>
<%@ page import="com.google.gdata.util.ServiceException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.google.gdata.data.acl.AclEntry"%>
<%@ page import="com.google.gdata.data.acl.AclFeed"%>
<%@ page import="com.google.gdata.data.acl.AclRole"%>
<%@ page import="com.google.gdata.data.acl.AclScope"%>
<%@ page import="com.google.gdata.data.docs.DocumentEntry"%>
<%@ page import="com.google.gdata.data.docs.DocumentListEntry"%>
<%@ page import="com.google.gdata.data.docs.DocumentListFeed"%>
<%@ page import="com.google.gdata.data.extensions.LastModifiedBy"%>
<%@ page import="com.google.gdata.data.TextConstruct"%>
<%@ page import="com.thirdchimpanzee.exportmydoc.service.GoogleDocsReassignService" %>
<%@ page import="com.thirdchimpanzee.exportmydoc.entity.DocConversion" %>
<%@ page import="com.thirdchimpanzee.exportmydoc.entity.GoogleDocsReassignTask" %>
<%@ page import="org.json.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="author" content="Romin Irani" />
	<link rel="stylesheet" type="text/css" href="basic-contact-light.css" title="Basic Contact" media="all" />
	<title>Reassign Google Docs Owners</title>
</head>
<body>
<div id="wrap">
	<h1>Reassign Google Docs Owners</h1>
	<p>Reassign Google Docs Owners is an application that allows you to take a list of Google Docs that you own and assign a new owner to them.<br/><br/>It is part of the <a href="http://www.cloudspokes.com">Cloudspokes</a> Challenge, listed over <a href="http://www.cloudspokes.com/challenge_detail.html?contestID=215">here</a>.</p>
	<div id="content1">
		    <%
		    List<DocConversion> _list = new ArrayList<DocConversion>();
	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    if (user != null) {
	    %>
	        <h3>Hello <%=user.getNickname() %> | <a href="docform.jsp?oauthtoken=<%=request.getParameter("oauthtoken")%>">Do Another Conversion</a> |<a href="<%=userService.createLogoutURL("index.jsp") %>">Sign Out</a>| <a href="tasklist.jsp">Conversion Log</a></h3>
	        <!-- <h3>New Owner = <%=request.getParameter("newowner") %></h3>
	        <h3>Google Docs to ReAssign : <%=request.getParameter("docs2reassign") %></h3>
	         -->
		<h3>The application has determined that you are the owner of the following Documents. If there are documents that you had submitted in the earlier form and of which you are <b>NOT</b> the owner, they are not shown here. Also note that PDF documents cannot be copied as per current Google Docs restrictions.</h3>
		<table border="1">
		<tr><td><b>Title</b></td><td><b>Doc ID</b></td><td><b>Type</b></td><td>Result</td></tr>
		<%
	    String newOwner = request.getParameter("newowner");
	    if (newOwner == null) {
	    	newOwner = user.getEmail();
	    }
	    if (newOwner != null) {
	    	if (newOwner.trim().length() == 0) {
	    		newOwner = user.getEmail();
	    	}
	    }
		String OAuthToken = request.getParameter("oauthtoken");
		if (OAuthToken != null) {
			  DocsService client = new DocsService("MyReassignGoogleDocsApp");
			  client.setAuthSubToken(OAuthToken);
			  DocumentQuery query = new DocumentQuery(new URL("https://docs.google.com/feeds/default/private/full"));
			  DocumentListFeed allEntries = new DocumentListFeed();
			  DocumentListFeed tempFeed = client.getFeed(query, DocumentListFeed.class);
			  do {
				    allEntries.getEntries().addAll(tempFeed.getEntries());
				    Link nextLink = tempFeed.getNextLink();
				    if (nextLink != null) {
				     	if (nextLink.getHref() != null) {
				     		tempFeed = client.getFeed(new URL(tempFeed.getNextLink().getHref()), DocumentListFeed.class);
				     	}
				     	else {
				     		break;
				     	}
				    }
				    else {
				    	break;
				    }
				    
			  	} while (tempFeed.getEntries().size() > 0);
			  for (DocumentListEntry entry : allEntries.getEntries()) {
				  String resourceId = entry.getResourceId();
				  String docId = entry.getDocId();
				  String docType = resourceId.substring(0, resourceId.lastIndexOf(':'));
				  //Determine if the user is an owner
				  URL url = new URL("https://docs.google.com/feeds/default/private/full/" + resourceId + "/acl");
				  AclFeed ACL = client.getFeed(url,AclFeed.class);
				  List<AclEntry> entries = ACL.getEntries();
				  for (AclEntry aclEntry : entries) {
					  if ((aclEntry.getRole().getValue().equals("owner")) && (aclEntry.getScope().getValue().equals(user.getEmail()))) { 
					  
					  //Check if the docId is among the list given.
					  String docs2reassign = request.getParameter("docs2reassign");
					  if (docs2reassign.indexOf(docId) != -1) {
						  //Start the copy the conversion process
		  				try {
							DocumentEntry DE = new DocumentEntry();
							DE.setId(docId);
							TextConstruct TC = TextConstruct.plainText(entry.getTitle().getPlainText()+"-copy");
							DE.setTitle(TC);
							DocumentEntry DE1 = client.insert(new URL("https://docs.google.com/feeds/default/private/full/"), DE);
							//System.out.println("Document Successfully copied. New Doc ID " + DE1.getDocId());
							//Add owner
							AclEntry _aclEntry = new AclEntry();
							AclRole _role = new AclRole();
							_role.setValue("owner");
							_aclEntry.setRole(_role);
							AclScope _scope = new AclScope(AclScope.Type.USER,newOwner);
							_aclEntry.setScope(_scope);
							URL url1 = new URL("https://docs.google.com/feeds/default/private/full/" + DE1.getDocId() + "/acl");
							AclEntry ACE = client.insert(url1, _aclEntry);
							//System.out.println("Modified permission....");
							//Add to the conversion list
							DocConversion DC = new DocConversion(docId,DE1.getDocId());
							_list.add(DC);
							%>
							<tr>
							  <td><%=entry.getTitle().getPlainText()%></td>
							  <td><%=docId%></td>
							  <td><%=entry.getType() %></td>
							  <td><%out.print("Document Successfully copied. New Doc ID " + DE1.getDocId() + " and assigned " + newOwner + " as owner"); %></td>
						  </tr>
						  <%
						}
						  catch (Exception ex) {
							  %>
							  <tr>
							  <td><%=entry.getTitle().getPlainText()%></td>
							  <td><%=docId%></td>
							  <td><%=entry.getType() %></td>
							  <td><%out.println("ERROR: Reason -> " + ex.getMessage());%></td>
						  		</tr>
							  <%
						  }
					  }  
					  }
					  break;
				  }
				}
		}
		%>
		</table>
		<%
		JSONArray JA = new JSONArray(_list);
		String strConversionResult = JA.toString(); 
		//Insert record in Data Store
		GoogleDocsReassignService _Service =  GoogleDocsReassignService.getInstance();
		_Service.addReassignTask(user.getEmail(),newOwner,request.getParameter("docs2reassign"),strConversionResult,new Date(),"DONE");
		//Output the JSON result on screen also
		out.println("<br/>");
		out.println("Result : " + strConversionResult);
	    }
	    else {
	    	%>
	    	Please <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a> to get started.
	    	<%
	    }
		%>
	</div>

	<div id="footer">
		<p>&copy; 2011 Romin Irani | Template design by <a href="http://andreasviklund.com/">Andreas Viklund</a></p>
	</div>
</div>
</body>
</html>