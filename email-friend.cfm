<cfquery name="GetData" datasource="#Application.ds#">
	Select * from Products, Brands
	Where Products.BrandID = Brands.BrandID
	AND ProductID = #ProductID#
</cfquery>
<cfquery name="GetDataB" datasource="#Application.ds#" maxrows=1>
Select Category.categoryID, Category, SubCategory.subcategoryid, subcategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = Category.CategoryID
	AND Product_SUBCategory_Map.ProductID = #ProductID#
</cfquery>
<!---- TO see Deal price --->
<cfset Starttime = '06:00 AM'>
<cfif #TimeFormat(now(),'hh:mm tt')# gte #TimeFormat(Starttime,'hh:mm tt')#>
  <cfquery name="GetDealProduct" datasource="#Application.ds#">
			Select ProductID, StartDate, DailyDealPrice from Deal
			WHERE StartDate >= '#DateFormat(now(),'mm/dd/yyy')#'
			And StartDate < '#DateFormat(now()+1,'mm/dd/yyy')#'
		</cfquery>
  <cfset DailyDealPrice = #GetDealProduct.DailyDealPrice#>
  <cfelseif #TimeFormat(now(),'hh:mm tt')# lt #TimeFormat(Starttime,'hh:mm tt')#>
  <cfquery name="GetDealProduct" datasource="#Application.ds#">
			Select ProductID, StartDate, DailyDealPrice from Deal
			WHERE StartDate >= '#DateFormat(now()-1,'mm/dd/yyy')#'
			And StartDate < '#DateFormat(now(),'mm/dd/yyy')#'
		</cfquery>
  <cfset DailyDealPrice = #GetDealProduct.DailyDealPrice#>
</cfif>
<cfif #GetDealProduct.ProductID# eq "">
  <cfquery name="GetDealProduct" datasource="#Application.ds#">
			Select ProductID, StartDate, DailyDealPrice from Deal 
			WHERE StartDate = (SELECT Max(startdate) as sdate
			FROM Deal
			WHERE (((Deal.startdate)< '#DateFormat(now(),'mm/dd/yyy')#' )));
		</cfquery>
  <cfset DailyDealPrice = #GetDealProduct.DailyDealPrice#>
</cfif>
<!--- End to see Deal price --->
<cfoutput query="GetData">
  <cfif #GetDealProduct.ProductID# eq #ProductID#>
    <cfif #DailyDealPrice# neq 0.0000>
      <cfset newprice = #DailyDealPrice#>
      <cfelse>
      <cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">
    </cfif>
    <cfelse>
    <cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">
  </cfif>
</cfoutput>

<cfparam name="form.yourname" default="">
<cfparam name="form.youremail" default="">
<cfparam name="form.friendname" default="">
<cfparam name="form.friendemail" default="">
<cf_doctype>
<cf_html>
<head>
<title>Email This Item</title>
<meta name="verify-v1" content="2qEa0Zn/k8w/fd2pxQAwdb9yha3hU4n9+BqQBX6s0Es=">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="author" content="MaxVite">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Check out Maxvite for all your kosher vitamins, multiple vitamins, natural digestive enzymes, gluten free foods, vitamin supplements and skin care needs.">
<meta name="keywords" content="Natural Digestive Enzymes, Fish Oil Suppments, Hand Body Lotion, Gluten Free Foods, Kosher Vitamins, Multiple Vitamins, Vitamin Supplements, Skin Care">
<link rel="stylesheet" href="http://www.maxvite.com/css/common.css" media="screen">
<link rel="stylesheet" href="http://www.maxvite.com/css/popup.css" media="screen">

<cfif structKeyExists(form, "save")>
  <cfset errors = []>
  <cfif not len(trim(form.yourname))>
    <cfset arrayAppend(errors, "You must include your name.")>
  </cfif>
  <cfif not len(trim(form.youremail)) or not isValid("email", form.youremail)>
    <cfset arrayAppend(errors, "You must include your valid email address.")>
  </cfif>
  <cfif not len(trim(form.friendname))>
    <cfset arrayAppend(errors, "You must include your friend's name.")>
  </cfif>
  <cfif not len(trim(form.friendemail)) or not isValid("email", form.friendemail)>
    <cfset arrayAppend(errors, "You must include your friend's valid email address.")>
  </cfif>
  <cfif arrayLen(errors) is 0>
    <style>
#emailItemForm {
display:none;	
}
#emailSent {
display:block;
}
</style>

<script>
setTimeout('self.close();',1000);
</script>
<cfmail TO="#friendemail#" FROM="info@maxvite.com" subject="#friendname# wants you to check out this product" server="#Application.mailserver#" username="#Application.mailuser#" password="#Application.mailpassword#" query="GetData" type="HTML">
<cf_email-template-top>
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Dear #friendname#,</p>
                  <br>
                  <p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">#yourname# (#youremail#) was on MaxVite.com and wants you to check out this product.</p>
                  <br>
                  <br>
                  <table cellspacing="0" cellpadding="0">
                    <tr>
                      <td valign="top"><a href="http://www.maxvite.com/#getdataB.subcategoryid#/#productid#/#replace(replace(replace(replace(replace(replace(replace(replace(replace(Title," ","_","all"),"'","","all"),"&","","all"),".","","all"),"+","_","all"),":","","all"),"%","","all"),"##","","all"),"-","","all")#/product.html" target="_new"><img src="http://www.maxvite.com/images/#replace(imagebig," ","%20","All")#" border="0" alt="#getdata.Title#" style="border: 0; max-width: 250px; display: block;" /></a></td>
                      <td width="57"></td>
                      <td valign="top"><h1 style="margin: 0 0 0.8em; font-size: 18px; font-weight: bold; font-family: Arial, Helvetica, sans-serif; color: ##bf000b; text-decoration: none;"><a href="http://www.maxvite.com/#getdataB.subcategoryid#/#productid#/#replace(replace(replace(replace(replace(replace(replace(replace(replace(Title," ","_","all"),"'","","all"),"&","","all"),".","","all"),"+","_","all"),":","","all"),"%","","all"),"##","","all"),"-","","all")#/product.html" target="_new" style="font-size: 18px; font-weight: bold; font-family: Arial, Helvetica, sans-serif; color: ##004922; text-decoration: none;">#Title#</a></h1>
                        <h2 style="font-size: 15px; font-weight: bold; margin: 0 0 0.8em; font-family: Arial, Helvetica, sans-serif; color: ##004922;">#strapline#</h2>  
                        <p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">
                                <cfif newprice neq 0>
          <cfif #round(Evaluate(    ((val(listprice)-val(newprice))/val(listprice)) *100))# GT 0>
            <h1 style="margin: 0 0 0.8em; font-size: 18px; font-weight: bold; font-family: Arial, Helvetica, sans-serif; color: ##bf000b; text-decoration: none;">Price: #DollarFormat(newprice)#</h1>
          </cfif>
        </cfif>
                        
                        </p>
                        <p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;"><a href="http://www.maxvite.com/#getdataB.subcategoryid#/#productid#/#replace(replace(replace(replace(replace(replace(replace(replace(replace(Title," ","_","all"),"'","","all"),"&","","all"),".","","all"),"+","_","all"),":","","all"),"%","","all"),"##","","all"),"-","","all")#/product.html" target="_new" style="text-decoration: none; color: ##004922;"><img src="http://www.maxvite.com/img/view-full-details-big-btn.gif" height="26" alt="view full details" style="border: 0; display: block;" width="148" /></a></p></td>
                    </tr>
                  </table>
                  
                  <br>
                  <p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Happy Shopping!</p>
                  <br>
                  <p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">MaxVite Customer Service Team</p>
                  <br>
<cf_email-template-bottom>
    </cfmail>
  </cfif>
</cfif>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="https://ajax.microsoft.com/ajax/jquery.validate/1.8.1/jquery.validate.min.js"></script>
<script>
$(function(){ 
//sign slidedown validation
$("#emailItemForm").validate({
	rules: {
		youremail: {
			required: true,
			email:true
		},
		friendemail: {
			required: true,
			email:true
		},
		yourname: {
			required: true,
			minlength: 1
		},
		friendname: {
			required: true,
			minlength: 1
		}		
	}
});		   
});

</script>
</head>
<body>
<div id="header"><img src="http://www.maxvite.com/img/popup-header.gif" width="281" height="47" alt="MaxVite"></div>
<div id="main">


<h1 id="emailSent">Your message has been sent!</h1>
<form id="emailItemForm" action="http://www.maxvite.com/email-friend.cfm?ProductID=<cfoutput>#ProductID#</cfoutput>" method="post">
<h1>Email this item</h1>

<p>Enter a friend's name and e-mail below to send this product information.</p>

<p>All fields are required.</p>
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
<table class="formLayout"><tbody>
<tr><td><label for="yourname">Your name</label></td><td><input type="text" id="yourname" name="yourname" size="25" value="#form.yourname#" /></td></tr> 
<tr><td><label for="youremail">Your e-mail</label></td><td><input type="text" id="youremail" name="youremail" size="25" value="#form.youremail#" /></td></tr>      
<tr><td><label for="friendname">Friend's name</label></td><td><input type="text" id="friendname" name="friendname" size="25" value="#form.friendname#" /></td></tr>      
<tr><td><label for="friendemail">Friend's email</label></td><td><input type="text" id="friendemail" name="friendemail" size="25" value="#form.friendemail#" /></td></tr>      
<tr><td>&nbsp;</td><td><button class="btn bigButton" name="save" type="submit">SEND</button></td></tr>
</tbody></table>  
    </cfoutput>   
</form>
</div>
</body>
</html>