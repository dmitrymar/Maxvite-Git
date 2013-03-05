<cfif Listlen(session.storeitems) EQ 0>
  Cart Empty!
  <cfelse>
  
  <CFSET subtotal = 0>
  <cfset i = 1>
  <p id="mostRecent">Most Recently Added:</p>

  <!--- Loop over the list of items in the shopping cart --->
  <cfloop index="CurrentItemID" list="#session.StoreItems#">
    <!--- Find the quantity of each item --->
    <CFSET ItemPosition = ListFind(session.StoreItems, CurrentItemID)>
    <CFSET Quantity = ListGetAt(session.StoreItemsQty, ItemPosition)>
    <!--- This query is just to get the name and price of the current item so that we can display that data in the table --->
    <cfquery name="GetData" datasource="#Application.ds#">
        	Select * from Products, Brands
	Where Products.BrandID = Brands.BrandID
	AND ProductID = #CurrentItemID#
    AND Products.Display = 1
                          </CFQUERY>
    <cfquery name="GetData1" datasource="#Application.ds#" maxrows="1">
			SELECT *
			FROM Product_SUBCategory_Map
			Where ProductID = #CurrentItemID#
		</CFQUERY>
    <!--- Now display the data for the current item --->
    <CFOUTPUT QUERY="GetData">
      <cfset v_subid = GetData1.subcategoryid>
      <cfset itemURL = "/" & #v_subid# & "/" & #productid# & "/" & #replace(replace(replace(replace(replace(replace(replace(replace(replace(Title," ","_","all"),"'","","all"),"&","","all"),".","","all"),"+","_","all"),":","","all"),"%","","all"),"##","","all"),"-","","all")# & "/product.html">
      <cfquery name="GetDataSubc" datasource="#Application.ds#" maxrows=1>
	Select DISTINCT Category.categoryID, Category, SubCategory.subcategoryid, subcategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = 54
	AND Product_SUBCategory_Map.ProductID = #GetData.ProductID#
</cfquery>
      <!--- Add cost of current item(s) to total cost --->
      <cfinclude template="seedealprice.cfm">
      <cfif newprice eq 0>
        <cfset newprice = listprice>
      </cfif>
      <cfif i eq 2>
        <div id="previouslyAdded">Previously Added Items</div>
      </cfif>
        
        <cfinclude template="tinypic-url.cfm">
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
          <CFSET subtotal = subtotal + itemSubtotal>
          <cfelse>
          <cfset itemSubtotal = newprice * quantity>
          <CFSET subtotal = subtotal + (val(newprice) * Quantity)>
        </cfif>
        
        <cfif i lte 5>
        <cfset itemsdisplayed = #i#>
        <ul class="cartPreviewItems">
          <li class="cartPreviewItems-image"><a href="#itemURL#"><img src="#imageURL#"></a> </li>
          <li class="cartPreviewItems-title"><a href="#itemURL#">#title#</a> <br>
            Qty: #Quantity# </li>
          <li class="cartPreviewItems-price"><span>#Dollarformat(itemSubtotal)#</span></li>
        </ul>
        </cfif>

    </CFOUTPUT>
    <cfset i = i+1>
  </CFLOOP>
  <cfoutput>
    <div class="cartPreviewOutSubtotal"><span class="cartPreviewOut">#itemsdisplayed# out of #ListLen(session.StoreItems)# items</span> <span class="cartPreviewSubtotal">Subtotal: <span class="red">#DollarFormat(subtotal)#</span></span> </div>
    <!---checkout uses session.subtotalamount value--->
    <CFSET session.subtotalamount = #subtotal#>
  </cfoutput>
  <div id="cartPreviewCartCheckout"> <span id="cartPreviewCartIcon"><a href="http://www.maxvite.com/viewcart.html"><img height="15" width="19" src="/img/cart-icon.png"></a></span> <span id="cartPreviewCart"><a href="http://www.maxvite.com/viewcart.html">SHOPPING CART</a></span> <span id="cartPreviewCheckout"><a href="https://www.maxvite.com/checkout0.cfm?CHECKOUT" class="btn bigButton">Checkout</a></span> </div>
  <div class="clear"></div>

</cfif>