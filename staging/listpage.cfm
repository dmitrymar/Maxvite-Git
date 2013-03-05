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



<p class="breadcrumbs"><a href="/">Vitamins</a><span class="bread-product">Mens' Health</span></p>

<h1>Mens' Health</h1>






    <p></p>


<div id="listProductsGrid"><img src="/img/spinner.gif" alt="Loading.."></div>



</div> <!--end primary-->
<div id="filterWrpr">
<ul class="filter-title">
  <li>Brand</li>
  <li class="clear"></li>
</ul>

<ul class="checkbox-list">
  <li styleoptionid="4" id="facet_option_4" class="style-option">
    <input type="checkbox" class="filter-option" value="4">
    <label alt="Natures Way" class="styleName" for="4">Natures Way</label>
  </li>
  <li styleoptionid="1" id="facet_option_1" class="style-option">
    <input type="checkbox" class="filter-option" value="1">
    <label alt="Maxi Health" class="styleName" for="1">Maxi Health</label>
  </li>
  <li styleoptionid="97" id="facet_option_97" class="style-option">
    <input type="checkbox" class="filter-option" value="97">
    <label alt="American BioSciences" class="styleName" for="97">American BioSciences</label>
  </li>
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
    
    
 <span class="pagination-wrap"><span>Page </span>
 <ol class="pagination">
{{^first_page}}<li class="prev-arrow"></li>{{/first_page}}
{{#page_list}}
<li><a href="{{page_number}}" {{#current_page}}class="selected"{{/current_page}}>{{page_number}}</a></li>
{{/page_list}}
{{^last_page}}<li class="next-arrow"></li>{{/last_page}}
 </ol></span>
    
 <ul class="pageSortSize">
 <li>Items per page:</li>
{{#products_per_page}}
<li><a href="#" {{#selected}}class="selected"{{/selected}}>{{products}}</a></li>
{{/products_per_page}}
 </ul>
      
 <ul class="view"><li class="grid-view active">Grid View</li><li class="list-view">List View</li></ul>
  </div>


<!---{{#products}}
<li>{{name}}</li>
{{/products}}--->
<!---product-grid start--->
<ol class="products" style="display: block;">


{{#products}}  
      <li>
        <dl class="grid_view" style="display: block;">
          <dd class="pro-thumb"><a href="{{product_url}}"><span></span><img alt="{{name}}" src="/images/{{image_url}}"></a></dd>
          <dt class="pro-title"><a href="{{product_url}}">{{name}}</a></dt>
          <dd class="form">{{form}}</dd>
          
              <dd><span class="listprice">List Price: <span class="strike">${{list_price}}</span></span></dd>
              
                <dd><span class="bigprice"><span class="green">Our Price:</span> ${{our_price}}</span></dd>
                <dd><span class="red regular">You Save:&nbsp;${{dollars_saved}} ({{percent_saved}})%</span></dd>
              
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
<script src="js/listpage-test.js"></script>
 
<cfinclude template="/footer.cfm">
 
</div><!--end wrapper-->


</body>
</html>