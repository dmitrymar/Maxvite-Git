<cfparam name="form.fname" default="">
<cfparam name="form.lname" default="">
<cfparam name="form.email" default="">
<cfparam name="form.comment" default="">
<cf_doctype>
<cf_html>
<head>
	<title>Contact a Nutritionist</title>
	<cf_meta10>
</head>

<body>
<cf_header>
<section id="middleArea">
  <section id="primary">
<cfif structKeyExists(form, "save")>
  <cfset errors = []>
  <cfif not len(trim(form.email)) or not isValid("email", form.email)>
    <cfset arrayAppend(errors, "You must include valid email.")>
  </cfif>
  <cfif not len(trim(form.comment))>
    <cfset arrayAppend(errors, "You must include your comment or question.")>
  </cfif>
  <cfif arrayLen(errors) is 0>
<form action="sendfeedback_nutritionist.cfm" method="post" name="theForm" id="theForm">
<input type="hidden" name="fname" value="<cfoutput>#form.fname#</cfoutput>">
<input type="hidden" name="lname" value="<cfoutput>#form.lname#</cfoutput>">
<input type="hidden" name="email" value="<cfoutput>#form.email#</cfoutput>">
<input type="hidden" name="comment" value="<cfoutput>#form.comment#</cfoutput>">
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

    <h1 class="marginBottom">Contact a Nutritionist</h1>
    <p class="topmargin">* <span class="small">Required field</span></p>
<cfoutput>
<form action="#CGI.SCRIPT_NAME#" method="post" name="nutritionistForm" id="nutritionistForm">
<fieldset>
<table class="formLayout">
          <tr>
            <td><label>First Name: </label></td>
            <td><input type="text" name="fname" maxlength="30" value="#form.fname#"></td>
          </tr>
          <tr>
            <td><label>Last Name: </label></td>
            <td><input type="text" name="lname" maxlength="30" value="#form.lname#"></td>
          </tr>
          <tr>
            <td><label>Email: *</label></td>
            <td><input type="text" name="email" maxlength="30" value="#form.email#"></td>
          </tr>
          <tr>
            <td><label>Comments/Questions: *</label></td>
            <td><textarea tabindex="33" cols="50" rows="6" name="comment">#form.comment#</textarea></td>
          </tr>
</table>

<button class="btn bigButton" type="submit" name="save">Send Message</button>
</fieldset>
</form>
</cfoutput>




  </section><!--end primary-->
  <cf_secondary>
</section>
<!--end middleArea-->
<cf_footer>
</body>
</html>