<cfquery name="GetDataImage" datasource="#Application.ds#">
	SELECT * from homeimages
	ORDER BY SortID
</CFQUERY>
<cfquery name="GetHomeText" datasource="#Application.ds#">
	SELECT HomeText FROM AboutUs 
</cfquery>
<cf_doctype>
<cf_html>
<head>
<title>Skin Vitamins & Supplements, Best Vitamins for Hair, Eyes, Muscles &ndash; Maxvite.com</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="author" content="MaxVite">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="verify-v1" content="2qEa0Zn/k8w/fd2pxQAwdb9yha3hU4n9+BqQBX6s0Es=">
<meta name="google-site-verification" content="sR8zeesYO7SREK3XvoIsriGxwaTDWg2GHtJjkTW1b1o" />
<meta name="y_key" content="2703e6bd2dca9b8c">
<meta name="Description" content="skin vitamins, best vitamins for hair, eye vitamins, bone vitamin, antioxidant supplements, stress vitamins, Cholesterol vitamins, brain vitamins, muscle supplements, vitamins for energy">
<meta name="Keywords" content="Skin Vitamins, Best Vitamins For Hair">
<meta name="msvalidate.01" content="5781438C69C354528E4218C2C8FFD0B5">
<link rel="shortcut icon" type="image/ico" href="favicon.ico" />
<link href="/css/hometabs.css" rel="stylesheet" media="screen" />
<cf_styles>
<script src="/js/home.min.js"></script>
<script src="//ajax.aspnetcdn.com/ajax/jquery.cycle/2.99/jquery.cycle.all.min.js"></script>

</head>
<body>
<cf_header>
<section id="middleArea"> 
<section id="primary">
<a href="/shipping.html" id="freeShipBnr"><img src="/img/free-ship-bnr.gif" alt=""></a>
      <div id="adgroup">
        <div id="slides">
          <cfset iCounter=0>
          <cfoutput query="GetDataImage">
            <cfset iCounter=iCounter+1>
            <div id="#iCounter#"> <a href="#LinkURL#"><img title="#ImageName#" src="/img/featured-ads/#FileName#" width="716" height="318" /> </a> </div>
          </cfoutput> </div>
      </div>
      <div class="clear"></div>
      <div id="promoLevel2"> <img src="/img/featured-brands-bnr.gif" alt="featured brands" usemap="#brandsmap"> <a href="/deal_of_the_day.cfm"><img src="/img/deal-homepage-bnr.gif" alt="deal of the day"></a> </div>
      <div class="clear"></div>
      <map name="brandsmap">
        <area shape="rect" coords="0,17,126,54" href="/1/BR/MaxiHealth/itemsbrands.html" alt="Maxihealth">
        <area shape="rect" coords="134,20,206,43" href="/3/BR/TwinLab/itemsbrands.html" alt="Twinlab">
        <area shape="rect" coords="215,16,265,55" href="/6/BR/Solgar/itemsbrands.html" alt="Solgar">
        <area shape="rect" coords="280,23,349,50" href="/5/BR/NaturesAnswer/itemsbrands.html" alt="Nature's Answer">
        <area shape="rect" coords="0,60,82,82" href="/23/BR/Natrol/itemsbrands.html" alt="Natrol">
        <area shape="rect" coords="90,55,150,90" href="/4/BR/NaturesWay/itemsbrands.html" alt="Vitamins for skin">
        <area shape="rect" coords="154,63,289,82" href="/119/BR/AmericanHealth/itemsbrands.html" alt="American Health">
        <area shape="rect" coords="290,48,349,83" href="/181/BR/Bach/itemsbrands.html" alt="Bach">
        <area shape="rect" coords="0,87,85,118" href="/134/BR/DynamicHealth/itemsbrands.html" alt="Dynamic Health">
        <area shape="rect" coords="102,93,168,118" href="/72/BR/Kyolic/itemsbrands.html" alt="Kyolic">
        <area shape="rect" coords="178,84,271,124" href="/83/BR/BobsRedMill/itemsbrands.html" alt="Bob's Red Mill">
        <area shape="rect" coords="288,86,349,122" href="/91/BR/Schiff/itemsbrands.html" alt="Schiff">
        <area shape="rect" coords="0,126,112,162" href="/114/BR/RainbowLight/itemsbrands.html" alt="Rainbow Light">
        <area shape="rect" coords="112,132,184,162" href="/116/BR/SourceNaturals/itemsbrands.html" alt="Source Naturals">
        <area shape="rect" coords="184,131,284,162" href="/28/BR/Spectrum/itemsbrands.html" alt="Spectrum">
        <area shape="rect" coords="291,126,349,162" href="/8/BR/Alvita/itemsbrands.html" alt="Alvita">
      </map>
      <!-- tabs -->
      <ul class="tabs">
        <li id="brandSpecialsTab"><a href="#brandSpecials">Brand Specials</a></li>
        <li id="weeklySpecialsTab"><a href="#weeklySpecials">Weekly Specials</a></li>
        <li id="superDealsTab"><a href="#superDeals">Super Deals</a></li>
        <li id="buy1get1freeTab"><a href="#buy1get1free">Buy 1 Get 1 Free</a></li>
      </ul>
      <div class="tab_container">
        <div id="brandSpecials" class="tab_content"></div>
        <div id="weeklySpecials" class="tab_content"></div>
        <div id="superDeals" class="tab_content"></div>
        <div id="buy1get1free" class="tab_content"></div>
      </div>
      <!--end tab menu-->


 
   <cfoutput query="GetHomeText">#HomeText#</cfoutput>



</section><cf_secondary></section> <!--end middleArea-->
 
<cf_footer>
</body>
</html>