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
	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    if (user != null) {
    %>
	        <h3>Hello <%=user.getNickname() %> | <a href="<%=userService.createLogoutURL("index.jsp") %>">Sign Out</a></h3>
	        <p>Task Operations List | <a href="index.jsp">Back to Home</a></p>
		<table border="1">
		<tr><td><b>Timestamp</b></td><td><b>Original Owner</b></td><td><b>Assigned Owner</b></td><td><b>Docs to Assign</b></td><td><b>JSON Result</b></td></tr>
		<%
		String OAuthToken = request.getParameter("oauthtoken");
	    GoogleDocsReassignService _service = GoogleDocsReassignService.getInstance();
	    List<GoogleDocsReassignTask> _list = _service.getAllReassignTasksByEmailId(user.getEmail(),"DONE");
	    for (GoogleDocsReassignTask _task : _list) {
	    	%>
	    	<tr>
	    	<td><%=_task.getRequestDate() %></td>
	    	<td><%=_task.getEmailAddress() %></td>
	    	<td><%=_task.getNewOwner() %></td>
	    	<td><%=_task.getMsg() %></td>
	    	<td><%=_task.getConversionResult() %></td>
	    	</tr>
	    	<%
	    }
	    %>
	    </table>
	    <%
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