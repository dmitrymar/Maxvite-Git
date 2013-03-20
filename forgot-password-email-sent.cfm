<cf_doctype>
<cf_html>
<head>
<title>Forgot your password?</title>
<cf_meta10>
</head>
<body>
<cf_header>
<section id="middleArea">
  <div id="crux">
<cfset decrypted_string = Decrypt(url.token,"mykey",'CFMX_COMPAT','Hex')>
<h1>Check your e-mail</h1>
<p class="topmargin">If the e-mail address you entered <cfoutput>#decrypted_string#</cfoutput> is associated with a customer account in our records, you will receive an e-mail from us with instructions for resetting your password. If you don't receive this e-mail, please check your junk mail folder or contact Customer Service for further assistance.
</p>
<p><a href="http://www.maxvite.com/" class="btn">Continue Shopping</a></p>

  </div>
</section>
<!--end middleArea-->
<cf_footer>
</body>
</html>