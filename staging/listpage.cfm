<cfparam name="FormulaFilter" default=0>
<cfparam name="BrandFilter" default=0>
<cfparam name = "numberonpage" default="30">
<cfparam name="APPENDURL" default="">


<cfset MT = "">
<cfset MD = "">
<cfset MK = "">
<cfset v_sublist = "">
<cfset v_bread = "">
<cfset baseurl = "http://www.maxvite.com/thumbpics.cfm">

<cfswitch expression="#SearchType#">

	<!--- KeywordSearch --->
	<cfcase value="S">
    


						<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Products.ProductID, Title, instockflag, strapline, listprice, ourprice, featuredproductflag, featuredproductflag2, Products.imagesmall, Products.imagebig, Tablets, ServingSize, SubCategory.Subcategoryid, SubCategory.Categoryid, Category.Categoryid, Category.Visible, SubCategory, Products.MetaTitle, Products.MetaKeywords, Products.MetaDesc
						FROM Products, Product_SUBCategory_Map, SubCategory, Category
						Where Products.ProductID = Product_SUBCategory_Map.ProductID
						AND Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
						and Product_SUBCategory_Map.SubCategoryID = #SubCategoryID#
    AND SubCategory.SubCategoryID = #SubCategoryID#
    AND SubCategory.CategoryID = Category.CategoryID
    AND Category.Visible = 1
	AND Display = 1
	Order by Title
						</CFQUERY>

						<cfquery name="GetData2" datasource="#Application.ds#">
						SELECT * from SubCategory,Category
						Where SubCategory.categoryid = Category.categoryid
						and SubCategory.Subcategoryid = #SubCategoryID#
                        and Category.Visible = 1
						</CFQUERY>

						<cfquery name="GetData3" datasource="#Application.ds#" maxrows="5">
						SELECT * from Products, Product_SUBCategory_Map
						Where Products.ProductID = Product_SUBCategory_Map.ProductID
						and Product_SUBCategory_Map.SubCategoryID = #SubCategoryID#
						</CFQUERY>
						<cfloop query="getdata3">
						<cfset v_sublist = ListAppend(v_sublist,title)>
						</cfloop>
                        
						<cfset APPENDURL = "&amp;CategoryID=#CategoryID#&amp;SubCategoryID=#SubCategoryID#&amp;SearchType=#SearchType#">
                        


	</cfcase>
	<cfcase value="BR">
<!---					<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Products.ProductID, Title, strapline, instockflag, listprice, ourprice, featuredproductflag, featuredproductflag2, Products.imagesmall, Products.imagebig, description, Tablets, ServingSize, brand, (Select top 1 Subcategoryid from Product_SUBCategory_Map where Product_SUBCategory_Map.ProductID = ProductID) as Subcategoryid, Products.MetaTitle, Products.MetaKeywords, Products.MetaDesc
						FROM Products, Brands
						Where Products.BrandID = Brands.BrandID
						AND Products.BrandID = #BrandID#
						AND Display = 1
						<cfif FormulaFilter NEQ 0>
						AND Products.ProductID IN
						(
							SELECT Products.ProductID
							From Products, Product_Formula_Map
							Where Products.ProductID = Product_Formula_Map.ProductID
							AND Product_Formula_Map.FormulaTypeID = #FormulaFilter#
						)
						</cfif>
						Order by Title
					</CFQUERY>--->
					<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Products.ProductID, Title, strapline, instockflag, listprice, ourprice, featuredproductflag, featuredproductflag2, Products.imagesmall, Products.imagebig, description, Tablets, ServingSize, brand, (Select  Subcategoryid from Product_SUBCategory_Map where Product_SUBCategory_Map.ProductID = ProductID LIMIT 1) as Subcategoryid, Products.MetaTitle, Products.MetaKeywords, Products.MetaDesc
						FROM Products, Brands
						Where Products.BrandID = Brands.BrandID
						AND Products.BrandID = #BrandID#
						AND Products.Display = 1
                        AND Brands.Display = 1
						<cfif FormulaFilter NEQ 0>
						AND Products.ProductID IN
						(
							SELECT Products.ProductID
							From Products, Product_Formula_Map
							Where Products.ProductID = Product_Formula_Map.ProductID
							AND Product_Formula_Map.FormulaTypeID = #FormulaFilter#
						)
						</cfif>
						Order by Title
					</CFQUERY>
<cfset LookinProducts = ValueList(GetData1.ProductID, ",")>

<cfquery name="GetCategoryID" datasource="#Application.ds#">
		Select DISTINCT Category, Category.categoryID, Category.Visible
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = Category.CategoryID
    AND Product_SUBCategory_Map.ProductID IN (#LookinProducts#)
    AND Category.Visible = 1
</CFQUERY>
					<cfquery name="GetData2" datasource="#Application.ds#">
						SELECT * from Brands Where brandID = #brandid#
					</CFQUERY>
					<cfquery name="GetData5" datasource="#Application.ds#">
						SELECT Distinct Brands.Brand, FormulaTypes.FormulaTypeID, FormulaTypes.FormulaType
						From Products, Product_Formula_Map, FormulaTypes, Brands
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND Products.BrandID = Brands.brandID
						AND Products.brandID = #brandid#
						AND Products.Display = 1
                        AND FormulaTypes.Sortid = 1
						Order by FormulaTypes.FormulaType
					</CFQUERY>

						<cfquery name="GetData3" datasource="#Application.ds#" maxrows="5">
						SELECT * from Products, Brands
						Where Products.BrandID = Brands.BrandID
						AND Products.BrandID = #BrandID#
						</CFQUERY>
						<cfloop query="getdata3">
						<cfset v_sublist = ListAppend(v_sublist,title)>
						</cfloop>
				<cfset APPENDURL = "&amp;BrandID=#BrandID#&amp;SearchType=#SearchType#">
	</cfcase>
	<cfcase value="FT">
					<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Products.ProductID, Title, strapline, instockflag, listprice, ourprice, featuredproductflag, featuredproductflag2, Products.imagesmall, Products.imagebig, description, Tablets, ServingSize, FormulaType, FormulaTypes.Metatitle, FormulaTypes.METADESC, FormulaTypes.BOTTOMDESC, FormulaTypes.METAKEYWORDS, (Select SubCategoryID From Product_SUBCategory_Map Where Product_SUBCategory_Map.ProductID = ProductID limit 1) AS Subcategoryid, Products.MetaTitle, Products.MetaKeywords, Products.MetaDesc
						FROM Products, Product_Formula_Map, FormulaTypes
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND FormulaTypes.FormulaTypeID = #FormulaTypeID#
						AND Display = 1
						<cfif BrandFilter NEQ 0>
						AND Products.ProductID IN
						(
							SELECT Products.ProductID
							From Products, Brands, Product_Formula_Map
							Where Products.BrandID = Brands.BrandID
							AND Products.ProductID = Product_Formula_Map.ProductID
							AND Product_Formula_Map.FormulaTypeID = #FormulaTypeID#
							AND Brands.BrandID = #BrandFilter#
						)
						</cfif>
						Order by Title
					</CFQUERY>

					<cfquery name="GetData5" datasource="#Application.ds#">
						SELECT Distinct Brands.BrandID, Brands.Brand
						From Products, Product_Formula_Map, FormulaTypes, Brands
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND Products.BrandID = Brands.brandID
						AND FormulaTypes.FormulaTypeID = #FormulaTypeID#
						AND Products.Display = 1
						Order By Brands.brand
					</CFQUERY>
                    
						<cfquery name="GetData3" datasource="#Application.ds#" maxrows="5">
						SELECT * from Products, Product_Formula_Map, FormulaTypes
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND FormulaTypes.FormulaTypeID = #FormulaTypeID#
						</CFQUERY>
						<cfloop query="getdata3">
						<cfset v_sublist = ListAppend(v_sublist,title)>
						</cfloop>

				<cfset APPENDURL = "&amp;FormulaTypeID=#FormulaTypeID#&amp;SearchType=#SearchType#">
	</cfcase>
</cfswitch>
<cfset APPENDURL = APPENDURL & "&amp;FormulaFilter=#FormulaFilter#&amp;BrandFilter=#BrandFilter#">


<!--- Page Count Variables --->
<cfparam name="StartPage" type="numeric" default="0">
<cfset NumProducts = Ceiling(GetData1.Recordcount)>
<cfset NumPages = Ceiling(GetData1.Recordcount/numberonpage)>
<cfset WS = Ceiling((StartPage*numberonpage)+1)>
<cfset WE = Ceiling(WS+(numberonpage-1))>
<cfif WE GT NumProducts>
	<cfset WE = Ceiling(NumProducts)>
</cfif>

<cfset First_Rec_num = (StartPage * numberonpage)+1>
<cfset Last_Rec_num = First_Rec_num+(numberonpage-1)>
<cfif Last_Rec_num GT GetData1.Recordcount>
	<cfset Last_Rec_num = GetData1.Recordcount>
</cfif>


<cfswitch expression="#SearchType#">
	<cfcase value="S">
		<cfset displaytitle = "#GetData1.SubCategory#">
		<cfset displaydesc = "">
			<cfif getdata2.MetaTitle EQ "">
				<cfset MT ="#getdata2.subcategory# - #getdata2.category# - Buy Discount #getdata2.subcategory#, #getdata2.category# - Buy Discount #getdata2.subcategory#, Online Vitamins, Supplements Pills, Capsules, Tablets, Softgels, Natural, Organic, Herbal Products.">
			<cfelse>
				<cfset MT ="#getdata2.MetaTitle#">
			</cfif>

			<cfif getdata2.MetaKeywords EQ "">
				<cfset MK ="#getdata2.subcategory#, #getdata2.category#, discounted #v_sublist#">
			<cfelse>
				<cfset MK ="#getdata2.MetaKeywords#">
			</cfif>

			<cfif getdata2.MetaDesc EQ "">
				<cfset MD ="#getdata2.subcategory# - Buy discounted #getdata2.subcategory# and other #getdata2.category# at MaxVite.com. In our #getdata2.category# section you will find #v_sublist#. Buy discount brand name #getdata2.subcategory# vitamins, supplements, pills, capsules, softgels and tablets. Find natural, herbal, organic and healthy #getdata2.subcategory# products.">
			<cfelse>
				<cfset MD ="#getdata2.MetaDesc#">
			</cfif>
	</cfcase>
	<cfcase value="BR">
		<cfset displaytitle = "#GetData1.Brand#">
		<cfset displaydesc = "">
			<cfset MT =	"#GetData1.Brand# - Buy Discount #GetData1.Brand# Products, #GetData1.Brand# Vitamins, Supplements, Pills, Capsules, Tablets, Softgels, Natural, Organic, Herbal Products.">
			<cfset MD ="#GetData1.Brand# - Buy discounted #GetData1.Brand#. In our #GetData1.Brand# section you will find #v_sublist#. #GetData1.Brand# vitamins, supplements, pills, capsules, softgels and tablets. Find natural, herbal, organic and healthy #GetData1.Brand# products.">
			<cfset MK ="#v_sublist#">
	</cfcase>
	<cfcase value="FT">
		<cfset displaytitle = "#GetData1.FormulaType#">
		<cfset displaydesc = "">
			<cfset MT =	"#GetData1.METATITLE#">
			<cfset MD ="#GetData1.METADESC#">
			<cfset MK ="#GetData1.METAKEYWORDS#">
	</cfcase>
</cfswitch>


<!---<cfquery name="GetDataM" datasource="#Application.ds#">
Select * from Products, Brands
Where Products.BrandID = Brands.BrandID
AND ProductID = #ProductID#
</cfquery>--->

<cfinclude template="/doctype.cfm">
<cfinclude template="/html.cfm">
<head>
<title><cfoutput>#MT#</cfoutput></title>
	<cfoutput>
	<meta name="description" content="#MD#">
	<meta name="keywords" content="#MK#">
	<!--- beware! Hardcode here! please remove it in future ---->
	<cfif SearchType EQ "FT" AND FormulaTypeID EQ 13>
	<meta name='robots' content='noindex, nofollow' />
	</cfif>
	<!--- end of ugly coding --->
	</cfoutput>
<cfinclude template="/metacustom.cfm">

<script type="text/javascript">
var pr_style_sheet="http://cdn.powerreviews.com/aux/14165/636016/css/express.css";
</script>
<script type="text/javascript" src="http://cdn.powerreviews.com/repos/14165/pr/pwr/engine/js/full.js"></script>
<script src="/js/jquery.cookie.js"></script>
<style>
#filterWrpr {
	border: 1px solid #cbcbcb;
	width:224px;
	margin-top: 5px;
}
#filterWrpr .filter-title {
	width: 216px;
	border-bottom: 1px solid #cbcbcb;
	background:#f1f1f1;
	height:19px;
	font-weight:bold;
	padding:4px;
}

#filterWrpr .filter-title li:first-child {display:block; height:14px; padding-left:10px; background:url("/img/next-arrow.gif") no-repeat scroll 0 3px transparent;}

#filterWrpr .checkbox-list {
	padding:4px;
	max-height:180px;
	overflow:scroll;
}
checkbox-list
</style>
</head>

<body>
<div class="wrapper">
<cfinclude template="/header.cfm">


<div class="content">
 
<div class="primary">
<a href="/shipping.html" id="freeShipBnr"><img src="/img/free-ship-bnr.gif" alt=""></a>

<a name="topOfPage"></a>

<!--- Breadcrumb --->
<cfif searchtype eq "S">

<cfif GetData2.Recordcount EQ 0>
<div align="center"><h1>Subcategory Not Available</h1></div>
<cfelse>
<p class="breadcrumbs"><a href="/">Vitamins</a><cfoutput><a href="http://www.maxvite.com/#getdata2.CategoryID#/#replace(replace(replace(getdata2.Category," ", "_", "all"),",","","all"),"&","","all")#/subcategory.html">#GetData2.Category#</a><span class="bread-product">#getdata2.subcategory#</span></cfoutput></p>
  <cfif getdata2.SubCategoryID eq 1149>
      <cflocation url="http://www.maxvite.com/deal_of_the_day.cfm" addToken="false">
  </cfif>
  <cfif getdata2.SubCategoryID eq 555>
      <cflocation url="http://www.maxvite.com/brandspecials.cfm" addToken="false">
  </cfif>
</cfif>  
  
</cfif>
<cfif searchtype eq "FT">
<p class="breadcrumbs"><a href="/">Vitamins</a><cfoutput><span class="bread-product">#displaytitle#</span></cfoutput></p>
</cfif>
<cfif searchtype eq "BR">
<p class="breadcrumbs"><a href="/">Vitamins</a><cfoutput><span class="bread-product">#displaytitle#</span></cfoutput></p>
</cfif>
<h1><cfoutput>#displaytitle#</cfoutput></h1>


<cfif GetData1.Recordcount EQ 0>
<div><h2>There are no products for your selection!</h2></div><div><cfoutput><p>#displaydesc#</p></cfoutput></div>
<cfelseif searchtype eq "BR" and GetCategoryID.RecordCount EQ 0>
<div><h2>There are no products for your selection!</h2></div><div><cfoutput><p>#displaydesc#</p></cfoutput></div>
<cfelse>

<cfswitch expression="#SearchType#">
	<cfcase value="S">
    <cfif getdata2.subdesc neq "">
	<cfoutput><p>#getdata2.subdesc#*</p></cfoutput>
    </cfif>
    </cfcase>
    
	<cfcase value="BR">
    <cfif getdata2.BottomDesc neq "">
	<cfoutput><p>#getdata2.BottomDesc#*</p></cfoutput>
    </cfif>
    </cfcase>
</cfswitch>


	<cfif SearchType EQ "BR">
	<cfoutput>
	<div class="sortlist">
	<form name="filter" action=""><label for="FormulaFilter">Sort by Health Concern:</label>
	<select name="FormulaFilter" onChange="window.location.assign(this.value); ">
				<option value="http://www.maxvite.com/thumbpics.cfm?BrandID=#BrandID#&SearchType=BR&numberonpage=#numberonpage#">All</option>
	<cfloop query="GetData5">
			<cfif getdata5.formulatypeid eq formulafilter>
				<option value="http://www.maxvite.com/thumbpics.cfm?BrandID=#BrandID#&SearchType=BR&FormulaFilter=#FormulaTypeID#&numberonpage=#numberonpage#" selected>#FormulaType#</option>
			<cfelse>
				<option value="http://www.maxvite.com/thumbpics.cfm?BrandID=#BrandID#&SearchType=BR&FormulaFilter=#FormulaTypeID#&numberonpage=#numberonpage#">#FormulaType#</option>
			</cfif>
	</cfloop>
	</select>
	</form>
    </div>
	</cfoutput>
	</cfif>



    <p><cfoutput>#GetData1.BOTTOMDESC#</cfoutput></p>


<div id="listProductsGrid"><img src="http://imgb.nxjimg.com/emp_image/offerdetail/restaurant/loading.gif" /></div>   







</cfif>
<br><p class="small">*These statements have not been evaluated by the Food and Drug Administration. These products is not intended to diagnose, treat, cure, or prevent any diseases.</p>
</div> <!--end primary-->



	<cfif SearchType EQ "FT">
	<cfoutput>

<div id="filterWrpr">
<ul class="filter-title"><li>Brand</li><li class="clear"></li></ul>
<ul class="checkbox-list">
<cfloop query="GetData5">
<li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113">
<label alt="#Brand#" class="styleName" for="92113">#Brand#</label></li>
</cfloop>
</ul>
</div>

<!---	<div class="sortlist">
	<form name="filter" action="">
	<select name="BrandFilter" onChange="window.location.assign(this.value); ">
				<option value="http://www.maxvite.com/thumbpics.cfm?FormulaTypeID=#FormulaTypeID#&SearchType=FT&FormulaFilter=#FormulaFilter#&numberonpage=#numberonpage#">All</option>
	<cfloop query="GetData5">
			<cfif getdata5.brandid eq brandfilter>
				<option value="http://www.maxvite.com/thumbpics.cfm?FormulaTypeID=#FormulaTypeID#&SearchType=FT&FormulaFilter=#FormulaFilter#&BrandFilter=#BrandID#&numberonpage=#numberonpage#" selected>#brand#</option>
			<cfelse>
				<option value="http://www.maxvite.com/thumbpics.cfm?FormulaTypeID=#FormulaTypeID#&SearchType=FT&FormulaFilter=#FormulaFilter#&BrandFilter=#BrandID#&numberonpage=#numberonpage#">#Brand#</option>
			</cfif>
	</cfloop>
	</select>
	</form>
    </div>--->
	</cfoutput>
	</cfif>
 
</div> 
<!--end content-->
 
<cfinclude template="/footer.cfm">
 
</div><!--end wrapper-->
<script src="/js/mustache.js"></script>  

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-mockjax/1.5.1/jquery.mockjax.js"></script>

<script id="listTpl" type="text/template">
<div class="pagesort-bar"> <span class="displaying">Items <strong>{{current_page}}</strong>&nbsp;-&nbsp;<strong>30</strong> of <strong>{{total}}</strong></span>
    
    
      <span class="pagination-wrap"><span>Page&nbsp;</span>
      <ol class="pagination">
        
              <li class="selected">1</li>
              
              <li><a href="#">2</a></li>
            
              <li><a href="#">3</a></li>
            
            <li><a href="#" rel="next"><img src="/img/next-arrow.gif" width="6" height="11" alt="next page"></a></li>
          
      </ol>
      </span>
    
        <ul class="pageSortSize">
          <li>Items per page:</li>
          <li>
            
              <strong>30</strong>
              
          </li>
          <li>
            
              <a href="#">60</a>
            
          </li>
          
            <li>
              
                <a href="#0">90</a>
              
            </li>
          
        </ul>
      
    <ul class="viewBoxGrid" style="display: none;">
      <li class="gridIcon">Grid View</li>
      <li class="listIconOff">List View</li>
    </ul>
    <ul class="viewBoxList" style="display: block;">
      <li class="gridIconOff">Grid View</li>
      <li class="listIcon">List View</li>
    </ul>
  </div>

/*{{#products}}
<li>{{name}}</li>
{{/products}}*/
</script>
<script src="js/listpage-test.js"></script>
<script>
$.mockjax({
  url: 'listpage-query.cfm',
  responseTime: 750,
  responseText: {
    status: 'success',
    total: 87,
	current_page: 1,
	products: [
	{
		name: 'product a'
	},
	{
		name: 'product b'
	}	
	]
  }
});

$.getJSON('listpage-query.cfm', function(response) {
    if (response.status == 'success') {

    var template = $('#listTpl').html();
    var html = Mustache.to_html(template, response);
    $('#listProductsGrid').html(html);

} else {
        $('#listProductsGrid').html('No products found');
    }
});


</script>

</body>
</html>