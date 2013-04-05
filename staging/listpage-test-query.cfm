<cfset eachProductArray = ArrayNew(1) />
<!---<cfset perPageArray = ArrayNew(1) />--->
<cfparam name="searchkeywords" default="">
<cfparam name="numberonpage" type="integer" default="30">
<cfparam name="startpage" type="numeric" default="0">
<cfparam name="FormulaFilter" type="integer" default="0">
<cfparam name="brandfilter" type="integer" default="0">
<cfquery name="GetData" datasource="#Application.ds#">
						SELECT ProductID, BrandID, Title, instockflag, strapline, ServingSize, listprice, ourprice, featuredproductflag, featuredproductflag2, imagesmall, imagebig, description, Tablets,  (Select Subcategoryid from Product_SUBCategory_Map where Product_SUBCategory_Map.ProductID = ProductID limit 1) as Subcategoryid, MetaTitle, MetaKeywords, MetaDesc
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
						Order by Title
</CFQUERY>
<cfloop query="GetData" startrow="1" endrow="#numberonpage#">
  <cfinclude template="/dealquery.cfm">
  <cfset youSave = val(listprice)-val(newprice)>
  <cfset youSavePcnt = round(Evaluate(    ((val(listprice)-val(newprice))/val(listprice)) *100))>
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
  <cfset eachProductStruct["form"] = "#Tablets#" />
  <cfset eachProductStruct["image_url"] = "#imageURL#" />
  <cfset eachProductStruct["product_url"] = "/#ProductID#/#ReReplace(title,"[^0-9a-zA-Z]+","-","ALL")#/product.html" />
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
  <cfset eachProductStruct["rating"] = "<script>POWERREVIEWS.display.snippet({write : function(content){$('##pr_snippet_category_#ProductID#').append(content);}},{pr_page_id: '#ProductID#', pr_snippet_min_reviews : '1'})</script>" />
  <cfset ArrayAppend(eachProductArray,eachProductStruct) />
</cfloop>

<cfset NumProducts = Ceiling(GetData.Recordcount)>

<cfset NumPages = Ceiling(GetData.Recordcount/numberonpage)>

<cfset currentPage = (startpage+1)>

<cfset lastPageID = (NumPages-1)>

<cfset lastPage = (currentPage EQ NumPages) ? true : false>

<cfset productstart = Ceiling((startpage*numberonpage)+1)>

<cfset productend = Ceiling(productstart + (numberonpage-1))>

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
</cfif>

<cfif NumProducts GT 60>
  <cfset perPageArray[3] = {
"products" = 90,
"selected" = ((numberonpage EQ 90) ? true : false)
} />
</cfif>

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
    "products" : #serializeJSON(eachProductArray)# } </cfoutput>
</cfif>
