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


<div id="listProductsGrid"><img src="http://imgb.nxjimg.com/emp_image/offerdetail/restaurant/loading.gif" /></div>



</div> <!--end primary-->
<div id="filterWrpr"><ul class="filter-title"><li>Brand</li><li class="clear"></li></ul><ul class="checkbox-list"><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="American BioSciences" class="styleName" for="92113">American BioSciences</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Buried Treasure" class="styleName" for="92113">Buried Treasure</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Dynamic Health" class="styleName" for="92113">Dynamic Health</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Futurebiotics" class="styleName" for="92113">Futurebiotics</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Greens Today" class="styleName" for="92113">Greens Today</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Health Plus" class="styleName" for="92113">Health Plus</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Hylands" class="styleName" for="92113">Hylands</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="King Bio" class="styleName" for="92113">King Bio</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Kyolic" class="styleName" for="92113">Kyolic</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Maxi Health" class="styleName" for="92113">Maxi Health</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Metagenics" class="styleName" for="92113">Metagenics</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Natrol" class="styleName" for="92113">Natrol</label></li><li styleoptionid="92113" id="facet_option_92113" class="style-option"><input onClick="" type="checkbox" class="facet-option" id="92113" value="92113"><label alt="Nature's Plus" class="styleName" for="92113">Nature's Plus</label></li></ul></div>

 
</div> 
<!--end content-->

<script src="/js/mustache.js"></script>  

<script src="/js/libs/jquery.mockjax.js"></script>

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
            <p>
{{#rated}}product rating{{/rated}}
            </p>	
          </dd>
        </dl>
        
        <div class="clear"></div>
      </li>
{{/products}}

</ol>
<!---product-grid end--->

</script>
<script src="js/listpage-test.js"></script>
 
<cfinclude template="/footer.cfm">
 
</div><!--end wrapper-->


</body>
</html>