<cfquery name="GetDataBrandSpl" datasource="#Application.ds#" maxrows="12">
	SELECT *
	FROM brandspecials
	Order by SortID
    LIMIT 3
</cfquery>


<div class="headline">
  <div class="left brand">Brand Specials</div>
  <div class="right"><a class="decolink" href="/brandspecials.html">View All</a></div>
</div>
<ol class="brand-special-wrpr">
  <cfoutput query="GetDataBrandSpl">
    <li><a href="#LinkUrl#"><img src="/img/brand-specials/#FileName#" alt="#BrandName#"></a></li>
  </cfoutput>
</ol>





        
<div class="headline">
  <div class="left"><span class="deal"></span><span class="head">Deal of the Day</span></div>
  <div class="right"><a class="decolink" href="/54/865/S/Super-Deals/items.html">View All Super Deals</a></div>
</div>
<cfinclude template="/specials-row.cfm">
<div class="headline">
  <div class="left">Buy 1 Get 1 Free</div>
  <div class="right"><a class="decolink" href="/54/554/S/Buy-One-Get-One-Free/items.html">View All Buy 1 Get 1 Free</a></div>
</div>
<cfinclude template="/specials-row.cfm">