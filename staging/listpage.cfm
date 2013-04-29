<cfparam name="searchkeywords" default="calcium">
<cfparam name="brandfilter" type="integer" default="0">
<cfquery name="GetData" datasource="#Application.ds#">
						SELECT Brands.Brand, p.Description, p.BrandID, p.ProductID, COUNT(*) as "product_count"
						FROM Products p, Brands Brands
                        WHERE p.BrandID = Brands.BrandID
                        AND p.Display = 1                        
						<cfif brandfilter NEQ 0>
						AND BrandID IN (#URLDecode(brandfilter)#)
						</cfif>
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
                        Order by Brands.Brand ASC
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
<script src="http://malsup.github.com/jquery.blockUI.js"></script>
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
<style>
/* To Do */
/* Add padding-top to checkboxes in .checkbox-list */

#listProductsWrap .listpage-toolbar {
border: silver solid 1px;
background-color: #f1f1f1;
width: 708px;
height: 19px;
padding: 4px;
overflow: hidden;
margin: 0;
position: relative;
}

#listProductsWrap .items-grid, #listProductsWrap .items-list {
width: 718px;
overflow: hidden;
padding: 0;
}

#listProductsWrap .items-grid li {
background-color: #fff;
text-align: center;
position: relative;
width: 236px;
display: inline-block;
vertical-align: top;
padding: 0;
margin: 10px 0;
list-style-type: none;
}

#listProductsWrap .items-list li {
width: 718px;
border-bottom: 1px solid #d5d5d5;
margin: 0;
padding: 10px 0;
background-color: #fff;
text-align: center;
position: relative;
display: inline-block;
vertical-align: top;
list-style-type: none;
}

#listProductsWrap .items-list dl, #listProductsWrap .items-list dl dd {
float: left;
}

#listProductsWrap .items-list dl dd:first-child {
width: 116px;
vertical-align: top;
}

#listProductsWrap .items-list dl dd:first-child a img {
max-width: 100px;
max-height: 100px;
}

#listProductsWrap .items-list-info {
width: 292px;
padding-right: 40px;
text-align: left;
}

#listProductsWrap .items-list-info-title {
font-size: 14px;
font-weight: bold;
}

#listProductsWrap .items-list-sizeform {
width: 268px;
overflow: hidden;
float: left;
font-size: 12px;
text-align: left;
}

#listProductsWrap .items-list-sizeform dt {
float: left;
width: 78px;
}

#listProductsWrap .items-list-sizeform dd {
float: left;
width: 178px;
}

#listProductsWrap .items-list-pricing {
text-align: left;
}

#listProductsWrap .items-list-pricing h1 {
	margin-top:0;
}

#listProductsWrap .items-grid li dl {
text-align: left;
width: 226px;
}

#listProductsWrap .items-grid li dl .items-grid-thumb {
 width: 226px;
 height: 100px;
 margin-bottom: 5px;
}
#listProductsWrap .items-grid li dl .items-grid-thumb a {
 display: table-cell;
 width: 224px;
 height: 100px;
 text-align: center;
 vertical-align: bottom;
}
#listProductsWrap .items-grid li dl .items-grid-thumb a img {
 vertical-align: bottom;
 max-width: 100px;
 max-height: 100px;
 border: 0;
}
#listProductsWrap .items-grid li dl .items-grid-title {
 font-weight: bold;
 font-size: 12px;
 color: #004922;
}
#listProductsWrap .items-grid li dl .items-grid-form { font-style: italic }
#listProductsWrap .items-grid li dl dd .items-grid-price, #listProductsWrap .items-grid li dl dd .items-grid-bigprice {
 color: #bf000b;
 font-weight: bold;
}
#listProductsWrap .items-grid li dl .items-grid-bigprice { font-size: 14px }
#listProductsWrap .items-grid li dl .addToCartBox {
 float: left;
 margin-top: 3px;
}
#listProductsWrap .items-grid li dl .addToCartBox p {
 height: 22px;
 line-height: 22px;
}
#listProductsWrap .items-grid li dl .addToCartBox p input[type='image'] { vertical-align: middle }
#listProductsWrap .items-grid li dl .addToCartBox p input[type='text'] { margin: 0 3px }














#filterSection {
width: 226px;
float: left;
margin-top: 5px;	
}

#refineResults {
	width:224px;
	overflow:hidden;
	display:block;
}

#refineResults li.refine-results-clearall {
float:right;
margin-top: 10px;
font-size: 11px;
text-decoration: underline;
}

#refineResults li:first-child {
font-size: 21px;
font-family: pt-sans,Arial,sans-serif;
font-weight: 400;
line-height: 33px;
float:left;
}

#filterSection .filter-module {
	width:224px;
	margin-top: 5px;
}
#filterSection .filter-module .filter-module-title {
	width: 216px;
	border: 1px solid #cbcbcb;
	background:#f1f1f1;
	height:19px;
	padding:4px;
}
#filterSection .filter-module .filter-module-title li {
	float:right;
}
#filterSection .filter-module .filter-module-title li:first-child {
		font-weight:bold;
		float:left;
}
#filterSection .filter-module .filter-module-title .filter-module-toggler {
	margin:4px 0 0 10px;
	text-indent:-10000px;
	height: 9px;
	left:0;
	display:block;
	background: url(/img/listpage-sprite.gif) no-repeat 0 -44px;
	width:9px;
	cursor:pointer;
}
#filterSection .filter-module .filter-module-title .filter-module-toggler.filter-module-toggler-plus {
	background: url(/img/listpage-sprite.gif) no-repeat -9px -44px;	
}
#filterSection .filter-module .filter-module-title .filter-module-clear {
font-size: 11px;
text-decoration: underline;
}
#filterSection .filter-module .checkbox-list {
	border: 1px solid #cbcbcb;
	border-top:0;
	padding:4px;
	max-height:180px;
	overflow:auto;
	width:216px;
}

#filterSection .filter-module .checkbox-list li {
	line-height: 20px;
}
#filterSection .filter-module .checkbox-list li:hover {
	background: #ddd;
}
#filterSection .filter-module .checkbox-list .filter-module-checkbox-count {
	color:#555;
	font-size:10px;
}
#filterSection .filter-module .checkbox-list input.checkbox-list-option {
	padding-top:5px;
}
.paginator {
	margin:4px 0 0 35px;
	padding:0;
	list-style-type:none;
	font-size:12px;
	font-weight:bold;
	line-height:11px;
	position:relative;
	float:left;
}
.paginator li {
	float:left;
	margin-right:15px;
}
.paginator li a {
	text-indent:-10000px;
	height: 11px;
	left:0;
	display:block;
	background: transparent url(/img/listpage-sprite.gif) no-repeat 0 0;
	cursor:default;
}
.paginator .begin-arrow a {
	background-position: -12px -11px;
	width:12px;
}
.paginator .prev-arrow a {
	background-position: -12px -11px;
	width:6px;
}
.paginator .begin-arrow.paginator-active a, .paginator .prev-arrow.paginator-active a{
		background-position: 0 -11px;
}
.paginator .last-arrow a {
	background-position: -12px 0;
	width:12px;
}
.paginator .next-arrow a {
	background-position: -12px 0;
	width:6px;
}
.paginator .last-arrow.paginator-active a, .paginator .next-arrow.paginator-active a {
	background-position: 0 0;
	cursor:pointer;
}
.listpage-toolbar select {
	font-size:11px;
}
.listpage-toolbar .listpage-toolbar-display {
float: left;
position: relative;
font-size: 12px;
}

.listpage-toolbar .listpage-toolbar-numberonpage {
float: right;
margin-left: 13px;
}

.listpage-toolbar .listpage-toolbar-numberonpage li {
float: left;
margin-left: 3px;
}

.listpage-toolbar .listpage-toolbar-view, .listpage-toolbar .listpage-toolbar-sortby {
	overflow:hidden;
	float:right;
	font-size:12px;
	margin-left:30px;
}
.listpage-toolbar .listpage-toolbar-view li, .listpage-toolbar .listpage-toolbar-sortby li {
	float:left;
	margin-right:5px;
}
.listpage-toolbar .listpage-toolbar-view li a {
	text-indent:-10000px;
	height: 11px;
	left:0;
	display:block;
	background: url(/img/listpage-sprite.gif) no-repeat 0 -22px;
	width:11px;
	margin-top: 4px;
}
.listpage-toolbar .listpage-toolbar-view .grid-view a {
	background-position: -11px -33px;
}
.listpage-toolbar .listpage-toolbar-view .grid-view a:hover, .listpage-toolbar .listpage-toolbar-view .grid-view.grid-view-selected a {
	background-position: -11px -22px;
}
.listpage-toolbar .listpage-toolbar-view .list-view a {
	background-position: 0 -33px;
}
.listpage-toolbar .listpage-toolbar-view .list-view a:hover, .listpage-toolbar .listpage-toolbar-view .list-view.list-view-selected a {
	background-position: 0 -22px;
}
.listpage-toolbar-numberonpage .per-page-selected {
	font-weight:bold;
}
</style>
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
  <li class="refine-results-clearall hidden"><a href="#">Clear All</a></li>
</ul>

<div class="filter-module">
<ul class="filter-module-title">
  <li>Brand</li>
  <li class="filter-module-toggler">Show/Hide</li>
  <li class="filter-module-clear hidden"><a href="#">Clear</a></li>
</ul>

<ul class="checkbox-list">
<cfloop query="GetData">
<cfoutput>
  <li styleoptionid="#BrandID#" id="facet_option_#BrandID#" class="style-option">
    <input type="checkbox" class="checkbox-list-option" value="#BrandID#">
    <label alt="#Brand#" class="styleName" for="#BrandID#">#Brand# <span class="filter-module-checkbox-count">(#product_count#)</span></label>
  </li>
</cfoutput>
</cfloop>
</ul>

</div>
</secondary>
 
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
			
<div class="listpage-toolbar">
<span class="listpage-toolbar-display">Items <strong>{{product_start}}</strong>&nbsp;-&nbsp;<strong>{{product_end}}</strong> of <strong>{{total_products}}</strong></span>
    
    
 <ul class="paginator">

 <li class="begin-arrow{{^first_page}} paginator-active{{/first_page}}"><a href="0" title="First Page">First Page</a></li>
 <li class="prev-arrow{{^first_page}} paginator-active{{/first_page}}"><a href="{{prev_page}}" title="Previous Page">Previous Page</a></li>

 <li class="current-page">{{current_page}}</li>

<li class="next-arrow{{^is_last_page}} paginator-active{{/is_last_page}}"><a href="{{next_page}}" title="Next Page">Next Page</a></li>
 <li class="last-arrow{{^is_last_page}} paginator-active{{/is_last_page}}"><a href="{{last_page_id}}" title="Last Page">Last Page</a></li>

<!---{{^first_page}}<li class="prev-arrow"></li>{{/first_page}}
{{#page_list}}
<li><a href="{{current_page}}" {{#current_page}}class="selected"{{/current_page}}>{{current_page}}</a></li>
{{/page_list}}
{{^is_last_page}}<li class="next-arrow"></li>{{/is_last_page}}--->
 </ul>



<!---{{#show_per_page}}
<ul class="listpage-toolbar-numberonpage"><li>Items per page:</li>
{{#products_per_page}}
{{#selected}}<li class="per-page-selected">{{products}}</li>{{/selected}}
{{^selected}}<li><a href="{{products}}">{{products}}</a></li>{{/selected}}
{{/products_per_page}}
</ul>
{{/show_per_page}}
--->

{{#show_per_page}}
<ul class="listpage-toolbar-numberonpage"><li>Items per page: </li><li>
<form>
          <select>
{{#products_per_page}}
            <option value="{{products}}" {{#selected}}selected{{/selected}}>{{products}}</option>
{{/products_per_page}}
          </select>
        </form>
</li></ul>
{{/show_per_page}}



 <ul class="listpage-toolbar-view">
 <li>View: </li>
 <li class="grid-view grid-view-selected"><a href="grid" title="Grid View">Grid View</a></li>
 <li class="list-view"><a href="list" title="List View">List View</a></li>
 </ul>

<ul class="listpage-toolbar-sortby"><li>Sort by: </li><li>
<form>
          <select>
            <option value="name-a-z">Name: A to Z</option>
            <option value="price-low-high">Price Low-High</option>
            <option value="price-high-low">Price High-Low</option>
            <option value="reviews">Reviews</option>			
          </select>
        </form>
</li></ul>


  </div>


<!---{{#products}}
<li>{{name}}</li>
{{/products}}--->
<!---product-grid start--->

<ol class="items-list hidden">
{{#products}}  
      <li>
        
        <dl>
          <dd><a href="{{product_url}}"><span></span><img alt="{{name}}" src="{{image_url}}"></a></dd>
          <dd class="items-list-info">
            <p class="items-list-info-title"><a href="{{product_url}}">{{name}}</a></p>
            <p><a href="{{product_url}}">{{strap_line}}</a></p>
            <dl class="items-list-sizeform">
              
                <dt>Serving Size:</dt>
                <dd>{{serving_size}}</dd>
              
                <dt>Size/Form:</dt>
                <dd>{{form}}</dd>
              
            </dl>
          </dd>
          <dd class="items-list-pricing">
            
          
                <h1><span class="green">Our Price:</span> {{our_price}}</h1>
                <span class="listprice">List Price: <span class="strike">{{list_price}}</span></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="red"><strong>You Save:&nbsp;{{dollars_saved}} ({{percent_saved}})%</strong></span>
              
              <form class="additemform">
                                <input type="hidden" value="{{product_id}}" name="ProductID">
                <p class="listViewQtyBox"> <span class="listViewQty">Quantity</span>
                  
                    <input name="qtytoadd" type="text" value="1" maxlength="4" class="qtyInput" size="3">
                    
                  <button class="btn bigButton" name="addtocart" type="submit">Add To Cart</button>
                  <span class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</span> </p>
                
              </form>
              
          </dd>
        </dl>
        <div class="clear"></div>
      </li>
{{/products}}

</ol>

<ol class="items-grid block">


{{#products}}  
      <li>
        <dl style="display: block;">
          <dd class="items-grid-thumb"><a href="{{product_url}}"><span></span><img alt="{{name}}" src="{{image_url}}"></a></dd>
          <dt class="items-grid-title"><a href="{{product_url}}">{{name}}</a></dt>
          <dd class="items-grid-form">{{form}}</dd>
          
              {{#list_price}}
			  	<dd><span class="items-grid-listprice">List Price: <span class="strike">{{list_price}}</span></span></dd>
                <dd><span class="items-grid-bigprice"><span class="green">Our Price:</span> {{our_price}}</span></dd>
                <dd><span class="red regular">You Save:&nbsp;{{dollars_saved}} ({{percent_saved}})%</span></dd>
			  {{/list_price}}
              
			  {{#just_price}}<dd><span class="items-grid-bigprice">Price: {{just_price}}</span></dd>{{/just_price}}
			  

              
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
		default_json: "/staging/listpage-test-query.cfm?searchkeywords=#searchkeywords#"<cfif brandfilter NEQ 0> + "&brandfilter=#URLEncodedFormat(brandfilter)#"</cfif>,
		default_view: "grid"
	}
</cfoutput>
</script>
<script src="js/listpage-test.js"></script>

<cfinclude template="/footer.cfm">
 
</div><!--end wrapper-->


</body>
</html>