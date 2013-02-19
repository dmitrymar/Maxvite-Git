<cfsetting requestTimeOut = "10000">
<cftry>
  
<cfquery name="GetData" datasource="#Application.ds#">
		 SELECT Products.Title AS ttl, Brands.Brand, Products.Description, Products.ProductID, Products.Availability,
		 			Products.imagebig, Products.OurPrice, Products.Listprice,FeaturedProductFLAG, Products.UPC
FROM Brands INNER JOIN Products ON Brands.BrandID = Products.BrandID
WHERE Products.Display=1
</cfquery>
<cfset root ="http://www.maxvite.com">
<CFSET xmldoc = "<?xml version=""1.0"" encoding=""UTF-8"" ?>
<rdf:RDF xmlns:rdf=""http://www.w3.org/1999/02/22-rdf-syntax-ns##""
		  xmlns=""http://purl.org/rss/1.0/""
		  xmlns:g=""http://base.google.com/ns/1.0"">
<channel rdf:about=""#root#"">
<title>Maxvite</title>
<link>#root#</link>
<description>Maxvite Products</description></channel>
"><!---<items> <rdf:Seq> 
<cfloop query = "GetData">
<CFSET xmldoc = xmldoc & "
  <rdf:li rdf:resource=""#root#/#Trim(Replace(ttl, " ", "-","all"))#.html"" /> ">
</cfloop>
<CFSET xmldoc = xmldoc & "</rdf:Seq>
</items>
</channel>
"> --->
<cfloop query = "GetData">
<cfset ADescription = ReReplace(Description, "<[^>]*>", "", "all")>
<cfset ADescription = ReReplace(ADescription, "\&##?\w+;", "", "all")>
<cfset ADescription = ReReplace(ADescription, "[^-a-zA-Z0-9@`!""##$%&'()*+,-./:;\[{<\|=\]}>^~?_\ \x0D\x0a]", "", "all")>
<cfif listPrice NEQ "" AND listPrice NEQ 0>
  <cf_getprice ProductID="#ProductID#" RetailPrice="#Listprice#" FeaturedProductFLAG="#FeaturedProductFLAG#" OurPrice="#OurPrice#">
</cfif>
<CFSET xmldoc = xmldoc & "
<item rdf:about=""#root#/#ProductID#/#ReReplace(Replace(trim(ttl),'''',''),"[^0-9a-zA-Z]+","-","ALL")#/product.html"">
  <g:title>#xmlformat(ttl)#</g:title>
  <g:brand>#xmlformat(Brand)#</g:brand>
  <g:condition>new</g:condition>
  <g:description>#xmlformat(ADescription)#</g:description>
  <g:id>#ProductID#</g:id>
  <g:image_link>#root#/images/#imagebig#</g:image_link>
  <g:link>#root#/#ProductID#/#ReReplace(Replace(trim(ttl),'''',''),"[^0-9a-zA-Z]+","-","ALL")#/product.html</g:link>
  <g:price>#Newprice#</g:price>
  <g:listprice>#listprice#</g:listprice>
  <g:availability>#Availability#</g:availability>
  <g:upc>#xmlformat(UPC)#</g:upc>
  <g:product_type>Health Food</g:product_type>
  </item>
">
</cfloop>
<CFSET xmldoc = xmldoc & "</rdf:RDF>">
<cffile action = "write"
 <!--- get root path example: D:/webroot/sitemap.xml --->
 file = "#ExpandPath('../')#GoogleBase.xml"
    output = "#xmldoc#"
    addNewLine = "yes"
    charset = "utf-8">
<html>
<head>
	<title>Google Base Created</title>
</head>
<body>
Google Base Created
</body>
</html>
<cfcatch>
<cfdump var="#cfcatch#">
</cfcatch>
</cftry>