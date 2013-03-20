<cfparam name="form.Password" default="">
<cfparam name="form.repeat_password" default="">
<cfset decrypted_string = Decrypt(url.token,"mykey",'CFMX_COMPAT','Hex')>
<!---<cfset tip = "Use 6-15 characters. Passwords require at least 4 letters or numbers. Case sensitive. Strong passwords include special characters (!@.##). Avoid common words and names.">--->
<cf_doctype>
<cf_html>
<head>
<title>Create your MaxVite.com password</title>
<cf_meta10>
<cfif structKeyExists(form, "save")>
	<cfset errors = []>
<cfif NOT reFind("^[[:alnum:]]{6,15}$",form.Password)>
<!---<cfif NOT reFind("(?=.*\d.*)(?=.*[a-zA-Z].*)(?=.*[!#\$%&\?].*).{8,}",form.Password)> Password should accept special characters as an option. I couldn't figure out the right regex formula. Dmitry 11-5-11--->
    <cfset arrayAppend(errors, "Invalid password")>
</cfif>
<cfif len(trim(form.Password)) NEQ len(trim(form.repeat_password))>
    <cfset arrayAppend(errors, "You did not correctly verify your password")>
</cfif>
	<cfif arrayLen(errors) is 0>
<cfquery name="updatePassword" datasource="#Application.ds#">
UPDATE Users SET Password = '#form.Password#'
Where Ucase(Username) = '#Ucase(decrypted_string)#'
	</CFQUERY>
<cflocation url="reset-password-reply.cfm?token=#url.token#" addtoken="no">
	</cfif>
</cfif>
</head>
<body>
<cf_header>
<section id="middleArea">
  <div id="crux">
<h1>Reset password</h1>
<p class="topmargin">Please use this form to create a new password</p>

<form id="emailPasswordLinkForm" action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>?token=<cfoutput>#url.token#</cfoutput>" method="post" autocomplete="off">
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
<tr><td>Email Address:</td><td><strong>#decrypted_string#</strong></td></tr>
<tr><td><label for="Password">New Password:</label></td><td><input type="password" name="Password" size="30" maxlength="15" value="#form.Password#"></td></tr>
<tr><td><label for="repeat_password">Verify New Password:</label></td><td><input type="password" name="repeat_password" size="30" maxlength="15" value="#form.repeat_password#"></td></tr>

</table>
<input type="hidden" value="#decrypted_string#" name="email">
<p class="small"><strong>Password Tip:</strong> <cfoutput>Please use 6-15 characters. Letters and numbers only.</cfoutput></p>

<button class="btn bigButton topmargin" type="submit" name="save">Submit Request</button>
</cfoutput>
</fieldset>
</form>
  </div>
</section>
<!--end middleArea-->
<cf_footer>
</body>
</html>