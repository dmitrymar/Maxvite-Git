<cfset rowsection = "">
<cfquery name="GetDataBrandSpl" datasource="#Application.ds#" maxrows="12">
	SELECT *
	FROM brandspecials
	Order by SortID
    LIMIT 3
</cfquery>
<cfquery name="GetDataWeekly" datasource="#Application.ds#">
	SELECT * from Products, Product_SUBCategory_Map, Brands
	Where Products.ProductID = Product_SUBCategory_Map.ProductID
    AND Products.BrandID = Brands.BrandID
	AND FeaturedProductFLAG = 1
	Order by Products.SortID
    LIMIT 1
</cfquery>
<cfquery name="GetDataSuperDeals" datasource="#Application.ds#">
	SELECT * from Products, Product_SUBCategory_Map, Brands
	Where Products.ProductID = Product_SUBCategory_Map.ProductID
    AND Products.BrandID = Brands.BrandID
	AND FeaturedProductFLAG2 = 1
	Order by Products.SortID
    LIMIT 1
</cfquery>
<cfquery name="GetDataBOGO" datasource="#Application.ds#">
	SELECT * from Products, Product_SUBCategory_Map, Brands
	Where Products.ProductID = Product_SUBCategory_Map.ProductID
    AND Products.BrandID = Brands.BrandID
	AND FeaturedProductFLAG3 = 1
	Order by Products.SortID
    LIMIT 1
</cfquery>
<!--- Start Deal Query --->
<cfset Starttime = '06:00 AM'>
<cfset DailyDealPrice = 0>
<cfif #TimeFormat(now(),'hh:mm tt')# gte #TimeFormat(Starttime,'hh:mm tt')#>
  <cfquery name="GetDealProduct" datasource="#Application.ds#">
			Select ProductID, StartDate, DailyDealPrice from Deal
			WHERE StartDate >= '#DateFormat(now(),'mm/dd/yyy')#'
			And StartDate < '#DateFormat(now()+1,'mm/dd/yyy')#'
		</cfquery>
  <cfset ProductID = #GetDealProduct.ProductID#>
  <cfset DailyDealPrice = #GetDealProduct.DailyDealPrice#>
  <cfelseif #TimeFormat(now(),'hh:mm tt')# lt #TimeFormat(Starttime,'hh:mm tt')#>
  <cfquery name="GetDealProduct" datasource="#Application.ds#">
			Select ProductID, StartDate, DailyDealPrice from Deal
			WHERE StartDate >= '#DateFormat(now()-1,'mm/dd/yyy')#'
			And StartDate < '#DateFormat(now(),'mm/dd/yyy')#'
		</cfquery>
  <cfset ProductID = #GetDealProduct.ProductID#>
  <cfset DailyDealPrice = #GetDealProduct.DailyDealPrice#>
</cfif>
<cfif ProductID eq "">
  <cfquery name="GetDealProduct" datasource="#Application.ds#">
			Select ProductID, StartDate, DailyDealPrice 
      FROM Deal 
      ORDER BY startdate DESC
      LIMIT 1
		</cfquery>
  <cfset ProductID = #GetDealProduct.ProductID#>
  <cfset DailyDealPrice = #GetDealProduct.DailyDealPrice#>
</cfif>
<cfquery name="GetDealData" datasource="#Application.ds#">
	Select * from Products, Brands
	Where Products.BrandID = Brands.BrandID
	AND ProductID = #ProductID#
</cfquery>
<!--- End Deal Query --->

<cffunction name="displayrow" access="public" output="yes" returnType="void" 
	hint="Prining product row.">
<cfset usavedollars = val(listprice)-val(newprice)>
<cfset usavepcnt = round(Evaluate(    ((val(listprice)-val(newprice))/val(listprice)) *100))>

<cfif rowsection EQ "dealrow">
<cfset productURL = "/deal-of-the-day.html">
<cfelse>
<cfset productURL = "/#productid#/#ReReplace(title,"[^0-9a-zA-Z]+","-","ALL")#/product.html">
</cfif>

<ul class="product-row">
  <li class="thumb"><a href="#productURL#"><span></span><img src="/images/#imagebig#" alt="#title#"></a></li>
  <li class="info"> <a href="#productURL#">
    <h2>#title#</h2>
    <p>#StrapLine#</p>
    </a>
    <dl class="spex">
      <dt>Serving Size:</dt>
      <dd>#ServingSize#</dd>
      <dt>Size/Form:</dt>
      <dd>#tablets#</dd>
    </dl>
  </li>
  <li class="price-box">
    <form class="additemform">
          <input type="hidden" name="ProductID" value="#ProductID#">
          
<cfif rowsection EQ "buy1row">
<p class="inlineh1">Get 2 For Only #Dollarformat(listprice)#<br>Buy 1 Get 1 Free</p>
            <input type="hidden" name="qtytoadd" value="2">

<button class="btn bigButton" name="addtocart" type="submit">Add To Cart</button>
        <span class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</span>
<cfelse>
    <p class="inlineh1">Special only #DollarFormat(newprice)#</p>

    <span class="listprice">Was: <span class="strike">#Dollarformat(ListPrice)#</span></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="red"><strong>You Save:&nbsp;#DollarFormat(usavedollars)# (#usavepcnt#%)</strong></span>

      <p class="listViewQtyBox"> <span class="listViewQty">Quantity</span>
        <input name="qtytoadd" type="text" value="1" maxlength="4" class="qtyInput" size="3">
        <button class="btn bigButton" name="addtocart" type="submit">Add To Cart</button>
        <span class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</span> </p>
</cfif>

    </form>
  </li>
</ul>

</cffunction>


<ul class="headline"><li class="icon"></li><li class="title">Brand Specials</li><li class="right"><a class="decolink" href="/brandspecials.html">View All</a></li></ul>

<ul class="brand-special-wrpr">
  <cfoutput query="GetDataBrandSpl">
    <li><a href="#LinkUrl#"><img src="/img/brand-specials/#FileName#" alt="#BrandName#"></a></li>
  </cfoutput>
</ul>

<ul class="headline"><li class="icon deal"></li><li class="title">Deal of the Day</li><li class="right"><a class="decolink" href="/deal-of-the-day.html">More Info</a></li></ul>
<cfoutput query="GetDealData">
  <cfif #DailyDealPrice# neq 0.0000>
    <cfset #newprice# = #DailyDealPrice#>
    <cfelse>
    <cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">
  </cfif>
  <cfset rowsection = "dealrow">
#displayrow()#
</cfoutput>

<ul class="headline"><li class="icon weekly"></li><li class="title">Weekly Specials</li><li class="right"><a class="decolink" href="/54/313/S/Weekly-Specials/items.html">View All</a></li></ul>
<cfoutput query="GetDataWeekly">
<cfinclude template="dealquery.cfm">
  <cfset rowsection = "weeklyrow">
#displayrow()#
</cfoutput>

<ul class="headline"><li class="icon super"></li><li class="title">Super Deals</li><li class="right"><a class="decolink" href="/54/865/S/Super-Deals/items.html">View All</a></li></ul>
<cfoutput query="GetDataSuperDeals">
<cfinclude template="dealquery.cfm">
  <cfset rowsection = "superdealrow">
#displayrow()#
</cfoutput>

<ul class="headline"><li class="icon bogo"></li><li class="title">Buy 1 Get 1 Free</li><li class="right"><a class="decolink" href="/54/554/S/Buy-One-Get-One-Free/items.html">View All</a></li></ul>
<cfoutput query="GetDataBOGO">
<cfinclude template="dealquery.cfm">
  <cfset rowsection = "buy1row">
#displayrow()#
</cfoutput>