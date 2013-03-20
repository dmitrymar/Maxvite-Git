
<CFTRANSACTION>


		<cfif isdefined('specialofferemails')>
		
		<cfquery name="GetOfferEmail" datasource="#Application.ds#" maxrows="1">
		Select EmailAddress from Emails Where EmailAddress = '#Ucase(Email)#'
		</cfquery>

		<cfif GetOfferEmail.Recordcount EQ 0>
			<cfquery name="GetData1" datasource="#Application.ds#">
				INSERT INTO Emails
				(EmailAddress, DateJoined)
				VALUES
				('#Ucase(Email)#', #now()#)
			</cfquery>
		</cfif>
		
		</cfif>
		
		<cfquery name="GetData" datasource="#Application.ds#">
			Select *
			from Users
			Where Ucase(Username) = '#Ucase(Email)#'
		</cfquery>
		<cfif GetData.Recordcount GT 0>
			<cfset UNE = "TRUE">
		<cfelse>
		<cfquery name="GetData" datasource="#Application.ds#">
			INSERT INTO Users
				(
					USERNAME,
					EMAIL,
					PASSWORD,
					FIRSTNAME,
					LASTNAME,
					LEVELID,
					DATEJOINED,
					ACTIVE,
					SPECIALOFFEREMAILS
				)
			VALUES
				(
					'#email#',
					'#email#',
					'#password#',
					'#firstname#',
					'#lastname#',
					2,
					#now()#,
					1,
					<cfif isdefined('specialofferemails')>'yes'<cfelse>'No'</cfif>
				)
		</CFQUERY>
		
		
		
		<cfquery name="GetKey" datasource="#Application.ds#">
			Select @@IDENTITY as TKEY FROM Products
		</cfquery>
		<cfoutput query="GetKey">
			<cfset key = #GetKey.TKEY#>
		</cfoutput>
		<cfset session.logon = "TRUE">
		<cfset session.levelID = 2>
		<cfset session.UserID = "#key#">

		</cfif>
</cftransaction>


<cfmail to="#email#" from="info@maxvite.com" subject="Thank you for signing up with MaxVite.com!" server="#Application.mailserver#" username="#Application.mailuser#" password="#Application.mailpassword#" type="HTML">
<cf_email-template-top>
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;"><b>Welcome to MaxVite.com!</b></p>
     <br>
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Thanks so much for registering with us.</p>
    <br>                                                                                                                   
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Your user name: #Email#</p>

<p><a href="http://www.maxvite.com/" target="_new"><img src="http://www.maxvite.com/img/shop-now-big-btn.gif" alt="shop now" width="99" height="26" style="border: 0;"></a></p>                  

                  <p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Happy Shopping!</p>
                  <br>
                  <p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">MaxVite Customer Service Team</p>
<br>
<cf_email-template-bottom>

</cfmail>




<cfquery name="GetDataI" datasource="#Application.ds#">
SELECT Products.ProductID, Products.FeaturedProductFLAG, FeaturedProductFLAG2, Title, strapline, listprice, tablets, ourprice, subcategoryid, imagesmall from Products, Product_SUBCategory_Map
	Where Products.ProductID = Product_SUBCategory_Map.ProductID
	AND FeaturedProductFLAG = 1
	Order by Products.SortID
</cfquery>



<cf_doctype>
<cf_html>
<cfset UNE = "FALSE"><head>
	<title><cf_title></title>
	<cf_meta10>

</head>


<body>
<cf_header>
<section id="middleArea">
  <div id="crux">




<cfif UNE IS "TRUE">

<h2 class="topmargin">Please choose another username!</h2> 
<p class="topmargin"><cfoutput>#GetData.Email#</cfoutput> already exists! Use your browsers back button to edit.</p>

<cfelse>


<h2 class="topmargin">Thank you for signing up with MaxVite.com</h2>

	<p class="topmargin">You will be receiving an email confirming your account registration.</p>

<cfif Isdefined("CHECKOUT")>
	<cflocation url="https://www.maxvite.com/checkout.cfm" addtoken="Yes">
</cfif>

</cfif>


  </div>
</section>
<!--end middleArea-->
<cf_footer>
</body>
</html>