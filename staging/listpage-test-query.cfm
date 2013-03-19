<cfset returnArray = ArrayNew(1) />
<cfparam name="searchkeywords" default="">
<cfparam name="numberonpage" default="30">
<cfparam name="FormulaFilter" type="integer" default="0">
<cfparam name="brandfilter" type="integer" default="0">

<cfquery name="GetData" datasource="#Application.ds#">
						SELECT ProductID, BrandID, Title, instockflag, strapline, ServingSize, listprice, ourprice, featuredproductflag, featuredproductflag2, imagesmall, imagebig, description, Tablets,  (Select Subcategoryid from Product_SUBCategory_Map where Product_SUBCategory_Map.ProductID = ProductID limit 1) as Subcategoryid, MetaTitle, MetaKeywords, MetaDesc
						FROM Products
						Where Display = 1
						<cfif brandfilter NEQ 0>
						AND BrandID = #brandfilter#
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
<cfhttp url="http://www.maxvite.com/images/#imagebig#" timeout="45" result="result" throwOnError="no"></cfhttp>
<cfif listFind(result.statuscode, "200"," ") neq 0>
  <cfset imageURL = "/images/#URLEncodedFormat(imagebig)#">
<cfelse>
  <cfset imageURL = "/images/coming_soon-2.jpg">
</cfif>
<!------>

  <cfset keywordsStruct = StructNew() />
  <cfset keywordsStruct["product_id"] = #ProductID# />
  <cfset keywordsStruct["name"] = "#Title#" />
  <cfset keywordsStruct["form"] = "#Tablets#" />
  <cfset keywordsStruct["image_url"] = "#imageURL#" />
  <cfset keywordsStruct["product_url"] = "/#ProductID#/#ReReplace(title,"[^0-9a-zA-Z]+","-","ALL")#/product.html" />  
            <cfif #ListPrice# GT #newprice# AND #newprice# GT 0>
  				<cfset keywordsStruct["list_price"] = #Dollarformat(ListPrice)# />
              <cfelse>
                <cfset keywordsStruct["just_price"] = #Dollarformat(ListPrice)# />
            </cfif>
            <cfif newprice neq 0>
              <cfif #youSavePcnt# GT 0>
				  <cfset keywordsStruct["our_price"] = #Dollarformat(newprice)# />
				  <cfset keywordsStruct["dollars_saved"] = #Dollarformat(youSave)# />
				  <cfset keywordsStruct["percent_saved"] = #youSavePcnt# />
              </cfif>
            </cfif>

  <cfset keywordsStruct["rating"] = "<script>POWERREVIEWS.display.snippet({write : function(content){$('##pr_snippet_category_#ProductID#').append(content);}},{pr_page_id: '#ProductID#', pr_snippet_min_reviews : '1'})</script>" />
  
  <cfset ArrayAppend(returnArray,keywordsStruct) />
</cfloop>


<!---Output json--->
<cfif GetData.Recordcount EQ 0>
{
    "status": "no_products"
}
<cfelse>
<cfoutput>
{
    "status": "success",
    "total_products": #GetData.Recordcount#,
    "product_end": #numberonpage#,
    "products" : #serializeJSON(returnArray)#
}
</cfoutput>
</cfif>