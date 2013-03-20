<cfset decrypted_string = Decrypt(url.token,"mykey",'CFMX_COMPAT','Hex')>
<cf_doctype>
<cf_html>
<head>
<title>You have successfully reset your password.</title>
<cf_meta10>
</head>
<body>
<cf_header>
<section id="middleArea">
  <div id="crux">
<h1>Congratulations!</h1>
<p class="topmargin">You have successfully reset your password. Please sign in to continue shopping.</p>
<form action="http://www.maxvite.com/userverifylo.cfm" method="post" name="LOGIN" id="signinForm">
<cfoutput>
<fieldset>
<table class="formLayout">
<tr><td>Email Address:</td><td><strong>#decrypted_string#</strong></td></tr>
<tr><td><label for="password">Password:</label></td><td><input type="password" name="password" size="20"></td></tr>
</table>
<input type="hidden" value="#decrypted_string#" name="username">
<button class="btn bigButton" type="submit">SIGN IN</button>
</fieldset>
</form>
</cfoutput>

  </div>
</section>
<!--end middleArea-->
<cf_footer>
</body>
</html>