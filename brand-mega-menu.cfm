<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Distinct Brands.BrandID, Brands.Brand, Mid(Brands.Brand,1,1) as SORT 
						From Products, Product_Formula_Map, FormulaTypes, Brands
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND Products.BrandID = Brands.brandID
						AND Products.Display = 1
                        AND Brands.Display = 1
						Order By Brands.brand
</cfquery>

<ul id="hdrAlphaList">
  <cfoutput query="GetData1" group="SORT">
    <li><a href="brand-list-#SORT#">#SORT#</a></li>
  </cfoutput>
  <li class="all"><a href="/brands.html">view all</a></li>
</ul>
<cfoutput query="GetData1" group="SORT">
  <div class="hdrBrandListWrpr brand-list-#SORT#">
    <ul>
      <cfoutput>
        <li><a href="/#BrandID#/#ReReplace(Replace(trim(Brand),'''',''),"[^0-9a-zA-Z]+","-","ALL")#/Brand.html">#replace(Brand, "&", "&amp;", "all")#</a></li>
      </cfoutput>
    </ul>
  </div>
</cfoutput>