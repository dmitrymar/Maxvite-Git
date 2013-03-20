<!---based on checkout2.cfm--->
<cfif Session.StoreItems EQ ""><cflocation url="http://www.maxvite.com/index.html" addtoken="No"></cfif>

<cfset checkoutTitle = "">
<cfset ezip = #ezipcode#>
<cfset discount_amount_cart = #discount_amount_cart#>
<cfset sm = #ShipMethod#>
<cfset Ship_State = "">
<cfset checkoutTitle = "Paypal">


<cfset jSonURL="http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=" />
<cftry>
	<cfhttp url="#jSonURL##ezipcode#" result="feeditems" />
	<cfset items = deserializeJson(feedItems.fileContent) />
    <cfset components=items.results[1].address_components>    
	<cfset theData=components[ArrayLen(components)-1].short_name>
	<cfset isUS=components[ArrayLen(components)].short_name>
    
	<cfif isUS eq "US">
<cfset Ship_State = #theData#>





<cfparam name="cartID" default="createUUID()">
<cfset session.GoogleCart =  createObject("component","components.googlecheckout")>



     
	<cfset v_freeshippitemsamount = 0>
	<cfset v_heavyitem = 0>
	<cfset v_freeitem = 0>

	<CFSET TotalCost = 0>

	<!--- Loop over the list of items in the shopping cart --->
	<CFLOOP LIST="#session.StoreItems#" INDEX="CurrentItemID">

		<CFSET ItemPosition = ListFind(session.StoreItems, CurrentItemID)>
		<CFSET Quantity = ListGetAt(session.StoreItemsQty, ItemPosition)>

		<cfquery name="GetData1" datasource="#Application.ds#">
			SELECT * FROM Products
			WHERE ProductID = #CurrentItemID#
		</CFQUERY>
		<cfoutput query="GetData1">
		<cf_getprice ProductID="#ProductID#" RetailPrice="#GetData1.Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">

<cfif newprice eq 0>
	<cfset newprice = listprice>
</cfif>
			<!--- Add some items to the cart to get us going --->
			<cfset desc = #intProductID# &" - " &#title# &" (" &#Tablets# &") ">
			<cfset session.GoogleCart.AddCartItem(productID=#ProductID#,item=#intProductID#,description=#desc#,cost=#newprice#,quantity=#Quantity#)>

			<cfset Price = #newprice#>
			<cfset Title = #GetData1.Title#>
			<cfset Tablets = #GetData1.Tablets#>
			<cfif FreeShippingFlag EQ 1><cfset v_freeitem = v_freeitem + 0><cfelse><cfset v_freeitem = v_freeitem + 1></cfif>
			<cfif HeavyItemFlag EQ 1><cfset v_heavyitem = 1></cfif>
		</cfoutput>


		<!--- Now display the data for the current item --->

		<CFOUTPUT>
		<CFSET TotalCost = TotalCost + (Price * Quantity)>


		</CFOUTPUT>
	</CFLOOP>




	<cfset v_amount_viatmin = 0>
	<cfset v_weight_viatmin = 0>
	<cfset v_amount_food = 0>
	<cfset v_weight_food = 0>

	<cfset v_weight_tot = 0>
	<cfset v_amount_tot = 0>
	<cfset v_taxamount = 0>
	<cfset v_heavyitem = 0>
	<cfset v_freeitem = 0>
	<CFSET TotalCost = 0>
	<CFSET SubTotal = 0>
	<cfset v_weight = 0>
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
		<cf_getprice ProductID="#ProductID#" RetailPrice="#GetData1.Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">

<cfif newprice eq 0>
	<cfset newprice = listprice>
</cfif>

			<cfset Price = #newprice#>
			<cfset Title = #GetData1.Title#>
			<cfset v_brand = #GetDataB.brand#>
			<cfset Tablets = #GetData1.Tablets#>
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


<!--- Shipping --->
<cfset v_ship = 0>
<cfset v_service = "">
<cfset v_serviced = "">
<cfif SM EQ "G">
<!--- 	<cfif trim(form.ship_company) EQ ""> --->
		<cfset v_service = "GNDRES">
		<cfset v_shipmethod = "UPS Ground">
<!--- 	<cfelse>
		<cfset v_service = "GNDCOM">
		<cfset v_shipmethod = "UPS Ground">
	</cfif> --->
<cfelseif SM EQ "N">
	<cfset v_service = "1DA">
	<cfset v_shipmethod = "UPS Next Day">
</cfif>





<cfif SM EQ "G">
	<!--- Food Only --->
	<cfif v_amount_food GT 0 AND v_amount_viatmin EQ 0>
		<cfset v_tttt2 = #evaluate(v_weight_food)# * .0625>
		<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ezip#" WEIGHT="#v_tttt2#" HANDLING="0">
		<cfset v_ups = val(UPS_Charge)>

		<cfif v_ups EQ 0>
<cfmail to="info@maxvite.com" from="orders@maxvite.com" subject="UPS Returned 0" server="#Application.mailserver#" username="#Application.mailuser#" password="#Application.mailpassword#" type="HTML">
UPS REturned 0
</cfmail>
		</cfif>

		<cfset v_ship = v_ship + v_ups + 2>
	<!--- Not Food --->
	<cfelseif v_amount_food EQ 0 AND v_amount_viatmin GT 0>
		<cfif v_amount_viatmin GT 75>
			<cfset v_ship = 0>
		<cfelse>
			<cfset v_tttt2 = #evaluate(v_weight_viatmin)# * .0625> <!--- 32 ounces was 2 --->
			<!---<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ezip#" WEIGHT="#v_tttt2#" HANDLING="0">
			<cfset v_ups = val(UPS_Charge)>
			<cfset v_ship = v_ship + v_ups + 2>--->
			<cfset v_ship = v_ship + 4.95>
		</cfif>
	<!--- Mixture of Food & Not Food --->
	<cfelseif v_amount_food GT 0 AND v_amount_viatmin GT 0>
		<cfif v_amount_viatmin GT 75>
			<cfif val(v_weight_food) LTE 33>
				<cfset v_ship = 0>
			<cfelse>

			<cfset v_tttt2 = #evaluate(val(v_weight_food)+val(v_weight_viatmin))# * .0625>
			<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ezip#" WEIGHT="#evaluate(v_tttt2-2)#" HANDLING="0">
			<cfset v_ups = val(UPS_Charge)>
			<cfset v_ship = v_ship + v_ups + 2>

			</cfif>

		<cfelse>
			<cfset v_tttt2 = #evaluate(val(v_weight_food)+val(v_weight_viatmin))# * .0625>
			<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ezip#" WEIGHT="#v_tttt2#" HANDLING="0">
			<cfset v_ups = val(UPS_Charge)>
			<cfset v_ship = v_ship + v_ups + 2>
		</cfif>
	</cfif>
<cfelseif SM EQ "N">
	<!--- If Overnight --->
	<cfset v_tttt2 = #evaluate(val(v_weight_food)+val(v_weight_viatmin))# * .0625>
	<CF_UPSP SERVICE="#v_service#" FROM="11229" TO="#ezip#" WEIGHT="#v_tttt2#" HANDLING="0">
	<cfset v_ups = val(UPS_Charge)>
	<cfset v_ship = v_ups + 2>
</cfif>

<cfset v_tax = 0>
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

<cfset Cart = session.GoogleCart.GetCartItems()>
<cfset session.googleCart.GetZipCode(code=ezip)>
<!---<cfset v_ship = 0.01>--->


						<form action="https://www.paypal.com/cgi-bin/webscr" method="post" name="paypalCart">
							<input type="hidden" name="cmd" value="_cart">
							<input type="hidden" name="upload" value="1">
							<input type="hidden" name="no_shipping" value="2">
							<input type="hidden" name="currency_code" value="USD">
							<input type="hidden" name="image_url" value="https://www.maxvite.com/logo.png">
                            <cfoutput><input type="hidden" name="discount_amount_cart" value="#discount_amount_cart#"></cfoutput>
							<input type="hidden" name="return" value="http://www.maxvite.com/thankyou_paypal.cfm">
							<input type="hidden" name="cancel_return" value="http://www.maxvite.com">
							<input type="hidden" name="business" value="orders@maxvite.com">
							<input type="hidden" name="notify_url" value="http://www.maxvite.com/paypal_ipn.cfm">

							<cfset i = 0>
							<cfif cart.recordcount>
								<cfoutput query="Cart">
									<cfset i = i+1>
									<input type="hidden" name="item_number_#i#" value="#itemname#">
									<input type="hidden" name="item_name_#i#" value="#ITEMDESC#">
									<input type="hidden" name="amount_#i#" value="#val(trim(itemprice))#">
									<input type="hidden" name="quantity_#i#" value="#trim(itemquantity)#">
									<input type="hidden" name="on0_#i#" value="Product id">
									 <input type="hidden" name="os0_#i#" value="#productID#"> 
								</cfoutput>
							</cfif>
							<input type="hidden" name="custom" value="<cfoutput>#i#</cfoutput>">
							<input type="hidden" name="shipping_1" value="<cfoutput>#trim(v_ship)#</cfoutput>">
						</form>
						<script>
							document.paypalCart.submit();
						</script>


    <cfelse>
    This is not a US Zip Code. Please try again.
    
<!---<cfoutput>
<br />
state: #theData#
<br />country: #isUS#
</cfoutput>--->
    
    </cfif>

	<cfcatch>
		<cfoutput>
			Something went wrong with Zip Code Database. Please try again.
		</cfoutput>
	</cfcatch>
</cftry>