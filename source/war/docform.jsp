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
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="author" content="Romin Irani" />
	<link rel="stylesheet" type="text/css" href="basic-contact-light.css" title="Basic Contact" media="all" />
	<title>Reassign Google Docs Owners</title>
	<script type="text/javascript">
	// Removes leading whitespaces
	function LTrim( value ) {
		
		var re = /\s*((\S+\s*)*)/;
		return value.replace(re, "$1");
		
	}

	// Removes ending whitespaces
	function RTrim( value ) {
		
		var re = /((\s*\S+)*)\s*/;
		return value.replace(re, "$1");
		
	}

	// Removes leading and ending whitespaces
	function trim( value ) {
		
		return LTrim(RTrim(value));
		
	}	

	function reassignOwner(new_owner,docs2_reassign) {
		var strDocs = trim(docs2_reassign);
		if (strDocs == 0) {
			alert("Please enter the Google Doc Ids to convert.");
			return;
		}
		document.docform.submit();
	}
	</script>
</head>
<body>
<div id="wrap">
	<h1>Reassign Google Docs Owners</h1>
	<p>Reassign Google Docs Owners is an application that allows you to take a list of Google Docs that you own and assign a new owner to them.<br/><br/>It is part of the <a href="http://www.cloudspokes.com">Cloudspokes</a> Challenge, listed over <a href="http://www.cloudspokes.com/challenge_detail.html?contestID=215">here</a>.</p>
	<div id="content1">
		    <%
		String oauthToken = request.getParameter("oauthtoken");
	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    if (user != null) {
	    %>
	        <h3>Hello <%=user.getNickname() %> | <a href="<%=userService.createLogoutURL("index.jsp") %>">Sign Out| <a href="tasklist.jsp">Conversion Log</a></a></h3>
	        <form name="docform" method="post" action="doclist.jsp">
	        <input type="hidden" name="oauthtoken" value="<%=oauthToken%>"/>
	        <table>
	        <tr>
	        <td>New Owner:</td>
	        <td><input type="text" name="newowner" autofocus placeholder="Enter New Owner here e.g. @gmail.com"/></td>
	        </tr>
	        <tr>
	        <td>Google Docs to convert:</td>
	        <td><textarea rows="10" cols="50" name="docs2reassign" placeholder="Enter a comma separated list of Google Doc Ids over here"></textarea></td>
	        </tr>
	        </table>
	        <INPUT type="button" value="Reassign Owner" name="button2" onClick="reassignOwner(newowner.value,docs2reassign.value); return true"/>
	        </form>
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