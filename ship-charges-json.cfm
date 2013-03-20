<cfif #Session.Storediscount# eq "">
	<cfset storedisc = 0>
<cfelse>
	<cfset storedisc = #Session.Storediscount#>
</cfif>

<cfset v_creditamount = 0>
<cfset v_couponcode = "">
<cfset v_coupondesc = "">

<cfset CouponCode = #Session.StoreCoupon#>
<cfquery name="GetCoupon" datasource="#Application.ds#" maxrows="1">
			SELECT Credits,Description as CDESC FROM Coupons
			Where Ucase(Code) = '#Ucase(CouponCode)#'
</CFQUERY>
<cfoutput>


<cfif GetCoupon.recordcount EQ 0>
	<!---<cfset v_creditamount = 0>---><cfset v_creditamount = #storedisc#>

<cfelse>
	<!---<cfset v_creditamount = GetCoupon.Credits>---><cfset v_creditamount = #storedisc#>
	<cfset v_couponcode = "#couponcode#">
	<cfset v_coupondesc = "#GetCoupon.cdesc#">
</cfif>
</cfoutput>
	<cfset v_taxamount = 0>
	<cfset v_heavyitem = 0>
	<cfset v_freeitem = 0>
	<CFSET TotalCost = 0>
	<CFSET SubTotal = 0>
	<cfset v_weight = 0>

<cfset v_amount_viatmin = 0>
<cfset v_weight_viatmin = 0>
<cfset v_amount_food = 0>
<cfset v_weight_food = 0>

<cfset v_weight_tot = 0>
<cfset v_amount_tot = 0>


	<!--- Loop over the list of items in the shopping cart --->
	<CFLOOP LIST="#session.StoreItems#" INDEX="CurrentItemID">

		<CFSET ItemPosition = ListFind(session.StoreItems, CurrentItemID)>
		<CFSET Quantity = ListGetAt(session.StoreItemsQty, ItemPosition)>

		<cfquery name="GetData1" datasource="#Application.ds#">
			SELECT * FROM Products
			WHERE ProductID = #CurrentItemID#
		</CFQUERY>
		<cfquery name="GetDataB" datasource="#Application.ds#">
			SELECT * FROM Brands
			WHERE BrandID = #Getdata1.BrandID#
		</CFQUERY>

		
		<cfoutput query="GetData1">
		<!---<cf_getprice ProductID="#ProductID#" RetailPrice="#GetData1.Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">--->
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

			<cfset Price = #newprice#>
			<cfset Title = #GetData1.Title#>
			<cfset v_brand = #GetDataB.brand#>
			<cfset Tablets = #GetData1.Tablets#>
<!--- 			<cfif FreeShippingFlag EQ 1><cfset v_freeitem = v_freeitem + 0><cfelse><cfset v_freeitem = v_freeitem + 1></cfif>			 --->
			<cfif HeavyItemFlag EQ 1><cfset v_heavyitem = 1></cfif>




			<!--- Viatmin --->
			<cfif FreeShippingFlag EQ 1 AND HeavyItemFlag EQ 0>
				<cfset v_amount_viatmin = v_amount_viatmin + (newprice * Quantity)>
				<cfset v_weight_viatmin = v_weight_viatmin + (weight * Quantity)>

			<cfset v_weight_tot = v_weight_tot + v_weight_viatmin>
			<cfset v_amount_tot = v_amount_tot + v_amount_viatmin>

			</cfif>
			<!--- Food --->
			<cfif FreeShippingFlag EQ 0 AND HeavyItemFlag EQ 1>
				<cfset v_amount_food = v_amount_food + (newprice * Quantity)>
				<cfset v_weight_food = v_weight_food + (weight * Quantity)>

			<cfset v_weight_tot = v_weight_tot + v_weight_food>
			<cfset v_amount_tot = v_amount_tot + v_amount_food>


			</cfif>


			<cfif taxflag EQ 1>
				<cfset v_taxamount = v_taxamount + (Price * Quantity)>
			</cfif>
		</cfoutput>


		<!--- Now display the data for the current item --->
		<CFOUTPUT>



		<CFSET TotalCost = TotalCost + newprice * Quantity>
		<CFSET SubTotal = SubTotal + newprice * Quantity>



		</CFOUTPUT>
	</CFLOOP>


<cfset v_amount_tot = v_amount_viatmin + v_amount_food>

<cfset shipmethod="G">
<cfset ship_state="#Ship_State#">
<cfif ship_state EQ "NY">
<cfset SHIP_ZIPCODE="10002">
<cfelse>
<cfset SHIP_ZIPCODE="#Ship_Zipcode#">
</cfif>
<!--- Shipping --->
<cfset v_ship = 0>
<cfset v_service = "">
<cfset v_serviced = "">
<cfif shipmethod EQ "G">
	<cfset v_service = "GNDRES">
	<cfset v_shipmethod = "UPS Ground">
<cfelseif shipmethod EQ "N">
	<cfset v_service = "1DA">
	<cfset v_shipmethod = "UPS Next Day">
<cfelseif shipmethod EQ "F">
	<cfset v_service = "RDA">
	<cfset v_shipmethod = "Free UPS Ground">
</cfif>
<!--- <cfif shipmethod EQ "G">

	<cfif v_amount_viatmin GT 75>
		<cfset v_ship = 0>
		<cfif v_weight_food GT 32> <!--- ounces was 2 --->

			<cfset v_tttt2 = #evaluate(v_weight_food-32)# * .0625> <!--- 32 ounces was 2 --->
			<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#v_tttt2#" HANDLING="0">
			<cfset v_ups = val(UPS_Charge)>
			<cfset v_ship = v_ship + v_ups>
		<cfelse>
			<cfset v_ship = v_ship + 0>
		</cfif>
	<cfelse>
		<cfif v_weight_food eq 0>
			<cfset v_ship = 4.95>
		<cfelse>

					<cfset v_tttt2 = #evaluate(val(v_weight_food)+val(v_weight_viatmin))# * .0625>


			<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#v_tttt2#" HANDLING="0">
			<cfset v_ups = val(UPS_Charge)>
			<cfset v_ship = v_ups>
		</cfif>
	</cfif>
<cfelseif shipmethod EQ "N">
	<cfset v_tttt2 = #evaluate(val(v_weight_food)+val(v_weight_viatmin))# * .0625>
	<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#v_tttt2#" HANDLING="0">
	<cfset v_ups = val(UPS_Charge)>
	<cfset v_ship = v_ups>
</cfif>
 --->


<!--- <cfoutput>
v_amount_food-#v_amount_food#<br>
v_amount_viatmin - #v_amount_viatmin#<br>
v_amount_tot - #v_amount_tot#
</cfoutput>
 --->

<cfif shipmethod EQ "G">
	<!--- Food Only --->
	<cfif v_amount_food GT 0 AND v_amount_viatmin EQ 0>
		<cfset v_tttt2 = #evaluate(v_weight_food)# * .0625>
		<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#v_tttt2#" HANDLING="0">
		<cfset v_ups = val(UPS_Charge)>

		<cfif v_ups EQ 0>
<cfmail to="info@maxvite.com" from="orders@maxvite.com" subject="UPS Returned 0" server="#Application.mailserver#" username="#Application.mailuser#" password="#Application.mailpassword#" type="HTML">
UPS REturned 0
</cfmail>
		</cfif>

		<cfset v_ship = v_ship + v_ups>
	<!--- Not Food --->
	<cfelseif v_amount_food EQ 0 AND v_amount_viatmin GT 0>
		<cfif v_amount_viatmin-val(Session.Storediscount) GT 75 or Session.StoreTotalAmount GT 75>
			<cfset v_ship = 0>
		<cfelse>
			<cfset v_tttt2 = #evaluate(v_weight_viatmin)# * .0625> <!--- 32 ounces was 2 --->
			<!--- <CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#v_tttt2#" HANDLING="0">
			<cfset v_ups = val(UPS_Charge)>
			<cfset v_ship = v_ship + v_ups + 2>
			DOVID--->
			<cfset v_ship = v_ship + 4.95>
		</cfif>
	<!--- Mixture of Food & Not Food --->
	<cfelseif v_amount_food GT 0 AND v_amount_viatmin GT 0>
		<cfif v_amount_viatmin-val(Session.Storediscount) GT 75>
			<cfif val(v_weight_food) LTE 33>
				<cfset v_ship = 0>
			<cfelse>

			<cfset v_tttt2 = #evaluate(val(v_weight_food)+val(v_weight_viatmin))# * .0625>
			<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#evaluate(v_tttt2-2)#" HANDLING="0">
			<cfset v_ups = val(UPS_Charge)>
			<cfset v_ship = v_ship + v_ups>

			</cfif>

		<cfelse>
			<cfset v_tttt2 = #evaluate(val(v_weight_food)+val(v_weight_viatmin))# * .0625>
			<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#v_tttt2#" HANDLING="0">
			<cfset v_ups = val(UPS_Charge)>
			<cfset v_ship = v_ship + v_ups>
		</cfif>
	</cfif>
<cfelseif shipmethod EQ "N">
	<!--- If Overnight --->
	<cfset v_tttt2 = #evaluate(val(v_weight_food)+val(v_weight_viatmin))# * .0625>
	<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#v_tttt2#" HANDLING="0">
	<cfset v_ups = val(UPS_Charge)>
	<cfset v_ship = v_ups>
</cfif>










<!--- <CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ship_zipcode#" WEIGHT="#v_weight#" HANDLING="0">
<CFOUTPUT>
	<cfset v_ups = val(UPS_Charge)>
	<cfset v_ship = v_ups>
	<cfset v_shipmethod = #v_serviced#>
</CFOUTPUT>


3) If they want ground shiping. shipping is free to orders over $75 for Vitamins, minerals and herbs + the rest of the items : up to 2lb is free and the rest goes by weight
4) If they want it by next day all goes by weight
 --->

	<cfoutput>
	<cfset nTotalCost = TotalCost -	v_creditamount>


	<cfset v_tax = 0>
	<cfset v_total = 0>
	<cfif Ship_State EQ "NY">

<cfquery name="GetTax" datasource="#Application.ds#">
	SELECT NYSalesTax
	FROM SystemOptions
</CFQUERY>
<cfif GetTax.NYSalesTax GT 0>
		<cfset v_tax = (GetTax.NYSalesTax * v_taxamount)>
<cfelse>
		<cfset v_tax = 0>
</cfif>
	</cfif>
	</cfoutput>

<!--- <cfquery name="GetFS" datasource="#Application.ds#">
	SELECT FreeShipping
	FROM SystemOptions
</CFQUERY>
<cfif GetFS.Recordcount GT 0>
		<cfset v_fs_threshold = GetFS.FreeShipping>
<cfelse>
		<cfset v_fs_threshold = 0>
</cfif>


<cfquery name="GetData" datasource="#Application.ds#">
	SELECT *
	FROM ShippingPrices,ShippingMethods
	WHERE ShippingPrices.ShippingTypeID=ShippingMethods.ShippingTypeID
	AND ShippingPriceID = #SHIPMETHOD#
</CFQUERY>
<cfoutput query="GetData">
<cfset v_ship = #Amount#>
<cfset v_shipmethod = #ShippingMethod#>
</cfoutput>

<cfif v_heavyitem EQ 1>
	<cfset v_ship = 0>
	<cfset v_shipmethod = "TBD">
</cfif>
<cfif v_freeitem EQ 0 AND Totalcost GT v_fs_threshold AND GetData.ShippingTypeID EQ 1>
	<cfset v_ship = 0>
<cfelse>
</cfif> --->





<!--- Daya Added on 20101116 against email "Sub: can someone look at this? Dt:Thu 11/11/2010 11:18 PM" --->
<!--- Daya 20101116 Start --->
<cfif isdefined("Session.subtotalamount")>
	<cfif val(#Session.subtotalamount#) gt 0>
		<cfset v_total = val(#Session.subtotalamount#) + v_tax + v_Ship>
	<cfelse>
		<cfset v_total = TotalCost + v_tax + v_Ship - v_creditamount>
	</cfif>
<cfelse>
	<cfset v_total = TotalCost + v_tax + v_Ship - v_creditamount>
</cfif>
<!--- Daya 20101116 End --->


<!--- Daya 20101116
	<cfset v_total = TotalCost + v_tax + v_Ship - v_creditamount>
--->


<!---<div class="discountSummaryRow">
        <span class="discountSummaryTitle">Coupon Discount:</span>
        <span class="discountSummaryPrice"><cfoutput>#DollarFormat(v_creditamount)#</cfoutput></span>
</div>--->
<cfoutput>
<div class="discountSummaryRow">
        <span class="discountSummaryTitle">Shipping:</span>
        <span class="discountSummaryPrice" id="getShipPrice">#DollarFormat(v_ship)#</span>
</div>
<div class="discountSummaryRow">
        <span class="discountSummaryTitle">Tax:</span>
        <span class="discountSummaryPrice" id="getTax">#DollarFormat(v_tax)#</span>
</div>
<div class="line"></div>
    <div class="discountSummaryRow">
        <span class="discountSummaryTitle" id="orderTotalTitle">Order Total:</span>
        <span class="discountSummaryPrice" id="orderTotal">#DollarFormat(v_total)#</span>
    </div>
<cfprocessingdirective suppresswhitespace="yes">
<cfsetting showdebugoutput="no">
<!--- Generate the JSON feed as a JavaScript function. --->
<cfcontent type="application/x-javascript">

<cfscript>
    // Construct a weather query with information on cities.
    // To simplify the code, we use the same weather for all cities and days.
    // Normally this information would come from a data source.
    weatherQuery = QueryNew("City, Temp, Forecasts");
    QueryAddRow(weatherQuery, 2);
    theWeather=StructNew();
    theWeather.High=73;
    theWeather.Low=53;
    theWeather.Weather="Partly Cloudy";
    weatherArray=ArrayNew(1);
    for (i=1; i<=5; i++) weatherArray[i]=theWeather;
    querySetCell(weatherQuery, "City", "Newton", 1);
    querySetCell(weatherQuery, "Temp", "65", 1);
    querySetCell(weatherQuery, "ForeCasts", weatherArray, 1);
    querySetCell(weatherQuery, "City", "San Jose", 2);
    querySetCell(weatherQuery, "Temp", 75, 2);
    querySetCell(weatherQuery, "ForeCasts", weatherArray, 2);

    // Convert the query to JSON.
    // The SerializeJSON function serializes a ColdFusion query into a JSON
    // structure.
    theJSON = SerializeJSON(weatherQuery);
    
    // Wrap the JSON object in a JavaScript function call.
    // This makes it easy to use it directly in JavaScript.
    writeOutput("onLoad( "&theJSON&" )");
</cfscript>
</cfprocessingdirective>

</cfoutput>
