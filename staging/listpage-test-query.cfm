<cfset eachProductArray = ArrayNew(1) />
<cfparam name="searchkeywords" default="">
<cfparam name="numberonpage" type="integer" default="30">
<cfparam name="startpage" type="numeric" default="0">
<cfparam name="productstart" type="integer" default="1">
<cfparam name="productend" type="integer" default="30">
<cfparam name="brandfilter" type="string" default="0">
<cfparam name="sort" type="string" default="nameaz">    
<cfquery name="GetData" datasource="#Application.ds#">
						SELECT ProductID, BrandID, Title, instockflag, strapline, ServingSize, listprice, ourprice, featuredproductflag, featuredproductflag2, imagebig, description, Tablets
						FROM Products
						Where Display = 1
						<cfif brandfilter NEQ 0>
						AND BrandID IN (#URLDecode(brandfilter)#)
                        <!---AND BrandID IN (1,6)--->
						</cfif>
						AND
						(Description like '%#SEARCHKEYWORDS#%'
						 OR
						 Title like '%#SEARCHKEYWORDS#%'
						 OR
						 ProductID = #val(searchkeywords)#
						 OR
						UPC like '%#SEARCHKEYWORDS#%'
						 )
						ORDER BY
    <cfif sort EQ "nameza">
    Title DESC
    <cfelseif sort EQ "pricelowhigh">
  listprice ASC
    <cfelseif sort EQ "pricehighlow">
  listprice DESC  
    <cfelse>
            Title ASC
        </cfif>
</cfquery>

<cfset productstart = Ceiling((startpage*numberonpage)+1)>

<cfset productend = Ceiling(productstart + (numberonpage-1))>

<cfloop query="GetData" startrow="#productstart#" endrow="#productend#">

<!---check if product is buy 1 get 1 free--->
<cfquery name="GetDataSubc" datasource="#Application.ds#" maxrows=1>
	Select DISTINCT Category.categoryID, Category, SubCategory.subcategoryid, subcategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = 54
	AND Product_SUBCategory_Map.ProductID = #ProductID#
</cfquery>


  <cfinclude template="/dealquery.cfm">
  <cfif newprice neq 0>
  <cfset youSave = val(listprice)-val(newprice)>
  <cfset youSavePcnt = round(Evaluate(    ((val(listprice)-val(newprice))/val(listprice)) *100))>
  </cfif>
  <!---this code sets image url--->
  <cfhttp url="http://www.maxvite.com/images/#imagebig#" timeout="45" result="result" throwOnError="no">
  </cfhttp>
  <cfif listFind(result.statuscode, "200"," ") neq 0>
    <cfset imageURL = "/images/#URLEncodedFormat(imagebig)#">
    <cfelse>
    <cfset imageURL = "/images/coming_soon-2.jpg">
  </cfif>
  <!------>
  <cfset eachProductStruct = StructNew() />
  <cfset eachProductStruct["product_id"] = #ProductID# />
  <cfset eachProductStruct["name"] = "#Title#" />
  <cfset eachProductStruct["instock"] = #instockflag# />
  <cfset eachProductStruct["form"] = "#Tablets#" />
  <cfset eachProductStruct["strap_line"] = "#StrapLine#" />
  <cfset eachProductStruct["serving_size"] = "#ServingSize#" />
  <cfset eachProductStruct["image_url"] = "#imageURL#" />
  <cfset eachProductStruct["product_url"] = "/#ProductID#/#ReReplace(title,"[^0-9a-zA-Z]+","-","ALL")#/product.html" />

<!---check if product is buy 1 get 1 free--->
<cfif GetDataSubc.SubCategoryID eq 554>
  <cfset eachProductStruct["bogo"] = 1 />
    <cfset eachProductStruct["list_price"] = #Dollarformat(ListPrice)# />
      <cfset eachProductStruct["our_price"] = #Dollarformat(ourprice)# />
      <cfset eachProductStruct["dollars_saved"] = #Dollarformat(youSave)# />
      <cfset eachProductStruct["percent_saved"] = #youSavePcnt# />

<cfelse>
  
  <cfif #ListPrice# GT #newprice# AND #newprice# GT 0>
    <cfset eachProductStruct["list_price"] = #Dollarformat(ListPrice)# />
    <cfelse>
    <cfset eachProductStruct["just_price"] = #Dollarformat(ListPrice)# />
  </cfif>
  <cfif newprice neq 0>
    <cfif #youSavePcnt# GT 0>
      <cfset eachProductStruct["our_price"] = #Dollarformat(newprice)# />
      <cfset eachProductStruct["dollars_saved"] = #Dollarformat(youSave)# />
      <cfset eachProductStruct["percent_saved"] = #youSavePcnt# />
    </cfif>
  </cfif>
    
</cfif>



<!---  <cfset eachProductStruct["rating"] = "<script>POWERREVIEWS.display.snippet({write : function(content){$('##pr_snippet_category_#ProductID#').append(content);}},{pr_page_id: '#ProductID#', pr_snippet_min_reviews : '1'})</script>" />
--->  
<cfset eachProductStruct["rating_grid"] = "<script>var rating#ProductID# = document.getElementById('pr_snippet_category_#ProductID#');POWERREVIEWS.display.snippet({write : function(content){rating#ProductID#.innerHTML = rating#ProductID#.innerHTML + content;}},{pr_page_id: '#ProductID#', pr_snippet_min_reviews : '1'})</script>" />
<cfset eachProductStruct["rating_list"] = "<script>var rating#ProductID# = document.getElementById('pr_snippet_category#ProductID#');POWERREVIEWS.display.snippet({write : function(content){rating#ProductID#.innerHTML = rating#ProductID#.innerHTML + content;}},{pr_page_id: '#ProductID#', pr_snippet_min_reviews : '1'})</script>" />  

  <cfset ArrayAppend(eachProductArray,eachProductStruct) />
</cfloop>

<cfset NumProducts = Ceiling(GetData.Recordcount)>

<cfset NumPages = Ceiling(GetData.Recordcount/numberonpage)>

<cfset currentPage = (startpage+1)>

<cfset lastPageID = (NumPages-1)>

<cfset lastPage = (currentPage EQ NumPages) ? true : false>



<cfset firstPage = (startpage EQ 0) ? true : false>

<cfset prevPage = (startpage EQ 0) ? 0 : (startpage-1)>


<cfif productend GT NumProducts>
  <cfset productend = Ceiling(NumProducts)>
</cfif>

<cfif NumProducts GT 30>
  <cfset productsperpage = true>
  <cfelse>
  <cfset productsperpage = false>
</cfif>

<cfset perPageArray = [] />

<cfif NumProducts GT 30>

  <cfset perPageArray[1] = {
"products" = 30,
"selected" = ((numberonpage EQ 30) ? true : false)
} />

  <cfset perPageArray[2] = {
"products" = 60,
"selected" = ((numberonpage EQ 60) ? true : false)
} />

  <cfset perPageArray[3] = {
"products" = 90,
"selected" = ((numberonpage EQ 90) ? true : false)
} />
</cfif>




<cfset sortArray = [] />


  <cfset sortArray[1] = {
"sort_value" = "nameaz",
"sort_title" = "Name: A to Z",
"selected" = ((sort EQ "nameaz") ? true : false)
} />

  <cfset sortArray[2] = {
"sort_value" = "nameza",
"sort_title" = "Name: Z to A",
"selected" = ((sort EQ "nameza") ? true : false)
} />

  <cfset sortArray[3] = {
"sort_value" = "pricelowhigh",
"sort_title" = "Price Low-High",
"selected" = ((sort EQ "pricelowhigh") ? true : false)
} />

  <cfset sortArray[4] = {
"sort_value" = "pricehighlow",
"sort_title" = "Price High-Low",
"selected" = ((sort EQ "pricehighlow") ? true : false)
} />

<!---Output json--->

<cfif GetData.Recordcount EQ 0>
  {
  "status": "no_products"
  }
  <cfelse>
  <cfoutput> {
    "status": "success",
    "total_products": #GetData.Recordcount#,
    "first_page": #firstPage#,
    "prev_page": #prevPage#,
    "is_last_page": #lastPage#,
    "next_page": #currentPage#,
    "last_page_id": #lastPageID#,
    "current_page": #currentPage#,
    "product_start": #productstart#,
    "product_end": #productend#,
    "show_per_page": #productsperpage#,
    "products_per_page": #serializeJSON(perPageArray)#,
    "products_sort": #serializeJSON(sortArray)#,    
    "products" : #serializeJSON(eachProductArray)# } </cfoutput>
</cfif>
