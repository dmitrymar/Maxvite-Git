<cfset returnArray = ArrayNew(1) />
<cfquery name="GetHealthType" datasource="#Application.ds#" dbtype="ODBC" username="#Application.UserName#" password="#Application.Password#">
	SELECT * from FormulaTypes Where FormulaTypeID <> 26 AND SortID = 1
	ORDER BY FormulaType
</cfquery>
<cfloop query="GetHealthType">
  <cfset keywordsStruct = StructNew() />
  <cfset keywordsStruct["concernname"] = FormulaType />
  <cfset keywordsStruct["concernurl"] = "/#FormulaTypeID#/FT/#replace(replace(replace(URL," ", "_", "all"),",","","all"),"&","","all")#/items.html" />
  <cfset ArrayAppend(returnArray,keywordsStruct) />
</cfloop>
{ "concern": 
<cfoutput> #serializeJSON(returnArray)# </cfoutput>
}