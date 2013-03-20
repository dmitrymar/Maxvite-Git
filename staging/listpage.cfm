<cfparam name="searchkeywords" default="calcium">
<cfparam name="brandfilter" type="integer" default="0">
<cfquery name="GetData" datasource="#Application.ds#">
SELECT Distinct Brands.BrandID, Brands.Brand
From Products, Brands
						Where Products.BrandID = Brands.BrandID
						<cfif brandfilter NEQ 0>
						AND Brands.BrandID = #brandfilter#
						</cfif>
						AND
						(Products.Description like '%#SEARCHKEYWORDS#%'
						 OR
						 Title like '%#SEARCHKEYWORDS#%'
						 OR
						 IntProductID like '%#SEARCHKEYWORDS#%'
						 OR
						 Brand like '%#SEARCHKEYWORDS#%'
						 OR
						 Products.ProductID = #val(searchkeywords)#
						 OR
						Products.UPC like '%#SEARCHKEYWORDS#%'
						 )
						AND Products.Display = 1
                        AND Brands.Display = 1
Order By Brands.brand
</CFQUERY>

<cfinclude template="/doctype.cfm">
<cfinclude template="/html.cfm">
<head>
	<title>Lispage Test</title>

<!---Change to metacustom.cfm when done working on list page--->
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/css/common.css?v=<cfoutput>#Rand('SHA1PRNG')#</cfoutput>" media="screen">
<link rel="stylesheet" href="/css/default.min.css?v=<cfoutput>#Rand('SHA1PRNG')#</cfoutput>" media="screen">
<!--[if lt IE 9]>
<script src="https://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="//use.edgefonts.net/pt-sans.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js"></script>
<script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.8.1/jquery.validate.min.js"></script>
<script src="/js/columnizer.js"></script> 
<script src="/js/jquery.maskedinput.js"></script>
<script src="/js/jquery.hoverIntent.minified.js"></script>
<script src="/js/jquery.watermark.min.js"></script>
<script src="/js/common.min.js"></script>
<script src="/js/maxvite.min.js"></script>
<script type="text/javascript">
var pr_style_sheet="http://cdn.powerreviews.com/aux/14165/636016/css/express.css";
</script>
<script type="text/javascript" src="http://cdn.powerreviews.com/repos/14165/pr/pwr/engine/js/full.js"></script>
<!------>
<link rel="stylesheet" href="css/listpage-test.css" media="screen">
</head>


<body>
<div class="wrapper">
<cfinclude template="/header.cfm">

<div class="content">
 
<div class="primary">


<a href="/shipping.html" id="freeShipBnr"><img src="/img/free-ship-bnr.gif" alt=""></a>

<a name="topOfPage"></a>



<h1>Search Results for: "<cfoutput>#searchkeywords#</cfoutput>"</h1>
<br />






    <p></p>


<div id="listProductsGrid"><img src="/img/spinner.gif" alt="Loading.."></div>
<br><p class="small">*These statements have not been evaluated by the Food and Drug Administration. These products is not intended to diagnose, treat, cure, or prevent any diseases.</p>



</div> <!--end primary-->
<div id="filterWrpr">
<ul class="filter-title">
  <li>Brand</li>
  <li class="clear"></li>
</ul>

<ul class="checkbox-list">
<cfloop query="GetData">
<cfoutput>
  <li styleoptionid="#BrandID#" id="facet_option_#BrandID#" class="style-option">
    <input type="checkbox" class="filter-option" value="#BrandID#">
    <label alt="#Brand#" class="styleName" for="#BrandID#">#Brand#</label>
  </li>
</cfoutput>
</cfloop>
</ul>

</div>

 
</div> 
<!--end content-->

<script src="/js/mustache.js"></script>  

<script src="/js/libs/jquery.mockjax.js"></script>
<script id="filterTpl" type="text/template">
{{#filters}}
<ul class="filter-title">
  <li>{{filter_name}}</li>
  <li class="clear"></li>
</ul>

<ul class="checkbox-list">
{{#filter_list}}
  <li styleoptionid="{{fiter_option_id}}" id="facet_option_{{fiter_option_id}}" class="style-option">
    <input type="checkbox" class="filter-option" value="{{fiter_option_id}}">
    <label alt="{{fiter_option_name}}" class="styleName" for="{{fiter_option_id}}">{{fiter_option_name}}</label>
  </li>
{{/filter_list}}
</ul>

{{/filters}}

</script>
<script id="listTpl" type="text/template">
			
<div class="pagesort-bar"> <span class="displaying">Items <strong>{{product_start}}</strong>&nbsp;-&nbsp;<strong>{{product_end}}</strong> of <strong>{{total_products}}</strong></span>
    
    
 <ul class="paginator">

 <li class="begin-arrow"><a href="listpage.cfm?page=1" {{#first_page}}class="disabled"{{/first_page}} title="First Page">First Page</a></li>
 <li class="prev-arrow"><a href="listpage.cfm?page={{prev_page}}" {{#first_page}}class="disabled"{{/first_page}} title="Previous Page">Previous Page</a></li>

 <li class="current-page">{{page_number}}</li>

<li class="next-arrow"><a href="listpage.cfm?page={{next_page}}" {{#last_page}}class="disabled"{{/last_page}} title="Next Page">Next Page</a></li>
 <li class="last-arrow"><a href="listpage.cfm?page={{total_pages}}" {{#last_page}}class="disabled"{{/last_page}} title="Last Page">Previous Page</a></li>

<!---{{^first_page}}<li class="prev-arrow"></li>{{/first_page}}
{{#page_list}}
<li><a href="{{page_number}}" {{#current_page}}class="selected"{{/current_page}}>{{page_number}}</a></li>
{{/page_list}}
{{^last_page}}<li class="next-arrow"></li>{{/last_page}}--->
 </ul>



 <ul class="pageSortSize">
 <li>Items per page:</li>
{{#products_per_page}}
<li><a href="#" {{#selected}}class="selected"{{/selected}}>{{products}}</a></li>
{{/products_per_page}}
 </ul>

 <ul class="view"><li class="grid-view"><a href="#" title="Grid View">Grid View</a></li><li class="list-view"><a href="#" title="List View">List View</a></li></ul>


  </div>


<!---{{#products}}
<li>{{name}}</li>
{{/products}}--->
<!---product-grid start--->
<ol class="products" style="display: block;">


{{#products}}  
      <li>
        <dl class="grid_view" style="display: block;">
          <dd class="pro-thumb"><a href="{{product_url}}"><span></span><img alt="{{name}}" src="{{image_url}}"></a></dd>
          <dt class="pro-title"><a href="{{product_url}}">{{name}}</a></dt>
          <dd class="form">{{form}}</dd>
          
              {{#list_price}}
			  	<dd><span class="listprice">List Price: <span class="strike">{{list_price}}</span></span></dd>
                <dd><span class="bigprice"><span class="green">Our Price:</span> {{our_price}}</span></dd>
                <dd><span class="red regular">You Save:&nbsp;{{dollars_saved}} ({{percent_saved}})%</span></dd>
			  {{/list_price}}
              
			  {{#just_price}}<dd><span class="bigprice">Price: {{just_price}}</span></dd>{{/just_price}}
			  

              
          <dd class="addToCartBox">
            
              <form class="additemform">
                <input type="hidden" value="{{product_id}}" name="ProductID">
                <p>
                  
                    Qty.
                    
                    <input type="text" size="3" class="qtyInput" maxlength="4" value="1" name="qtytoadd">
                                        
                    
                    <button name="addtocart" class="btn">Add To Cart</button>
                    <span class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</span>
                  
                </p>
              </form>
            <div class="pr_snippet_category" id="pr_snippet_category_{{product_id}}">
              {{{rating}}}
            </div>	
          </dd>
        </dl>
        
        <div class="clear"></div>
      </li>
{{/products}}

</ol>
<!---product-grid end--->

</script>

<!---            <div class="pr_snippet_category">
                        <script type="text/javascript">
                            POWERREVIEWS.display.snippet(document, {
                                pr_page_id: '3833',
                                pr_snippet_min_reviews: 1
                            });
                        </script>
            </div>--->
<script>
<cfoutput>
	var Listpage = {
		default_json: "/staging/listpage-test-query.cfm?searchkeywords=#searchkeywords#<cfif brandfilter NEQ 0>&brandfilter=#brandfilter#</cfif>"
	}
</cfoutput>
</script>
<script src="js/listpage-test.js"></script>
 
<cfinclude template="/footer.cfm">
 
</div><!--end wrapper-->


</body>
</html>