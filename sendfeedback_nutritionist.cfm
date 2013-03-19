
<cfquery name="GetDataI" datasource="#Application.ds#">
SELECT Products.ProductID, Products.FeaturedProductFLAG, FeaturedProductFLAG2, Title, strapline, listprice, tablets, ourprice, subcategoryid, imagesmall from Products, Product_SUBCategory_Map
	Where Products.ProductID = Product_SUBCategory_Map.ProductID
	AND FeaturedProductFLAG = 1
	Order by Products.SortID
</cfquery>


<cf_doctype>
<cf_html>
<head>
	<title><cf_title></title>
	<cf_meta10>

</head>


<body>
<div class="wrapper">
<cf_header>

<div class="content">
 
<div class="primary">
<h1>Thank you <cfoutput>#fname#</cfoutput></h1>

<p class="topmargin">We will get in touch with you within 1 or 2 business days.</p>


<cfmail TO="nutritionist@maxvite.com" FROM="nutritionist@maxvite.com" subject="Nutritionist Request from Web Site" server="win-mail01.hostmanagement.net" username="nutritionist@maxvite.com" password="Maxi1305">

First Name: #fname#

Last Name: #lname#

Email: #email#

Comments? #comment#

</cfmail>



</div> <!--end primary-->
<cf_secondary>

 
</div> 
<!--end content-->
 
 <cf_footer>
 
</div><!--end wrapper-->


</body>
</html>