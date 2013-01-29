<cfquery name="GetDataSdbr" datasource="#Application.ds#">
	SELECT * from Category
	where visible = 1
    AND MENU = 1
	ORDER BY SortID
</CFQUERY>
<cfquery name="GetDataCat64" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 64
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat47" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 47
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat63" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 63
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat65" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 65
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat62" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 62
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat66" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 66
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat68" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 68
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat69" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 69
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat70" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 70
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat71" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 71
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat53" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 53
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat49" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 49
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat52" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 52
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat42" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 42
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat48" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 48
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat51" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 51
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat56" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 56
	ORDER BY SortID, SubCategory
</CFQUERY>
<cfquery name="GetDataCat47" datasource="#Application.ds#">
	SELECT * from SubCategory
	Where CategoryID = 47
	ORDER BY SortID, SubCategory
</CFQUERY>
<script src="/js/jquery.ba-dotimeout.min.js"></script>
<script>
$(function(){

var Leftnav = {
	
	init: function(test) {
<cfoutput query="GetDataSdbr">
	// create variables
	var cat#CategoryID#Box=document.getElementById("cat#CategoryID#Box");
	var cat#CategoryID#Row=document.getElementById("cat#CategoryID#Row");

$('##cat#CategoryID#Row').hover(function(){
  $(this).doTimeout( 'hover', 1000, function(){
	cat#CategoryID#Box.style.display="block";
	cat#CategoryID#Row.style.zIndex=3;
	cat#CategoryID#Row.firstChild.className += ' sdbrLinkHover';	
});
}, function(){
  $(this).doTimeout( 'hover', 250, function(){
    cat#CategoryID#Box.style.display="none";
	cat#CategoryID#Row.style.zIndex=1;
	cat#CategoryID#Row.firstChild.className = '';	
});
});

</cfoutput>
		}
}


Leftnav.init();	
});
</script>
<cfset listcat = "/" & #GetDataSdbr.CategoryID# & "/" & #replace(replace(replace(GetDataSdbr.Category," ", "_", "all"),",","","all"),"&","","all")# & "/subcategory.html">
<cfset viewallbtn = '<li class="sdbrBulletViewAll"><a href="' & #listcat# & '"><img src="/img/view-all-btn.gif" alt="view all"></a></li>'>
<!--start secondary-->
<section id="secondary">
<div id="sdbrWrpr">
<div id="sdbr">

<div id="sdbrRowWrpr">
<cfoutput query="GetDataSdbr">
<div class="sdbrRow" id="cat#CategoryID#Row"><a href="http://www.maxvite.com/#CategoryID#/#ReReplace(trim(Category),"[^0-9a-zA-Z]+","-","ALL")#/subcategory.html">#Category#</a>
<cfif CategoryID eq 64>

<cfset cat64TotalRecs = GetDataCat64.Recordcount>
<cfif cat64TotalRecs gt 25 and cat64TotalRecs lt 51>
<div id="cat64Box" class="sdbrFlyOut" style="width:500px;top:-1px;">
</cfif>
<cfif cat64TotalRecs gt 50>
<div id="cat64Box" class="sdbrFlyOut" style="width:746px;top:-1px;">
</cfif>
<cfif cat64TotalRecs lt 26>
<div id="cat64Box" class="sdbrFlyOut" style="top:-1px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat64" startrow="1" endrow="25">
<li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li>
</cfloop>
</ul>

<cfif cat64TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat64" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>

<cfif cat64TotalRecs gt 50 and cat64TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat64" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>

<cfif cat64TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat64" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>

</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->


</cfif>


<cfif CategoryID eq 47>

<cfset cat47TotalRecs = GetDataCat47.Recordcount>
<cfif cat47TotalRecs gt 25 and cat47TotalRecs lt 51>
<div id="cat47Box" class="sdbrFlyOut" style="width:500px;top:-32px;">
</cfif>
<cfif cat47TotalRecs gt 50>
<div id="cat47Box" class="sdbrFlyOut" style="width:746px;top:-32px;">
</cfif>
<cfif cat47TotalRecs lt 26>
<div id="cat47Box" class="sdbrFlyOut" style="top:-32px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat47" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat47TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat47" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat47TotalRecs gt 50 and cat47TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat47" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat47TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat47" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 63>

<cfset cat63TotalRecs = GetDataCat63.Recordcount>
<cfif cat63TotalRecs gt 25 and cat63TotalRecs lt 51>
<div id="cat63Box" class="sdbrFlyOut" style="width:500px;top:-63px;">
</cfif>
<cfif cat63TotalRecs gt 50>
<div id="cat63Box" class="sdbrFlyOut" style="width:746px;top:-63px;">
</cfif>
<cfif cat63TotalRecs lt 26>
<div id="cat63Box" class="sdbrFlyOut" style="top:-63px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat63" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat63TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat63" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat63TotalRecs gt 50 and cat63TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat63" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat63TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat63" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 65>

<cfset cat65TotalRecs = GetDataCat65.Recordcount>
<cfif cat65TotalRecs eq 3>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:72px;">
<cfelseif cat65TotalRecs eq 4>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:88px;">
<cfelseif cat65TotalRecs eq 5>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:119px;">
<cfelseif cat65TotalRecs eq 6>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:134px;">
<cfelseif cat65TotalRecs eq 7>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:150px;">
<cfelseif cat65TotalRecs eq 8>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:181px;">
<cfelseif cat65TotalRecs eq 9>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:196px;">
<cfelseif cat65TotalRecs eq 10>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:212px;">
<cfelseif cat65TotalRecs eq 11>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:227px;">
<cfelseif cat65TotalRecs eq 12>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:258px;">
<cfelseif cat65TotalRecs eq 13>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:274px;">
<cfelseif cat65TotalRecs eq 14>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:289px;">
<cfelseif cat65TotalRecs eq 15>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:320px;">
<cfelseif cat65TotalRecs eq 16>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:336px;">
<cfelseif cat65TotalRecs eq 17>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:352px;">
<cfelseif cat65TotalRecs eq 18>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:383px;">
<cfelseif cat65TotalRecs eq 19>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:398px;">
<cfelseif cat65TotalRecs eq 20>
<div id="cat65Box" class="sdbrFlyOut" style="top:-94px;height:413px;">
<cfelseif cat65TotalRecs eq 21>
<div id="cat65Box" class="sdbrFlyOut" style="height:429px;">
<cfelseif cat65TotalRecs eq 22>
<div id="cat65Box" class="sdbrFlyOut" style="height:460px;">
<cfelseif cat65TotalRecs eq 23>
<div id="cat65Box" class="sdbrFlyOut" style="height:475px;">
<cfelseif cat65TotalRecs eq 24>
<div id="cat65Box" class="sdbrFlyOut" style="height:491px;">
<cfelseif cat65TotalRecs eq 25>
<div id="cat65Box" class="sdbrFlyOut">
<cfelseif cat65TotalRecs gt 25 and cat65TotalRecs lt 51>
<div id="cat65Box" class="sdbrFlyOut" style="width:500px;">
<cfelseif cat65TotalRecs gt 50>
<div id="cat65Box" class="sdbrFlyOut" style="width:746px;">
<cfelse>
<div id="cat65Box" class="sdbrFlyOut" style="top:93px;height:57px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat65" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat65TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat65" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat65TotalRecs gt 50 and cat65TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat65" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat65TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat65" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 62>

<cfset cat62TotalRecs = GetDataCat62.Recordcount>
<cfif cat62TotalRecs gt 25 and cat62TotalRecs lt 51>
<div id="cat62Box" class="sdbrFlyOut" style="width:500px;top:-125px;">
</cfif>
<cfif cat62TotalRecs gt 50>
<div id="cat62Box" class="sdbrFlyOut" style="width:746px;top:-125px;">
</cfif>
<cfif cat62TotalRecs lt 26>
<div id="cat62Box" class="sdbrFlyOut" style="top:-125px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat62" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat62TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat62" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat62TotalRecs gt 50 and cat62TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat62" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat62TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat62" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 66>

<cfset cat66TotalRecs = GetDataCat66.Recordcount>
<cfif cat66TotalRecs eq 3>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:72px;">
<cfelseif cat66TotalRecs eq 4>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:88px;">
<cfelseif cat66TotalRecs eq 5>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:119px;">
<cfelseif cat66TotalRecs eq 6>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:134px;">
<cfelseif cat66TotalRecs eq 7>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:150px;">
<cfelseif cat66TotalRecs eq 8>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:181px;">
<cfelseif cat66TotalRecs eq 9>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:196px;">
<cfelseif cat66TotalRecs eq 10>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:212px;">
<cfelseif cat66TotalRecs eq 11>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:227px;">
<cfelseif cat66TotalRecs eq 12>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:258px;">
<cfelseif cat66TotalRecs eq 13>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:274px;">
<cfelseif cat66TotalRecs eq 14>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:289px;">
<cfelseif cat66TotalRecs eq 15>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:320px;">
<cfelseif cat66TotalRecs eq 16>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:336px;">
<cfelseif cat66TotalRecs eq 17>
<div id="cat66Box" class="sdbrFlyOut" style="top:-156px;height:352px;">
<cfelseif cat66TotalRecs eq 18>
<div id="cat66Box" class="sdbrFlyOut" style="height:367px;">
<cfelseif cat66TotalRecs eq 19>
<div id="cat66Box" class="sdbrFlyOut" style="height:398px;">
<cfelseif cat66TotalRecs eq 20>
<div id="cat66Box" class="sdbrFlyOut" style="height:413px;">
<cfelseif cat66TotalRecs eq 21>
<div id="cat66Box" class="sdbrFlyOut" style="height:429px;">
<cfelseif cat66TotalRecs eq 22>
<div id="cat66Box" class="sdbrFlyOut" style="height:460px;">
<cfelseif cat66TotalRecs eq 23>
<div id="cat66Box" class="sdbrFlyOut" style="height:475px;">
<cfelseif cat66TotalRecs eq 24>
<div id="cat66Box" class="sdbrFlyOut" style="height:491px;">
<cfelseif cat66TotalRecs eq 25>
<div id="cat66Box" class="sdbrFlyOut">
<cfelseif cat66TotalRecs gt 25 and cat66TotalRecs lt 51>
<div id="cat66Box" class="sdbrFlyOut" style="width:500px;">
<cfelseif cat66TotalRecs gt 50>
<div id="cat66Box" class="sdbrFlyOut" style="width:746px;">
<cfelse>
<div id="cat66Box" class="sdbrFlyOut" style="top:155px;height:57px;">
</cfif>

<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat66" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat66TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat66" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat66TotalRecs gt 50 and cat66TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat66" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat66TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat66" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 68>

<cfset cat68TotalRecs = GetDataCat68.Recordcount>
<cfif cat68TotalRecs gt 25 and cat68TotalRecs lt 51>
<div id="cat68Box" class="sdbrFlyOut" style="width:500px;top:-187px;">
</cfif>
<cfif cat68TotalRecs gt 50>
<div id="cat68Box" class="sdbrFlyOut" style="width:746px;top:-187px;">
</cfif>
<cfif cat68TotalRecs lt 26>
<div id="cat68Box" class="sdbrFlyOut" style="top:-187px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat68" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat68TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat68" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat68TotalRecs gt 50 and cat68TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat68" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat68TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat68" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 69>

<cfset cat69TotalRecs = GetDataCat69.Recordcount>
<cfif cat69TotalRecs gt 25 and cat69TotalRecs lt 51>
<div id="cat69Box" class="sdbrFlyOut" style="width:500px;top:-218px;">
</cfif>
<cfif cat69TotalRecs gt 50>
<div id="cat69Box" class="sdbrFlyOut" style="width:746px;top:-218px;">
</cfif>
<cfif cat69TotalRecs lt 26>
<div id="cat69Box" class="sdbrFlyOut" style="top:-218px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat69" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat69TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat69" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat69TotalRecs gt 50 and cat69TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat69" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat69TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat69" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>


<cfif CategoryID eq 70>

<cfset cat70TotalRecs = GetDataCat70.Recordcount>
<cfif cat70TotalRecs gt 25 and cat70TotalRecs lt 51>
<div id="cat70Box" class="sdbrFlyOut" style="width:500px;top:-249px;">
</cfif>
<cfif cat70TotalRecs gt 50>
<div id="cat70Box" class="sdbrFlyOut" style="width:746px;top:-249px;">
</cfif>
<cfif cat70TotalRecs lt 26>
<div id="cat70Box" class="sdbrFlyOut" style="top:-249px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat70" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat70TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat70" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat70TotalRecs gt 50 and cat70TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat70" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat70TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat70" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 71>

<cfset cat71TotalRecs = GetDataCat71.Recordcount>
<cfif cat71TotalRecs gt 25 and cat71TotalRecs lt 51>
<div id="cat71Box" class="sdbrFlyOut" style="width:500px;top:-280px;">
</cfif>
<cfif cat71TotalRecs gt 50>
<div id="cat71Box" class="sdbrFlyOut" style="width:746px;top:-280px;">
</cfif>
<cfif cat71TotalRecs lt 26>
<div id="cat71Box" class="sdbrFlyOut" style="top:-280px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat71" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat71TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat71" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat71TotalRecs gt 50 and cat71TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat71" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat71TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat71" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 53>

<cfset cat53TotalRecs = GetDataCat53.Recordcount>
<cfif cat53TotalRecs eq 3>
<div id="cat53Box" class="sdbrFlyOut" style="top:-264px;height:72px;">
<cfelseif cat53TotalRecs eq 4>
<div id="cat53Box" class="sdbrFlyOut" style="top:-248px;height:88px;">
<cfelseif cat53TotalRecs eq 5>
<div id="cat53Box" class="sdbrFlyOut" style="top:-217px;height:119px;">
<cfelseif cat53TotalRecs eq 6>
<div id="cat53Box" class="sdbrFlyOut" style="top:-202px;height:134px;">
<cfelseif cat53TotalRecs eq 7>
<div id="cat53Box" class="sdbrFlyOut" style="top:-186px;height:150px;">
<cfelseif cat53TotalRecs eq 8>
<div id="cat53Box" class="sdbrFlyOut" style="top:-155px;height:181px;">
<cfelseif cat53TotalRecs eq 9>
<div id="cat53Box" class="sdbrFlyOut" style="top:-140px;height:196px;">
<cfelseif cat53TotalRecs eq 10>
<div id="cat53Box" class="sdbrFlyOut" style="top:-124px;height:212px;">
<cfelseif cat53TotalRecs eq 11>
<div id="cat53Box" class="sdbrFlyOut" style="top:-109px;height:227px;">
<cfelseif cat53TotalRecs eq 12>
<div id="cat53Box" class="sdbrFlyOut" style="top:-78px;height:258px;">
<cfelseif cat53TotalRecs eq 13>
<div id="cat53Box" class="sdbrFlyOut" style="top:-62px;height:274px;">
<cfelseif cat53TotalRecs eq 14>
<div id="cat53Box" class="sdbrFlyOut" style="top:-47px;height:289px;">
<cfelseif cat53TotalRecs eq 15>
<div id="cat53Box" class="sdbrFlyOut" style="top:-16px;height:320px;">
<cfelseif cat53TotalRecs eq 16>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:336px;">
<cfelseif cat53TotalRecs eq 17>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:352px;">
<cfelseif cat53TotalRecs eq 18>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:383px;">
<cfelseif cat53TotalRecs eq 19>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:398px;">
<cfelseif cat53TotalRecs eq 20>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:413px;">
<cfelseif cat53TotalRecs eq 21>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:429px;">
<cfelseif cat53TotalRecs eq 22>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:460px;">
<cfelseif cat53TotalRecs eq 23>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:475px;">
<cfelseif cat53TotalRecs eq 24>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;height:491px;">
<cfelseif cat53TotalRecs eq 25>
<div id="cat53Box" class="sdbrFlyOut">
<cfelseif cat53TotalRecs gt 25 and cat53TotalRecs lt 51>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;width:500px;">
<cfelseif cat53TotalRecs gt 50>
<div id="cat53Box" class="sdbrFlyOut" style="top:-1px;width:746px;">
<cfelse>
<div id="cat53Box" class="sdbrFlyOut" style="top:-279px;height:57px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat53" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat53TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat53" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat53TotalRecs gt 50 and cat53TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat53" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat53TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat53" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 49>

<cfset cat49TotalRecs = GetDataCat49.Recordcount>
<cfif cat49TotalRecs gt 25 and cat49TotalRecs lt 51>
<div id="cat49Box" class="sdbrFlyOut" style="width:500px;top:-342px;">
</cfif>
<cfif cat49TotalRecs gt 50>
<div id="cat49Box" class="sdbrFlyOut" style="width:746px;top:-342px;">
</cfif>
<cfif cat49TotalRecs lt 26>
<div id="cat49Box" class="sdbrFlyOut" style="top:-342px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat49" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat49TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat49" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat49TotalRecs gt 50 and cat49TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat49" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat49TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat49" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 52>

<cfset cat52TotalRecs = GetDataCat52.Recordcount>
<cfif cat52TotalRecs gt 25 and cat52TotalRecs lt 51>
<div id="cat52Box" class="sdbrFlyOut" style="width:500px;top:-373px;">
</cfif>
<cfif cat52TotalRecs gt 50>
<div id="cat52Box" class="sdbrFlyOut" style="width:746px;top:-373px;">
</cfif>
<cfif cat52TotalRecs lt 26>
<div id="cat52Box" class="sdbrFlyOut" style="top:-373px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat52" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat52TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat52" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat52TotalRecs gt 50 and cat52TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat52" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat52TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat52" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 42>

<cfset cat42TotalRecs = GetDataCat42.Recordcount>
<cfif cat42TotalRecs gt 25 and cat42TotalRecs lt 51>
<div id="cat42Box" class="sdbrFlyOut" style="width:500px;top:-404px;">
</cfif>
<cfif cat42TotalRecs gt 50>
<div id="cat42Box" class="sdbrFlyOut" style="width:746px;top:-404px;">
</cfif>
<cfif cat42TotalRecs lt 26>
<div id="cat42Box" class="sdbrFlyOut" style="top:-404px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat42" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat42TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat42" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat42TotalRecs gt 50 and cat42TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat42" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat42TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat42" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 48>

<cfset cat48TotalRecs = GetDataCat48.Recordcount>
<cfif cat48TotalRecs gt 25 and cat48TotalRecs lt 51>
<div id="cat48Box" class="sdbrFlyOut" style="width:500px;top:-435px;">
</cfif>
<cfif cat48TotalRecs gt 50>
<div id="cat48Box" class="sdbrFlyOut" style="width:746px;top:-435px;">
</cfif>
<cfif cat48TotalRecs lt 26>
<div id="cat48Box" class="sdbrFlyOut" style="top:-435px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat48" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat48TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat48" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat48TotalRecs gt 50 and cat48TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat48" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat48TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat48" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 51>

<cfset cat51TotalRecs = GetDataCat51.Recordcount>
<cfif cat51TotalRecs gt 25 and cat51TotalRecs lt 51>
<div id="cat51Box" class="sdbrFlyOut" style="width:500px;top:-466px;">
</cfif>
<cfif cat51TotalRecs gt 50>
<div id="cat51Box" class="sdbrFlyOut" style="width:746px;top:-466px;">
</cfif>
<cfif cat51TotalRecs lt 26>
<div id="cat51Box" class="sdbrFlyOut" style="top:-466px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat51" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat51TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat51" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat51TotalRecs gt 50 and cat51TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat51" startrow="51" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat51TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat51" startrow="51" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>

<cfif CategoryID eq 56>

<cfset cat56TotalRecs = GetDataCat56.Recordcount>
<cfif cat56TotalRecs gt 25 and cat56TotalRecs lt 51>
<div id="cat56Box" class="sdbrFlyOut" style="width:500px;top:-497px;">
</cfif>
<cfif cat56TotalRecs gt 50>
<div id="cat56Box" class="sdbrFlyOut" style="width:746px;top:-497px;">
</cfif>
<cfif cat56TotalRecs lt 26>
<div id="cat56Box" class="sdbrFlyOut" style="top:-497px;">
</cfif>
<div class="sdbrBulletListWrpr">
<ul class="sdbrBulletList">
<cfloop query="GetDataCat56" startrow="1" endrow="25"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
<cfif cat56TotalRecs gt 25>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat56" startrow="26" endrow="50"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat56TotalRecs gt 50 and cat56TotalRecs lt 76>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat56" startrow="56" endrow="75"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
</ul>
</cfif>
<cfif cat56TotalRecs gt 75>
<ul class="sdbrBulletList">
<cfloop query="GetDataCat56" startrow="56" endrow="74"><li><a href="http://www.maxvite.com/#CategoryID#/#SubCategoryID#/S/#ReReplace(trim(SubCategory),"[^0-9a-zA-Z]+","-","ALL")#/items.html">#SubCategory#</a></li></cfloop>
#viewallbtn#
</ul>
</cfif>
</div><!--end sdbrBulletListWrpr-->
</div><!--end sdbrFlyOut-->

</cfif>
</div>
</cfoutput>
</div>

  
</div><!--end sdbr-->
</div><!--end sdbrWrpr-->
<div id="promos">
  <a href="/customer_nutritionist.cfm"><img id="nutritionist" src="/img/nutritionist-banner.jpg" alt="Contact a Nutritionist" title="Contact a Nutritionist" width="224" height="94" /></a>
  <a href="http://www.vitaminsreviews.com/" target="_blank"><img src="/img/blog-banner.gif" alt="Maxvite Blog" width="144" height="34" /></a>
</div> <!--end promos-->

</section>
<!--end secondary-->