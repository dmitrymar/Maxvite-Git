<cfparam name="searchkeywords" default="calcium">
<cfparam name="startpage" type="numeric" default="0">
<cfquery name="GetBrandData" datasource="#Application.ds#">
						SELECT b.Brand, p.Description, p.BrandID, p.ProductID, COUNT(*) as "product_count"
						FROM Products p, Brands b
                        WHERE p.BrandID = b.BrandID
                        AND p.Display = 1                        
						AND
						(p.Description like '%#SEARCHKEYWORDS#%'
						 OR
						 p.Title like '%#SEARCHKEYWORDS#%'
						 OR
						 p.ProductID = #val(searchkeywords)#
						 OR
						p.UPC like '%#SEARCHKEYWORDS#%'
						 )
						Group by p.BrandID
                        Order by b.Brand ASC
</cfquery>
<cfquery name="GetConcernsData" datasource="#Application.ds#">
	Select f.FormulaType, f.FormulaTypeID, COUNT(m.ProductID) as "product_count"
	from Product_Formula_Map m, FormulaTypes f
	Where m.FormulaTypeID = f.FormulaTypeID
	AND m.ProductID IN (SELECT ProductID from Products WHERE Description like '%laxative%' or title like '%laxative%' and Display =1)
    Group by f.FormulaType
</cfquery>   
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
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js"></script>
<script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.8.1/jquery.validate.min.js"></script>
<script src="http://malsup.github.com/jquery.blockUI.js"></script>
<script src="/js/columnizer.js"></script> 
<script src="/js/jquery.maskedinput.js"></script>
<script src="/js/jquery.hoverIntent.minified.js"></script>
<script src="/js/jquery.watermark.min.js"></script>
<script src="/js/common.min.js"></script>
<script src="/js/maxvite.min.js"></script>
    <!---
 <script>
//Slider code. Later integrate with listpage-test.js
     $(function() {
$( "#slider-range" ).slider({
range: true,
min: 0,
max: 500,
values: [ 75, 300 ],
slide: function( event, ui ) {
$( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
}
});
$( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
" - $" + $( "#slider-range" ).slider( "values", 1 ) );
});
</script>--->
    
<script type="text/javascript">
var pr_style_sheet="http://cdn.powerreviews.com/aux/14165/636016/css/express.css";
</script>
<script type="text/javascript" src="http://cdn.powerreviews.com/repos/14165/pr/pwr/engine/js/full.js"></script>
<!------>
			<link rel="stylesheet" href="/staging/css/listpage-test.css" type="text/css" id="prBaseStylesheet">
			<link rel="stylesheet" href="http://cdn.powerreviews.com/repos/14165/pr/pwr/engine/pr_styles_review.css" type="text/css" id="prBaseStylesheet">
			<link rel="stylesheet" href="http://cdn.powerreviews.com/aux/14165/636016/css/express.css" type="text/css" id="prMerchantOverrideStylesheet">
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


<div id="listProductsWrap">Loading Products...</div>
<br><p class="small">*These statements have not been evaluated by the Food and Drug Administration. These products is not intended to diagnose, treat, cure, or prevent any diseases.</p>


</div> <!--end primary-->
<section id="filterSection">

<ul id="refineResults">
  <li>Refine Results</li>
  <li class="refine-results-clearall hidden"><a href="clear all">Clear All</a></li>
</ul>

<div class="filter-module filter-module-brand" data-module="brand">
<ul class="filter-module-title">
  <li>Brand</li>
  <li class="filter-module-toggler">Show/Hide</li>
  <li class="filter-module-clear hidden"><a href="clear">Clear</a></li>
</ul>

<ul class="checkbox-list filter-module-main">
<cfloop query="GetBrandData">
<cfoutput>
  <li data-brandid="#BrandID#">
    <input type="checkbox" class="checkbox-list-option" value="#BrandID#">
    <label alt="#Brand#" for="#BrandID#">#Brand# <span class="filter-module-checkbox-count">(#product_count#)</span></label>
  </li>
</cfoutput>
</cfloop>
</ul>

</div>


<div class="filter-module filter-module-concerns" data-module="concerns">
<ul class="filter-module-title">
  <li>Health Concerns</li>
  <li class="filter-module-toggler">Show/Hide</li>
  <li class="filter-module-clear hidden"><a href="clear">Clear</a></li>
</ul>

<ul class="checkbox-list filter-module-main">
<cfloop query="GetConcernsData">
<cfoutput>
  <li>
    <input type="checkbox" class="checkbox-list-option" value="#FormulaTypeID#">
    <label alt="#FormulaType#" for="#FormulaTypeID#">#FormulaType# <span class="filter-module-checkbox-count">(#product_count#)</span></label>
  </li>
</cfoutput>
</cfloop>
</ul>

</div>
    
<div class="filter-module filter-module-specials" data-module="specials">
<ul class="filter-module-title">
  <li>Specials</li>
  <li class="filter-module-toggler">Show/Hide</li>
  <li class="filter-module-clear hidden"><a href="clear">Clear</a></li>
</ul>

<ul class="checkbox-list filter-module-main">

  <li>
    <input type="checkbox" class="checkbox-list-option" value="#FormulaTypeID#">
    <label alt="#FormulaType#" for="#FormulaTypeID#">Brand Specials <span class="filter-module-checkbox-count">(6)</span></label>
  </li>
  <li>
    <input type="checkbox" class="checkbox-list-option" value="#FormulaTypeID#">
    <label alt="#FormulaType#" for="#FormulaTypeID#">Weekly Specials <span class="filter-module-checkbox-count">(0)</span></label>
  </li>
  <li>
    <input type="checkbox" class="checkbox-list-option" value="#FormulaTypeID#">
    <label alt="#FormulaType#" for="#FormulaTypeID#">Super Deals <span class="filter-module-checkbox-count">(0)</span></label>
  </li>
  <li>
    <input type="checkbox" class="checkbox-list-option" value="#FormulaTypeID#">
    <label alt="#FormulaType#" for="#FormulaTypeID#">Buy 1 Get 1 Free <span class="filter-module-checkbox-count">(0)</span></label>
  </li>      
</ul>

</div>


<div class="filter-module filter-module-price" data-module="price">
<ul class="filter-module-title">
  <li>Price Range&nbsp;<img width="14" height="12" title="Enter minimum (left field) and maximum price (right field) or use slider" alt="question" class="sideNote" src="/img/question-icon.gif"></li>
  <li class="filter-module-toggler">Show/Hide</li>
  <li class="filter-module-clear hidden"><a href="clear">Reset</a></li>
</ul>

<div id="filterPriceBox" class="filter-module-main">
    <ul class="filter-price-fields">
        <li><label>$</label><input type="text" size="3" maxlength="4" value="1" name="minprice"></li>
        <li><label>$</label><input type="text" size="3" maxlength="4" value="1" name="maxprice"></li>
    </ul>
    <div id="filterPriceSlider">
        <div id="filterPriceBarBack"></div>                
        <div id="filterPriceBarTop"></div>
        <div id="filterPriceMinHandle" class="filter-price-handle filter-price-handle-min">Minimum Price</div>
        <div id="filterPriceMaxHandle" class="filter-price-handle filter-price-handle-max">Maximum Price</div>
    </div>
</div>

</div>      

</section>
 
</div> 
<!--end content-->

<script src="/js/mustache.js"></script>  

<script id="filterTpl" type="text/template">
{{#filters}}
<ul class="filter-title">
  <li>{{filter_name}}</li>
  <li class="clear"></li>
</ul>

<ul class="checkbox-list">
{{#filter_list}}
  <li>
    <input type="checkbox" class="filter-option" value="{{fiter_option_id}}">
    <label alt="{{fiter_option_name}}" for="{{fiter_option_id}}">{{fiter_option_name}}</label>
  </li>
{{/filter_list}}
</ul>

{{/filters}}

</script>
<script id="listTpl" type="text/template">
<cfinclude template="listpage-toolbar.cfm">			

<!---{{#products}}
<li>{{name}}</li>
{{/products}}--->
<!---product-grid start--->

<ol class="items items-list hidden">
{{#products}}  
      <li>
        
        <dl>
          <dd><a href="{{product_url}}"><span></span><img alt="{{name}}" src="{{image_url}}"></a></dd>
          <dd class="items-list-info">
            <p class="items-list-info-title"><a href="{{product_url}}">{{name}}</a></p>
            <p><a href="{{product_url}}">{{{strap_line}}}</a></p>
            <dl class="items-list-sizeform">
              
                <dt>Serving Size:</dt>
                <dd>{{serving_size}}</dd>
              
                <dt>Size/Form:</dt>
                <dd>{{form}}</dd>
              
            </dl>
          </dd>
          <dd class="items-list-pricing">


		  {{#bogo}}
			  <p class="items-list-ourprice">Get Two For Only {{list_price}}<br>Buy 1 Get 1 Free</p>
			  <p>Get 1 for {{our_price}}&nbsp;&nbsp;&nbsp;<span class="items-list-pricing-usave">You Save: {{dollars_saved}} ({{percent_saved}})%</span></p>
			  {{/bogo}}
{{#list_price}}
			  	{{^bogo}}
				<p class="items-list-ourprice">Our Price: {{our_price}}</p>
				<p><span class="items-list-listprice">List Price: <span class="strike">{{list_price}}</span></span>&nbsp;&nbsp;&nbsp;<span class="items-list-pricing-usave">You Save: {{dollars_saved}} ({{percent_saved}})%</span></p>
				{{/bogo}}
{{/list_price}}              
			  {{#just_price}}<p class="items-list-ourprice">Price: {{just_price}}</p>{{/just_price}}
          
            {{^instock}}<p><a class="btn btn-muted" href="{{product_url}}">Out of Stock</a></p>{{/instock}}
			{{#instock}}
              <form class="additemform">
                                <input type="hidden" value="{{product_id}}" name="ProductID">
								<ul class="items-list-qty-box">
								<li>Quantity</li>
								<li><cfinclude template="product-qty.cfm"></li>
								<li><button class="btn bigButton" name="addtocart" type="submit">Add To Cart</button><span class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</span></li>
								</ul>                
              </form>
              {{/instock}}
			  
			  {{#show_min_qty_list}}<p class="small">Minimum Order Qty: 3</p>{{/show_min_qty_list}}
			
			<div class="pr_snippet_category" id="pr_snippet_category{{product_id}}">
              {{{rating_list}}}
            </div>

          </dd>
        </dl>
        <div class="clear"></div>
      </li>
{{/products}}

</ol>

<ol class="items items-grid block">


{{#products}}  
      <li class="items-grid-node">
        <dl style="display: block;">
          <dd class="items-grid-thumb"><a href="{{product_url}}"><span></span><img alt="{{name}}" src="{{image_url}}"></a></dd>
          <dt class="items-grid-title"><a href="{{product_url}}">{{name}}</a></dt>
          <dd class="items-grid-form">{{form}}</dd>
 			  {{#bogo}}
			  <dd class="items-grid-bogo">Get Two For Only {{list_price}}<br>Buy 1 Get 1 Free</dd>
			  <dd>Get 1 for {{our_price}}</dd>
			  {{/bogo}}
         
              {{#list_price}}
			  	{{^bogo}}
			  	<dd class="items-grid-listprice">
				<ul><li>List Price:&nbsp;</li><li class="strike">{{list_price}}</li></ul>				
				</dd>
                <dd class="items-grid-bigprice"><span class="green">Our Price:</span> {{our_price}}</dd>
				{{/bogo}}
                <dd>You Save:&nbsp;{{dollars_saved}} ({{percent_saved}})%</dd>
			  {{/list_price}}
              
			  {{#just_price}}<dd class="items-grid-bigprice">Price: {{just_price}}</dd>{{/just_price}}
			  

              
          <dd class="addToCartBox">
                        {{^instock}}<a class="btn btn-muted" href="{{product_url}}">Out of Stock</a>{{/instock}}
			{{#instock}}
              <form class="additemform">
                                <input type="hidden" value="{{product_id}}" name="ProductID">
								<ul class="items-list-qty-box">
								<li>Qty.</li>
								<li><cfinclude template="product-qty.cfm"></li>
								<li><button name="addtocart" class="btn">Add To Cart</button><span class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</span></li>
								</ul>                
              </form>
			{{/instock}}
			  {{#show_min_qty_list}}<p class="small">Minimum Order Qty: 3</p>{{/show_min_qty_list}}
			
			<div class="pr_snippet_category" id="pr_snippet_category_{{product_id}}">
              {{{rating_grid}}}
            </div>
			
          </dd>
        </dl>
        
        <div class="clear"></div>
      </li>
{{/products}}

</ol>
<!---product-grid end--->

<cfinclude template="listpage-toolbar.cfm">			

</script>

<script>
<cfoutput>
var Searchkeywords = {
	query: "#searchkeywords#"
}
</cfoutput>
</script>
<script src="js/listpage-test.js?v=<cfoutput>#Rand('SHA1PRNG')#</cfoutput>"></script>

<cfinclude template="/footer.cfm">
 
</div><!--end wrapper-->


</body>
</html>