<cfparam name="form.likedislike" default="">
<cfparam name="form.whereyoushop" default="">
<cfparam name="form.howsatisfied" default="">
<cfparam name="form.prices" default="">
<cfparam name="form.pricedescribe" default="">
<cfparam name="form.comeback" default="">
<cfparam name="form.comebackdescribe" default="">
<cfparam name="form.email" default="">
<cfparam name="form.specialofferemails" default="">
<cfset question1 = "What do you like and dislike about MaxVite.com?">
<cfset question2 = "What websites do you go to when you shop for vitamins and why?">
<cfset question3 = "How would you describe our prices?">
<cfset question4 = "How satisfied are you with your experience at MaxVite.com?">
<cfset question5 = "Would you come back to MaxVite.com to shop again?">
<cfset question6 = "Sign up to receive emails on exclusive offers, from Maxvite.com(optional)">
<cfset question7 = "I agree with MaxVite Feedback Terms*">
<cf_doctype>
<cf_html>
<head>
<title>Feedback</title>
<meta name="verify-v1" content="2qEa0Zn/k8w/fd2pxQAwdb9yha3hU4n9+BqQBX6s0Es=">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="author" content="MaxVite">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="keywords" content="">
<cf_commonpopupstyles>
<style>
#priceDescribeWrpr, #comebackDescribeWrpr, #dissatisfiedWrpr {display:none;}
#feedbackTable .question {
margin-top:1em;
font-weight:bold;
}
#feedbackForm label.error { display: none; }
</style>

<cfif structKeyExists(form, "save")>
  <cfset errors = []>
  <cfif not len(trim(form.likedislike))>
    <cfset arrayAppend(errors, "Please answer the 1st question")>
  </cfif>
  <cfif not len(trim(form.whereyoushop))>
    <cfset arrayAppend(errors, "Please answer the 2nd question")>
  </cfif>
  <cfif not len(trim(form.howsatisfied))>
    <cfset arrayAppend(errors, "Please answer how satisfied you are")>
  </cfif>
  <cfif not len(trim(form.email)) or not isValid("email", form.email)>
    <cfset arrayAppend(errors, "You must include your valid email address.")>
  </cfif>

  <cfif arrayLen(errors) is 0>
    <style>
#feedbackForm {
display:none;	
}
#emailSent {
display:block;
}
</style>

<script>
localStorage.feedback="Yes";
setTimeout('opener.location.reload(true);',2000);
setTimeout('self.close();',5000);
</script>
<cfquery name="GetData" datasource="#Application.ds#">
Select EmailAddress from Emails Where EmailAddress = '#Ucase(Email)#'
</cfquery>
<cfif IsDefined("form.specialofferemails") and form.specialofferemails EQ "yes"> 
<cfif GetData.Recordcount EQ 0>
	<cfquery name="GetData1" datasource="#Application.ds#">
		INSERT INTO EMAILS
		(EmailAddress, DateJoined)
		VALUES
		('#Ucase(Email)#', #now()#)
	</cfquery>
</cfif>
</cfif>

<cfmail TO="alex@maxihealth.com,bernard@maxihealth.com" FROM="info@maxvite.com" subject="MaxVite Feedback"  server="win-mail01.hostmanagement.net" port=587 username="info@maxvite.com" password="Maxi1305" type="HTML">

<b>Customer Email:</b> #email#
<br><br>
<b>#question1#:</b> #likedislike#
<br><br>
<b>#question2#:</b> #whereyoushop#
<br><br>
<b>#question3#:</b> #prices# #pricedescribe#
<br><br>
<b>#question4#:</b> #howsatisfied# #dissatisfiedexplain#
<br><br>
<b>#question5#:</b>#comeback# #comebackdescribe#
<br><br>
<b>#question6#:</b> #specialofferemails#
    </cfmail>
  </cfif>
</cfif>
<cf_commonpopupscripts>
<script src="/js/feedback.js"></script>
</head>
<body>
<div id="header"><img src="http://www.maxvite.com/img/popup-header.gif" width="281" height="47" alt="MaxVite"></div>
<div id="main">


<h2 id="emailSent">Thank you for taking the time to complete this feedback form. Your results will help us serve you better. Please allow 48 hours to receive your discount coupon.</h2>
<form id="feedbackForm" action="" method="post">
<h1>Write Feedback & Get $5 Off</h1>

<div id="feedbackTable">
<p>We are continually improving MaxVite.com to make it as useful to you as possible. Please take a few moments to answer questions below. As a reward for your effort, we'll email you a $5.00 off coupon for purchase of $75.00 or more. Thank you.</p>

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

<p class="question">#question1#</p>
<div class="error"></div>
<textarea tabindex="33" cols="50" rows="6" name="likedislike">#form.likedislike#</textarea>


<p class="question">#question2#</p>
<div class="error"></div>
<textarea tabindex="33" cols="50" rows="6" name="whereyoushop">#form.whereyoushop#</textarea>

<p class="question">#question3#</p>
<label for="prices" class="error">Please choose one of the options</label>
<p><input  type="radio" value="High" name="prices">&nbsp;High</p>
<p><input  type="radio" value="Average" name="prices">&nbsp;Average</p>
<p><input  type="radio" value="Low" name="prices">&nbsp;Low</p>
<p><input  type="radio" value="Other" id="otherprices" name="prices">&nbsp;Other</p>
<div id="priceDescribeWrpr">
<p><label for="pricedescribe">If you chose "Other" please describe</label></p>
<textarea tabindex="33" cols="50" rows="3" name="pricedescribe"></textarea>
</div>

<p class="question">#question4#</p>
<label for="howsatisfied" class="error">Please choose one of the options</label>
<p><input  type="radio" value="Very Satisfied" name="howsatisfied">&nbsp;Very Satisfied</p>
<p><input  type="radio" value="Satisfied" name="howsatisfied">&nbsp;Satisfied</p>
<p><input  type="radio" value="Neutral" name="howsatisfied">&nbsp;Neutral</p>
<p><input  type="radio" value="Dissatisfied" id="dissatisfied" name="howsatisfied">&nbsp;Dissatisfied</p>
<div id="dissatisfiedWrpr">
<p><label for="dissatisfiedexplain">If you chose "Dissatisfied" please explain</label></p>
<textarea tabindex="33" cols="50" rows="3" name="dissatisfiedexplain"></textarea>
</div>




<p class="question">#question5#</p>
<label for="comeback" class="error">Please choose one of the options</label>
<p><input  type="radio" value="Yes" name="comeback">&nbsp;Yes</p>
<p><input  type="radio" value="No" id="wontcomeback" name="comeback">&nbsp;No</p>
<p><input  type="radio" value="Not Sure" name="comeback">&nbsp;Not Sure</p>
<div id="comebackDescribeWrpr">
<p><label for="comebackdescribe">If you chose "No" please describe</label></p>
<textarea tabindex="33" cols="50" rows="3" name="comebackdescribe"></textarea>
</div>

<p class="question">Please enter your email address</p>
<input type="text" id="email" name="email" size="25" value="#form.email#">
<p class="small">We promise to keep your email address confidential. We won't share it anyone.</p>

<p><input type="checkbox" name="specialofferemails" value="yes">&nbsp;<label>#question6#</label></p>
<p><input type="checkbox" name="agree" value="yes">&nbsp;<label>#question7#</label></p>

<p><button class="btn bigButton" name="save" type="submit">submit</button></p>

<p class="small">*must make an $80 purchase in orders for coupon to be valid. Must give honest feedback. One per consumer and/or shipping address. Valid only on dietary supplements, vitamins & minerals, herbs, enzymes, amino acid, omega & oil supplements categories. This coupon code is only valid for 3 months from the date you have entered your feedback. We have the right to withdraw this offer or deny any coupon at anytime for any reason. Coupon code will be sent by email 2-5 business days after filling out form.</p>
</div>
</cfoutput>

</form>
</div>
</body>
</html>