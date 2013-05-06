<cfif NOT isDefined("ProductID") OR ProductID EQ "" OR NOT IsValid("integer",ProductID)>
  <cflocation url = "http://www.maxvite.com" addToken = "no">
</cfif>
<cfif ListLen(ProductID) GT 1>
  <cfset ProductID = listFirst(ProductID) />
</cfif>
<cfquery name="GetData" datasource="#Application.ds#">
	Select * from Products, Brands
	Where Products.BrandID = Brands.BrandID
	AND ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">
    AND Products.Display = 1
</cfquery>
  <cfquery name="GetData1" datasource="#Application.ds#">
	Select DISTINCT Category, Category.categoryID, Category.Visible
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = Category.CategoryID
	AND Product_SUBCategory_Map.ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">
    AND Category.Visible = 1
</cfquery>
<!---check to see if a product is available--->
<cfif GetData.RecordCount AND GetData1.RecordCount>

  <cfquery name="GetData2" datasource="#Application.ds#">
	Select FormulaType, FormulaTypes.FormulaTypeID
	from Product_Formula_Map, FormulaTypes
	Where Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
	AND ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">
    AND FormulaTypes.Sortid = 1
</cfquery>
  <cfquery name="GetData5" datasource="#Application.ds#" maxrows="1">
	Select DISTINCT subCategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = Category.CategoryID
	AND Product_SUBCategory_Map.ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">
</cfquery>
  <cfquery name="GetDataB" datasource="#Application.ds#" maxrows=1>
Select Category.categoryID, Category, SubCategory.subcategoryid, subcategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = Category.CategoryID
	AND Product_SUBCategory_Map.ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">
</cfquery>
  <cfquery name="GetDataI" datasource="#Application.ds#">
SELECT Products.ProductID, Products.FeaturedProductFLAG, Products.featuredproductflag2, Title, strapline, listprice, tablets, ourprice, subcategoryid, imagesmall from Products, Product_SUBCategory_Map
	Where Products.ProductID = Product_SUBCategory_Map.ProductID
	AND FeaturedProductFLAG = 1
	Order by Products.SortID
</cfquery>
<cfquery name="GetDataSubc" datasource="#Application.ds#" maxrows=1>
	Select DISTINCT Category.categoryID, Category, SubCategory.subcategoryid, subcategory
	From Category , SubCategory, Product_SUBCategory_Map
	Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
	AND SubCategory.CategoryID = 54
	AND Product_SUBCategory_Map.ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">
</cfquery>
  <cfset v_FT="">
  <cfoutput>
    <cfloop query="GetData2">
      <cfset v_FT = ListAppend(v_FT, FormulaType)>
    </cfloop>
  </cfoutput>
  <cf_doctype>
  <cf_html>
  <head>
  <cfoutput query="GetData">
    <cfinclude template="dealquery.cfm">
    <!---<cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" FeaturedProductFLAG2="#FeaturedProductFLAG2#"  OurPrice="#OurPrice#">--->
    <!--- <title>#getdata.Title# Save #round(Evaluate(((val(listprice)-val(newprice))/val(listprice)) *100))#% on #getdata.Title# by #getdata.brand# - #getdata5.subcategory# - #getdata1.category#</title>
 --->
    <title>#getdata5.subcategory##getdata1.category##getdata.Title#</title>
    <meta name="description" content="#getdata.Title# #getdata5.subcategory# #getdata1.category#. We carry cheap and discount vitamins, supplements pills, capsules, tablets, softgels, natural, organic and herbal products.">
    <meta name="keywords" content="#getdata.Title#, discount #getdata5.subcategory#, cheap #getdata5.subcategory#">
  </cfoutput>
  <cf_metacustom>
  <script type="text/javascript" src="http://cdn.powerreviews.com/repos/14165/pr/pwr/engine/js/full.js"></script>
  <script type="text/javascript">
var pr_style_sheet="http://cdn.powerreviews.com/aux/14165/636016/css/express.css";
var pr_read_review="javascript:reviewstab()";
</script>
  <style>
#moreSEOList {
	font-size:12px;
}
#moreSEOList dt {
	float:left;
}
.in-stock {
	font-size:14px;
	color:#BF000B;
}
</style>
  </head>
  <body>
  <!---facebook like code. do not delete--->
  <div id="fb-root"></div>
  <script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
  <!------>
  <cf_header>
  <section id="middleArea">
    <section id="primary"> 
<a href="/shipping.html" id="freeShipBnr"><img src="/img/free-ship-bnr.gif" alt=""></a>
	
	<cfoutput>
        <p class="breadcrumbs"><a href="http://www.maxvite.com/index.cfm">Vitamins</a><cfoutput> <a href="http://www.maxvite.com/#getdataB.CategoryID#/#replace(replace(replace(getdataB.Category," ", "_", "all"),",","","all"),"&","","all")#/subcategory.html">#GetDataB.Category#</a><a href="http://www.maxvite.com/#getdatab.CategoryID#/#getdatab.SubCategoryID#/S/#replace(replace(replace(replace(replace(getdatab.SubCategory," ", "_", "all"),",","","all"),"&","","all"),"-","_","all"),"/","_","all")#/items.html">#getdataB.subcategory#</a><span class="bread-product">#getdata.Title#</span></cfoutput></p>
      </cfoutput>
      <!-- item detail starts -->
      <form class="additemform">
        <cfoutput query="GetData">
          <input type="hidden" name="ProductID" value="#ProductID#">
          <br>
          
          <div id="product-main-box">
            <div id="product-info-lt">

<cfinclude template="thumb-style.cfm">
                  <img src="#imageURL#" alt="#Title#">              

              <div id="productToolsWrpr">
                <ul id="productTools">
                  <li class="productToolTweet"> <a href="https://twitter.com/share" class="twitter-share-button" data-lang="en">Tweet</a>
                    <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
                  </li>
                  <li class="productToolPrint"><a href="/product-print.cfm?ProductID=#ProductID#" target="_blank"><img src="/img/print.gif" alt="print"></a></li>
                  <li class="productToolEmail"><a href="/email-friend.cfm?ProductID=#ProductID#"><img src="/img/email.gif" alt="email this product"></a></li>
                </ul>
              </div>

           <cfif IsImageFile("http://www.maxvite.com/images/#URLEncodedFormat(imagebig)#")>
                            <cfset myImage=ImageNew("http://www.maxvite.com/images/#URLEncodedFormat(imagebig)#")>
              <cfset imageWidth=#ImageGetWidth(myImage)#>
              <cfset imageHeight=#ImageGetHeight(myImage)#>
              <cfif imageWidth gt 250>
                <a href="/view-larger.cfm?ProductID=#ProductID#" id="viewLarger"><img src="/img/viewlarger.gif"></a>
              </cfif>
</cfif>
            </div>
            <div id="product-info-rt">
              <h1>#Title#</h1>
              <h2>#strapline#</h2>
              <div class="pr_snippet_product">
                <script type="text/javascript">POWERREVIEWS.display.snippet(document, { pr_page_id : "#ProductID#" });</script>
              </div>
              <div class="fb-like" data-send="false" data-width="450" data-show-faces="true"></div>
              <table id="product-info-box">
                <tr>
                  <td><div id="price-info-box">
<cfset youSave = val(listprice)-val(newprice)>   
<cfset youSavePcnt = round(Evaluate(    ((val(listprice)-val(newprice))/val(listprice)) *100))>  
                      <cfif #GetDataSubc.SubCategoryID# eq 554>
                      <h1>Get 2 For #Dollarformat(ListPrice)#<br>Buy 1 Get 1 Free</h1>
                      Get 1 for #DollarFormat(newprice)#<br>
                      You Save:&nbsp;#DollarFormat(youSave)# (#youSavePcnt#)%
                      <cfelse>
                      <cfif #ListPrice# GT #newprice# AND #newprice# GT 0>
                        <span class="listprice">List Price: <span class="strike">#Dollarformat(ListPrice)#</span></span>
                        <cfelse>
                        <h1><span class="green">Price:</span> #Dollarformat(ListPrice)#</h1>
                      </cfif>
                      <cfif newprice neq 0>
                        <cfif #round(Evaluate(    ((val(listprice)-val(newprice))/val(listprice)) *100))# GT 0>
                          <br>
                          <h1><span class="green">Our Price:</span> #DollarFormat(newprice)#</h1>
                          <strong><span class="red">You Save:&nbsp;#DollarFormat(youSave)# (#youSavePcnt#)%</span></strong>
                        </cfif>
                      </cfif>                      
                      </cfif>

                      <div id="qtyPriceBox">
                        <cfif instockflag neq 0>
                          <div class="line"></div>
                          <cfif MIN GTE 2>
                            <span class="inlineh2">Quantity:</span>
                            <select name="qtytoadd">
                              <cfloop from="#MIN#" to="50" index="i">
                                <option value="#i#">#i#</option>
                              </cfloop>
                            </select>
                            <br>
                            <span class="small">Minimum Order Qty: #MIN#</span>
                            <cfelse>
                            <span class="inlineh2">Quantity:</span>&nbsp;
                            
                            <cfif #GetDataSubc.SubCategoryID# eq 554>
                            <input type="text" name="qtytoadd" size="3" value="2" maxlength="4" onKeyPress="return disableEnterKey(event)" class="qtyInput">
                            <cfelse>
                            <input type="text" name="qtytoadd" size="3" value="1" maxlength="4" onKeyPress="return disableEnterKey(event)" class="qtyInput">
                            </cfif>
                            
                          </cfif>
                          <button class="btn bigButton" name="addtocart" type="submit">Add To Cart</button>
                          <p class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</p>
                          <cfelse>
                          <p><br>
                            <img src="http://www.maxvite.com/images/outofstock.gif" alt="Out of Stock" border="0"></p>
                        </cfif>
                      </div>
                    </div>
                    <!--end price-info-box--></td>
                  <td><table id="specstable">
                      <tr>
                        <td>Product ID:</td>
                        <td>#intproductid#</td>
                      </tr>
                      <cfif #UPC# neq "" and #UPC# neq "0">
                        <tr>
                          <td>UPC:</td>
                          <td>#UPC#</td>
                        </tr>
                      </cfif>
                      <tr>
                        <td>Brand:</td>
                        <td><a href="/thumbpics.cfm?SearchType=BR&BrandID=#BrandID#">#Brand#</a></td>
                      </tr>
                      <cfif v_FT NEQ "Not Applicable">
                        <cfset formula_array = ArrayNew(1)>
                        <cfloop query="getdata2">
                          <cfset ArrayAppend(formula_array,"#FormulaType#")>
                        </cfloop>
                        <cfif ArrayLen(formula_array) gt 1>
                          <tr>
                            <td class="xpandHead formulaHead"><span><img src="http://www.maxvite.com/img/list-plus.gif"></span>&nbsp;Formula Type:</td>
                            <td><ul class="xpandList bulletList" style="display:none;">
                                <cfloop query="getdata2">
                                  <li><a href="http://www.maxvite.com/#FormulaTypeID#/FT/#replace(replace(replace(replace(FormulaType," ","","all"),"'","","all"),"&","","all"),".","","all")#/items.html">#FormulaType#</a></li>
                                </cfloop>
                              </ul></td>
                          </tr>
                          <cfelse>
                          <tr>
                            <td>Formula Type:</td>
                            <td><cfloop query="getdata2">
                                <a href="http://www.maxvite.com/#FormulaTypeID#/FT/#replace(replace(replace(replace(FormulaType," ","","all"),"'","","all"),"&","","all"),".","","all")#/items.html">#FormulaType#</a>
                              </cfloop></td>
                          </tr>
                        </cfif>
                      </cfif>
                      <cfif #ServingSize# neq "">
                        <tr>
                          <td>Serving Size:</td>
                          <td>#ServingSize#</td>
                        </tr>
                      </cfif>
                      <cfif #tablets# neq "">
                        <tr>
                          <td>Size/Form:</td>
                          <td>#tablets#</td>
                        </tr>
                      </cfif>
                      <cfset category_array = ArrayNew(1)>
                      <cfloop query="getdata1">
                        <cfset ArrayAppend(category_array,"#Category#")>
                      </cfloop>
                      <cfif ArrayLen(category_array) gt 1>
                        <tr>
                          <td class="xpandHead categoryHead"><span><img src="http://www.maxvite.com/img/list-plus.gif"></span>&nbsp;Category:</td>
                          <td><ul class="xpandList bulletList" style="display:none;">
                              <cfloop query="getdata1">
                                <li><a href="http://www.maxvite.com/#CategoryID#/#replace(replace(replace(Category," ", "_", "all"),",","","all"),"&","","all")#/subcategory.html">#Category#</a></li>
                              </cfloop>
                            </ul>
                            <cfelse>
                        <tr>
                          <td>Category:</td>
                          <td><cfloop query="getdata1">
                              <a href="http://www.maxvite.com/#CategoryID#/#replace(replace(replace(Category," ", "_", "all"),",","","all"),"&","","all")#/subcategory.html">#Category#</a>
                            </cfloop></td>
                        </tr>
                      </cfif>
                    </table>
                    <!--end specstable--></td>
                </tr>
                <cfif instockflag neq 0>
                  <tr>
                    <td colspan="2" style="border-top:##d5e2c6 solid 1px;"><dl id="moreSEOList">
                        <dt>Availability:&nbsp;</dt>
                        <dd class="in-stock">In Stock</dd>
                        <dt>Order Processing Time:&nbsp;</dt>
                        <dd>Usually within 2 Business Days</dd>
                        <cfif HEAVYITEMFLAG neq 1>
                          <dt>Shipping Rates:&nbsp;</dt>
                          <dd><a href="/shipping.html##fees">$4.95 Flat Rate, Free over $75</a></dd>
                        </cfif>
                        <dt>Return Policy:&nbsp;</dt>
                        <dd><a href="/shipping.html##return">45 Day Hassle Free Return Policy</a></dd>
                      </dl></td>
                  </tr>
                </cfif>
              </table>
              <!--end product-info-box-->
            </div>
            <!--end product-info-rt-->
          </div>
          <!--end product-main-box-->
          <br class="clear" />
          <br>
          <div id="productTabs" class="ui-tabs">
            <ul>
              <li><a href="##descriptionContent">Description</a></li>
              <cfif additionalhtml neq "">
                <li><a href="##ingredientsContent">Ingredients</a></li>
              </cfif>
              <li><a href="##reviewsContent">Reviews</a></li>
            </ul>
            <div id="descriptionContent" class="ui-tabs-hide">
              <p>#description#</p>
              <cfif spectable neq "">
                <p>#spectable#</p>
              </cfif>

            </div>
            <cfif additionalhtml neq "">
              <div id="ingredientsContent" class="ui-tabs-hide">
                <cfif supfacts neq "">
                  #supfacts#
                </cfif>
                <p>#additionalhtml#</p>
              </div>
            </cfif>
            <div id="reviewsContent" class="ui-tabs-hide">
              <div class="pr_review_summary">
                <script type="text/javascript">POWERREVIEWS.display.engine(document, { pr_page_id : "#ProductID#" });</script>
              </div>
            </div>
          </div>
          <div id="productPrintBox">
            <p>#description#</p>
            <cfif spectable neq "">
              <p>#spectable#</p>
            </cfif>
            <cfif additionalhtml neq "">
              <p>#additionalhtml#</p>
            </cfif>
          </div>
          <!-- item detail ends -->
        </cfoutput>
      </form>
                    <br><p class="small">*These statements have not been evaluated by the Food and Drug Administration. This product is not intended to diagnose, treat, cure, or prevent any diseases.</p>
    </section>
    <cf_secondary>
  </section>
  <!--end middleArea-->
  <cf_footer>
  <script src="/js/productpage.js"></script>
  </body>
  </html>
  <cfelse>
  <cflocation url = "http://www.maxvite.com" addToken = "no">
</cfif>
<!---end check to see if product is available--->
