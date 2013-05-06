<cfquery name="GetData" datasource="#Application.ds#">
	SELECT * from SubCategory, Category
	Where Category.CategoryID = <cfqueryparam value="#CategoryID#" cfsqltype="cf_sql_integer">
    AND SubCategory.CategoryID = Category.CategoryID
    AND Category.Visible = 1
	ORDER BY SubCategory.SortID, SubCategory.SubCategory
</CFQUERY>
<cfquery name="GetData1" datasource="#Application.ds#">
	SELECT * from Category 
    Where CategoryID = <cfqueryparam value="#CategoryID#" cfsqltype="cf_sql_integer"> 
    AND visible = 1
</CFQUERY>
<cfquery name="GetDataSS" datasource="#Application.ds#" maxrows=5>
SELECT * from SubCategory
	Where CategoryID = <cfqueryparam value="#CategoryID#" cfsqltype="cf_sql_integer">
	ORDER BY SortID, SubCategory
</cfquery>
<cfset FP1 = -9>
<cfset FP2 = -9>
<cfif isnumeric(GetData1.CategoryFeaturedProduct1)>
  <cfset FP1 = GetData1.CategoryFeaturedProduct1>
</cfif>
<cfif isnumeric(GetData1.CategoryFeaturedProduct2)>
  <cfset FP2 = GetData1.CategoryFeaturedProduct2>
</cfif>
<cfquery name="GetData2" datasource="#Application.ds#">
SELECT Products.ProductID, Products.FeaturedProductFlag, Products.featuredproductflag2, Title, strapline, listprice, tablets, ourprice, subcategoryid, imagesmall, description from Products, Product_SUBCategory_Map
Where Products.ProductID = Product_SUBCategory_Map.ProductID
AND Products.ProductID IN (#FP1#,#FP2#)
</cfquery>
<cfquery name="GetDataI" datasource="#Application.ds#">
SELECT Products.ProductID, Products.FeaturedProductFLAG, Products.featuredproductflag2, Title, strapline, listprice, tablets, ourprice, subcategoryid, imagesmall from Products, Product_SUBCategory_Map
	Where Products.ProductID = Product_SUBCategory_Map.ProductID
	AND FeaturedProductFLAG = 1
	Order by Products.SortID
</cfquery>
<cf_doctype>
<cf_html>
<head>
<title><cfoutput>
  <cfif #getdata1.MetaTitle# EQ "">
#getdata1.Category#- Buy Discount#getdata1.Category#, Online Vitamins, Supplements Pills, Capsules, Tablets, Softgels, Natural, Organic, Herbal Products.
    <!--- <cf_title>--->
    <cfelse>
    #getdata1.MetaTitle#
    <!--- <cf_title>--->
  </cfif>
</cfoutput></title>
<meta name="description" content="<cfoutput><cfif #getdata1.MetaDesc# EQ "">#getdata1.Category# - Buy discounted #getdata1.Category# at MaxVite.com. In our #getdata1.Category# section you will find <cfloop query="getdataSS">#subcategory#,</cfloop>.  Buy discount brand name #getdata1.Category# vitamins, supplements, pills, capsules, softgels and tablets. Find natural, herbal, organic and healthy #getdata1.Category# products.<cfelse>#getdata1.MetaDesc#</cfif></cfoutput>">
<meta name="keywords" content="<cfoutput><cfif #getdata1.MetaKeywords# EQ "">#getdata1.Category#,  discounted <cfloop query="getdataSS">#subcategory#,</cfloop>.<cfelse>#getdata1.MetaKeywords#</cfif></cfoutput>">
<cf_metacustom>
</head>
<body>
<div class="wrapper">
  <cf_header>
  <div class="content">
    <div class="primary">
<a href="/shipping.html" id="freeShipBnr"><img src="/img/free-ship-bnr.gif" alt=""></a>
      <p class="breadcrumbs"><a href="http://www.maxvite.com/index.cfm">Vitamins</a><cfoutput><span class="bread-product">#GetData1.Category#</span></cfoutput></p>
      <!--Dmitry-->
      <script type="text/javascript">
//jQuery.noConflict();
jQuery(document).ready(function($){
	$('.mcol').makeacolumnlists({cols: 3, colWidth: 0, equalHeight: 'ul', startN: 1});
});
</script>
      <h1><cfoutput>#GetData1.Header#</cfoutput></h1>
      <div class="topmargin"></div>
      <cfoutput>
        <p>#GetData1.Description#</p>
      </cfoutput>
      <!-- subcats links start -->
      <cfif GetData.recordcount eq 0>
        <br>
        <br>
        <div align="center">There are no subcategories defined for this category!</div>
        <cfelse>
        <div class="split-box">
          <ul class="mcol">
            <cfoutput query="GetData">
              <li><!--- <a href="/#CategoryID#/#SubCategoryID#/S/#replace(replace(replace(replace(replace(replace(replace(SubCategory," ", "_", "all"),",","","all"),"&","","all"),"-","_","all"),"'","","all"),".","_","all"),"/","_","all")#/items.html">#SubCategory#</a> --->
              <a href="/#CategoryID#/#SubCategoryID#/S/#ReReplace(SubCategory,"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a>
            </li>
            </cfoutput>
          </ul>
        </div>
      </cfif>
      <cfoutput>#GetData1.BottomDesc#</cfoutput> </div>
    <!--end primary-->
    <cf_secondary>
  </div>
  <!--end content-->
  <cf_footer>
</div>
<!--end wrapper-->
</body>
</html>