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
</head>
<body>
<div id="wrap">
	<h1>Reassign Google Docs Owners</h1>
	<p>Reassign Google Docs Owners is an application that allows you to take a list of Google Docs that you own and assign a new owner to them.<br/><br/>It is part of the <a href="http://www.cloudspokes.com">Cloudspokes</a> Challenge, listed over <a href="http://www.cloudspokes.com/challenge_detail.html?contestID=215">here</a>.</p>
	<p>Features:</p>
	<ul>
	<li>Login with your Google Account. No username/password to be given to this application.</li>
	<li>Authorize access to your Google Docs via OAuth 2.</li>
	<li>Provide a list of Google Doc IDs that you want to reassign to a new user along with the new user name.</li>
	</ul>
	<p>Read the <a href="help.html">User Guide</a>.</p>
	<div id="content1">
	    <%
	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    if (user != null) {
	    %>
	        <h3>Hello <%=user.getNickname() %> | <a href="<%=userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a> | <a href="tasklist.jsp">Conversion Log</a></h3>
			<p>Please <a href="https://accounts.google.com/o/oauth2/auth?client_id=571378304146.apps.googleusercontent.com&redirect_uri=http://reassigndocs.appspot.com/oauth2callback&scope=https://docs.google.com/feeds&response_type=code">Authorize</a> me to access your Google Docs</p>
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