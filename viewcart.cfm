<cf_doctype>
<cf_html>
<head>
<title>MaxVite Online Shop - Shopping Cart</title>
<cf_meta10 page="viewcart">
</head>
<body>
<div class="wrapper">
<cf_header>

<div class="content">

<div id="cartWrpr">    





<cfif Listlen(session.storeitems) EQ 0>
<div id="crux" class="align-center"><p class="topmargin"><h2>You have no items in your cart!</h2></p></div>
<cfelse>


<div>
	<!-- cart detail starts -->
<cfform name="viewcart" method="post">

<div class="leftmargin">
<h1 class="topmargin">Your Cart</h1>
<p class="topmargin">Please review your cart contents below. Shipping options and charges will be selected and calculated on the following page.</p>

</div>
<table class="cart-table topmargin">
<thead>
<tr>
<th>Item</th>
<th>Description</th>
<th>Price</th>
<th>Quantity</th>
<th>Edit</th>
<th>Subtotal</th>
</tr>
</thead>
<tbody>
	<CFSET subtotal = 0>
	<!--- Loop over the list of items in the shopping cart --->
	<CFLOOP LIST="#session.StoreItems#" INDEX="CurrentItemID">

		<!--- Find the quantity of each item --->
		<CFSET ItemPosition = ListFind(session.StoreItems, CurrentItemID)>
		<CFSET Quantity = ListGetAt(session.StoreItemsQty, ItemPosition)>

		<!--- This query is just to get the name and price of the current
		      item so that we can display that data in the table --->
		<cfquery name="GetData" datasource="#Application.ds#">
	Select * from Products, Brands
	Where Products.BrandID = Brands.BrandID
	AND ProductID = #CurrentItemID#
		</CFQUERY>
        
		<cfquery name="GetData1" datasource="#Application.ds#" maxrows="1">
			SELECT *
			FROM Product_SUBCategory_Map
			Where ProductID = #CurrentItemID#
		</CFQUERY>

		<!--- Now display the data for the current item --->
		<CFOUTPUT QUERY="GetData">
		<!--- Add cost of current item(s) to total cost --->

<cfset v_subid = GetData1.subcategoryid>
                  <cfset itemURL = "/" & #productid# & "/" & #replace(replace(replace(replace(replace(replace(replace(replace(replace(Title," ","_","all"),"'","","all"),"&","","all"),".","","all"),"+","_","all"),":","","all"),"%","","all"),"##","","all"),"-","","all")# & "/product.html">
                  <cfquery name="GetDataSubc" datasource="#Application.ds#" maxrows=1>
	Select DISTINCT Category.categoryID, Category, SubCategory.subcategoryid, subcategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = 54
	AND Product_SUBCategory_Map.ProductID = #GetData1.ProductID#
</cfquery>

                  <cfinclude template="seedealprice.cfm">
                  <cfif newprice eq 0>
                    <cfset newprice = listprice>
                  </cfif>



<cfinclude template="thumb-style.cfm">

		<input type=hidden name=ProductID value="#ProductID#">
<cfif #GetDataSubc.SubCategoryID# eq 554 and Quantity GTE 2>
<!---This condition for buy 1 get 1 free items--->
<tr>
<td><a href="#itemURL#"><img src="#imageURL#" alt="#Title#"></a></td>
<td><a href="#itemURL#"><strong>#title#</strong></a><br /><em>#Tablets#</em>

<cfset freeItems = Int(Quantity / 2)>


<cfif Quantity MOD 2 EQ 0>
    <!---The number is even!--->
    <cfset itemSubtotal = listprice * freeItems>
<cfelse>
    <!---The number is odd!--->
    <cfset itemSubtotal = listprice * freeItems + newprice>
</cfif>
		<CFSET subtotal = subtotal + itemSubtotal>





</td>
<td>
#freeItems# For #Dollarformat(listprice)#<br>
<cfif Quantity MOD 2 NEQ 0>
<!---The number is odd!--->
1 For #DollarFormat(newprice)#<br>
</cfif>
<span class="red">#freeItems# For Free</span>
</td>
<td>
<input type="Text" name="ItemQuantity" value="#Quantity#"  size="4" maxlength="4" class="qtyInput">
</td>
<td><a href="javascript:submitform(document.viewcart,'recalcitems.cfm');" class="cartedit">Update Quantity</a><br><a href="delitem.cfm?ProductID=#ProductID#" class="cartedit">Remove</a></td>
<td>#Dollarformat(itemSubtotal)#</td>
</tr>


<cfelse>
		<CFSET subtotal = subtotal + (val(newprice) * Quantity)>
<tr>
<td><a href="#itemURL#"><img src="#imageURL#" alt="#Title#"></a></td>
<td><a href="#itemURL#"><strong>#title#</strong></a><br /><em>#Tablets#</em></td>
<td>#Dollarformat(newprice)#</td>
<td>
<cfif MIN GTE 2>
<select name="ItemQuantity">  
<cfloop from="#MIN#" to="50" index="i">
<cfif #i# EQ #Quantity#>
<option value="#i#" selected>#i#</option>
<cfelse>
<option value="#i#">#i#</option>
</cfif>
</cfloop>
</select>
<br>
<span class="small">Min. Order Qty: #MIN#</span>
<cfelse>
<input type="Text" name="ItemQuantity" value="#Quantity#"  size="4" maxlength="4" class="qtyInput">
</cfif>
</td>
<td><a href="javascript:submitform(document.viewcart,'recalcitems.cfm');" class="cartedit">Update Quantity</a><br><a href="delitem.cfm?ProductID=#ProductID#" class="cartedit">Remove</a></td>
<td>#Dollarformat(Evaluate(val(newprice) * Quantity))#</td>
</tr>
</cfif>


</CFOUTPUT>
</CFLOOP>
</tbody></table>

<div class="posright"><h2>Subtotal: <cfoutput>#DollarFormat(subtotal)#</cfoutput></h2></div>
<br class="clear" />

<br class="clear" />

<!--start button set-->
<div class="cart-btns">
<span><a href="https://www.maxvite.com/checkout0.cfm?CHECKOUT" class="btn bigButton">Checkout</a></span>
<span><a href="<cfoutput>#HTTP_REFERER#</cfoutput>" class="btn bigButton">Continue Shopping</a></span>
</div>

<!--end button set-->
<br class="clear" />

</cfform>
</div>

</cfif>
</div>


<!-- cart detail ends -->


</div><!--end content-->
 
 <cf_footer>
 
</div><!--end wrapper-->
 
<script src="/js/cart.js"></script>
</body>
</html>