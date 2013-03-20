<cfparam name="form.Password" default="">
<cfparam name="form.repeat_password" default="">
<cf_doctype>
<cf_html>
<head>
<title>Create your MaxVite.com password</title>
<cf_meta10>
<cfif structKeyExists(form, "save")>
	<cfset errors = []>
  <cfif not len(trim(form.Password))>
    <cfset arrayAppend(errors, "Your password is not formatted correctly.")>
  </cfif>
	<cfif arrayLen(errors) is 0>
<!---insert new password for the user code--->
<cflocation url="reset-password-reply.cfm" addtoken="no">
	</cfif>
</cfif>
</head>
<body>
<cf_header>
<section id="middleArea">
  <section id="primary">

<!---<cfset decrypted_string = Decrypt(url.token,"mykey",'CFMX_COMPAT','Hex')>--->

<h1>Reset password</h1>
<p class="topmargin">Please use this form to create a new password</p>

<form id="emailPasswordLinkForm" action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" method="post" autocomplete="off">
    <cfif structKeyExists(variables,"errors")>
    <div class="formError">
  <h3 class="errorMsg">Please fix the following errors:</h3>
  <span></span>
  <ul class="errorMsg">
        <cfloop index="e" array="#errors#">
          <li><cfoutput>#e#</cfoutput></li>
        </cfloop>
  </ul>
</div>    
    </cfif>
<fieldset>
<cfoutput>
<table class="formLayout">
<!---<tr><td>Email Address:</td><td><strong>#decrypted_string#</strong></td></tr>--->
<tr><td><label for="Password">New Password:</label></td><td><input type="password" name="Password" size="30" maxlength="50" value="#form.Password#"></td></tr>
<tr><td><label for="repeat_password">Verify New Password:</label></td><td><input type="password" name="repeat_password" size="30" maxlength="50" value="#form.repeat_password#"></td></tr>

</table>
<!---<input type="hidden" value="#decrypted_string#" name="email">--->
<p class="small"><strong>Password Tip:</strong> Use 7-15 letters and numbers. Must contain at least 1 letter and 1 number. CaSe SeNsItIvE. No spaces.</p>

<button class="btn bigButton topmargin" type="submit" name="save">Submit Request</button>
</cfoutput>
</fieldset>
</form>
  </section>
  <cf_secondary>
</section>
<!--end middleArea-->
<cf_footer>
</body>
</html>