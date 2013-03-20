<cfparam name="form.firstname" default="">
<cfparam name="form.lastname" default="">
<cfparam name="form.email" default="">
<cf_doctype>
<cf_html>
<head>
	<title>Create a MaxVite Account</title>
<cfif Isdefined("CHECKOUT")>
	<cf_meta10s>
<cfelse>
	<cf_meta10>
</cfif>   
<script src="/js/register.js"></script>
</head>


<body>

 
<cfif Isdefined("CHECKOUT")>
<div class="wrapper"><cf_minihdr><div class="content"><div id="crux">
<cfelse>
<cf_header><section id="middleArea"><div id="crux">
</cfif>
 
    <h1 class="marginBottom">Create an Account</h1>
    <p class="topmargin">* <span class="small">Required field</span></p>
 
<cfif structKeyExists(form, "save")>
  <cfset errors = []>
  <cfif not len(trim(form.firstname))>
    <cfset arrayAppend(errors, "You must include first name.")>
  </cfif>
  <cfif not len(trim(form.lastname))>
    <cfset arrayAppend(errors, "You must include last name.")>
  </cfif>
  <cfif not len(trim(form.email)) or not isValid("email", form.email)>
    <cfset arrayAppend(errors, "You must include valid email.")>
  </cfif>
<cfif len(trim(form.email)) NEQ len(trim(form.retypeEmail))>
    <cfset arrayAppend(errors, "The emails you entered do not match. Please try again.")>
</cfif>
<cfif NOT reFind("^[[:alnum:]]{6,15}$",form.password)>
    <cfset arrayAppend(errors, "Invalid password")>
</cfif>
<cfif len(trim(form.password)) NEQ len(trim(form.retypePassword))>
    <cfset arrayAppend(errors, "The passwords you entered do not match. Please try again.")>
</cfif>
  <cfif arrayLen(errors) is 0>
<form action="https://www.maxvite.com/registerconfirm2.cfm" method="post" name="theForm" id="theForm">
<cfif Isdefined("CHECKOUT")>
	<input type="hidden" name="CHECKOUT" value="TRUE">
</cfif>
<cfif IsDefined("form.specialofferemails") and form.specialofferemails EQ "yes"> 
<input type="hidden" name="specialofferemails" value="yes">
</cfif>

<input type="hidden" name="firstname" value="<cfoutput>#form.firstname#</cfoutput>">
<input type="hidden" name="lastname" value="<cfoutput>#form.lastname#</cfoutput>">
<input type="hidden" name="email" value="<cfoutput>#form.email#</cfoutput>">
<input type="hidden" name="password" value="<cfoutput>#form.password#</cfoutput>">
</form>
<script>
document.theForm.submit();
</script>

  
  	</cfif>
</cfif>
    
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
    <cfoutput>
    <form action="https://www.maxvite.com#CGI.SCRIPT_NAME#" method="post" name="registerForm" id="registerForm">
      <table class="formLayout">
        <tbody>
          <tr>
            <td><label>First Name: *</label></td>
            <td><input type="text" name="firstname" maxlength="30" value="#form.firstname#"></td>
          </tr>
          <tr>
            <td><label>Last Name: *</label></td>
            <td><input type="text" name="lastname" maxlength="30" value="#form.lastname#"></td>
          </tr>
<tr><td><label>Email: *</label></td>
<td><ul class="formList">
<li><input type="text" name="email" id="regEmail" maxlength="30" value="#form.email#"></li>
<li><img src="/img/question-icon.gif" class="sideNote" width="14" height="12" alt="question" title="Email address will be your user name. You will use this to access the site."></li>
</ul></td></tr>
          <tr>
            <td><label>Retype Email: *</label></td>
            <td><input type="text" name="retypeEmail" maxlength="30" value=""></td>
          </tr>
          <tr>
            <td><label>Password: *</label></td>
            <td><input type="password" name="password" id="regPassword" maxlength="30" value=""></td>
          </tr>
          <tr>
            <td><label>Retype Password: *</label></td>
            <td><input type="password" name="retypePassword" maxlength="30" value=""></td>
          </tr>
        </tbody>
      </table>
<p class="small"><strong>Password Tip:</strong> Please use 6-15 characters. Letters and numbers only.</p>
<p><input type="checkbox" name="specialofferemails" value="yes" checked="checked">&nbsp;<label>Sign up to receive emails on exclusive offers, from Maxvite.com, we promise to keep your email address confidential. We don't share our list with anyone.</label></p>

      <p class="actionBtns"><button type="submit" name="save" class="btn bigButton">Create Account</button></p>
    </form>
</cfoutput>





<cfif Isdefined("CHECKOUT")>
</div></div><cf_miniftr></div><!--end wrapper-->
<cfelse>
</div></section><cf_footer>
</cfif>
 



</body>
</html>