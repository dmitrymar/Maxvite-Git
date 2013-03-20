<cfparam name="form.email" default="">

<cfquery name="GetData" datasource="#Application.ds#">
		SELECT *
		FROM Users
		Where Ucase(Username) = '#Ucase(Email)#'
</cfquery>
<cf_doctype>
<cf_html>
<head>
<title>Forgot your password?</title>
<cf_meta10>
<cfif structKeyExists(form, "save")>
	<cfset errors = []>
  <cfif not len(trim(form.email)) or not isValid("email", form.email)>
    <cfset arrayAppend(errors, "You must include your valid email address.")>
  </cfif>
	<cfif isValid("email", form.email) and GetData.Recordcount eq 0>
		<cfset arrayAppend(errors, "The email address you entered has a typo or isn't associated with your account. Please try again.")>
	</cfif>
	<cfif arrayLen(errors) is 0>
<cfmail TO="#email#" FROM="maxvite@maxvite.com" subject="MaxVite.com - Password Retrieve" server="#Application.mailserver#" username="#Application.mailuser#" password="#Application.mailpassword#" query="GetData" type="HTML">
<cfset encrypted_string = encrypt('#email#', "mykey",'CFMX_COMPAT','Hex')>
<cf_email-template-top>
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Dear <cfoutput>#Firstname# #Lastname#</cfoutput>,</p>
     <br>
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">We received a request to reset the password associated with this e-mail address. If you made this request, please follow the instructions below.</p>
    <br>                                                                                                                   
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Click the link below to reset your password using our secure server:</p>
	<br>
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;"><a href="https://www.maxvite.com/reset-password.cfm?token=<cfoutput>#encrypted_string#</cfoutput>" target="_new" style="text-decoration: underline;">Reset Password Link</a></p>
    <br>                                   
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">If you did not request to have your password reset you can safely ignore this email. Rest assured your customer account is safe.</p>
     <br>                              
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Once you have returned to MaxVite.com, we will give instructions for resetting your password.</p>

                  
                  <br>
                  <p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">MaxVite Customer Service Team</p>
                  <br>

<cf_email-template-bottom>
</cfmail>
<cflocation url="forgot-password-email-sent.cfm?token=#encrypted_string#" addtoken="no">
	</cfif>
</cfif>
</head>
<body>
<cf_header>
<section id="middleArea">
  <div id="crux">
  <h1>Forgot your password?</h1>

<p class="topmargin">Please submit the email address associated with your account and we will send you a link to reset your password. </p>

<form id="emailPasswordLinkForm" action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" method="post">

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
<table class="formLayout">
<tr><td><label for="email">Email:</label></td><td><input type="text" id="email" name="email" size="25" value="<cfoutput>#form.email#</cfoutput>"></td></tr>
</table>

<button class="btn bigButton" type="submit" name="save">Submit Request</button>
</fieldset>
</form>

  </div>
</section>
<!--end middleArea-->
<cf_footer>
</body>
</html>