<cfinclude template="isuserok.cfm">
<cfparam name="FEATURED2" default="FALSE">
<cfparam name="FEATURED3" default="FALSE">
<cfparam name="bFormulaTypeID" default="-99">
<!--- obsolete <cfinclude template="ftpinfo.cfm"> --->
<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
<cfset parentDirectory = reReplace(currentDirectory,"[^\\]+\\$","","one") />

<cfswitch expression="#PROCESS#">
	<cfcase value="D">

				<cfquery name="AddRecord" datasource="#Application.ds#">
								Select ImageBig
								FROM Products
								WHERE ProductID = #ProductID#
				</cfquery>						
				<cfoutput Query="AddRecord">
					<cfset IBIG = #IMAGEBIG#>
					
				</cfoutput>
				<!---
				<cfftp action="OPEN"
				       server="#FtpServer#" 
				       username="#FtpUsername#"
				       password="#FtpPassword#"
				       stoponerror="Yes"
				       passive="Yes"
				       connection="DOCMGR">
				<cfif #CFFTP.Succeeded#	NEQ "YES">
					There was a problem deleteing your file. Please try again.">
					<cfabort>
				</cfif>	   
 				<CFFTP ACTION="CHANGEDIR"
				       server="#FtpServer#" 
				       username="#FtpUsername#"
				       password="#FtpPassword#"
				       stoponerror="Yes"
				       directory="images"
				       connection="DOCMGR"
					   retrycount="1"
				       timeout="60" 
				       passive="Yes">
				<cfif #CFFTP.Succeeded#	NEQ "YES">
					There was a problem deleteing your file. Please try again.">
					<cfabort>
				</cfif>	   --->
				
<cfif IBIG NEQ "coming-large.jpg">
				<cftry>
					<cfif FileExists("#parentDirectory#images/#IBIG#")>
						<cffile action="delete" file="#parentDirectory#images/#IBIG#" />
					</cfif>
					<cfif FileExists("#parentDirectory#cartpreviewimages/#IBIG#")>
						<cffile action="delete" file="#parentDirectory#cartpreviewimages/#IBIG#" />
					</cfif>
					<cfcatch>
						There was a problem deleteing your file. Please try again.
						<cfabort>
					</cfcatch>
				</cftry>
				<!---
				<cfftp action="EXISTSFILE"
				   connection="DOCMGR"
			       stoponerror="Yes"
			       remotefile="#IBIG#">
				<cfif cfftp.ReturnValue EQ "YES">   
					<cfftp action="REMOVE"
				       stoponerror="Yes"
				       item="#IBIG#"
				       connection="DOCMGR"
					   retrycount="1"
				       timeout="60" 
				       passive="Yes">
				</cfif>
				<cfif #CFFTP.Succeeded#	NEQ "YES">
					There was a problem deleteing your file. Please try again.">
					<cfabort>
				</cfif> --->
</cfif>



					   
				<!--- <cfftp action="CLOSE"
				       stoponerror="Yes"
				       connection="DOCMGR"
					   retrycount="1"
				       timeout="60" 
				       passive="Yes">--->
					<cftransaction>
					<cftry>
						<cfquery name="AddRecord" datasource="#Application.ds#">
								DELETE FROM Product_SUBCategory_Map 
								WHERE ProductID = #ProductID#
						</cfquery>			
						<cfquery name="AddRecord" datasource="#Application.ds#">
								DELETE FROM Product_Formula_Map 
								WHERE ProductID = #ProductID#
						</cfquery>			
						<cfquery name="AddRecord" datasource="#Application.ds#">
								DELETE FROM Products
								WHERE ProductID = #ProductID#
						</cfquery>						
						<cfcatch type="Database">
							<cfinclude template="dbc.cfm">
						</cfcatch>
					</cftry>
					</cftransaction>
	</cfcase>	
	<cfcase value="A">	

	
	
<cfif ImageBig EQ "">
	Please select a large image to upload!
	<cfabort>
</cfif>




	

<!--- ImageBig --->
<cfif ImageBig NEQ "">
	<cftry>
		<cffile action="upload"
			fileField="ImageBig"
			destination="#parentDirectory#images"
			accept = "image/*, application/pdf"
			nameConflict="MakeUnique"
			result="fileResult">

		<cfscript>
			MyFile = parentDirectory & "\images\" & fileResult.serverFile;
			MyFileCart = parentDirectory & "\cartpreviewimages\" & fileResult.serverFile;
			myImage = ImageRead(MyFile);
			ImageScaleToFit(myImage, 520, 700);
			ImageWrite(myImage, MyFile);
			ImageScaleToFit(myImage, 40, 40);
			ImageWrite(myImage, MyFileCart);
		</cfscript>

		<cfcatch>
			There was a problem uploading your small image. Please try again. Error: <cfoutput>#CFCATCH.message#</cfoutput>
			<cfabort>
		</cfcatch>
	</cftry>
	<cfset IB = fileResult.serverFile />
</cfif>

			<cfquery name="GetBrand" datasource="#Application.ds#">
	SELECT Brand FROM Brands WHERE BrandID = #BrandID#
</cfquery>
		<cftransaction>
		<cftry>
			<cfquery name="GetData" datasource="#Application.ds#">
				INSERT INTO Products 
					(
						Title, 
						UPC,
						Description,
						imagebig,
						Display,
						Availability,
                        supfacts,
						AdditionalHTML,
						MINORDRETAIL, 
						IntProductID,
						InStockFlag,
						ListPrice,
 						OurPrice,
						Weight,
						Tablets,
						StrapLine,
						SpecTable,
						FeaturedProductFLAG,
						FeaturedProductFLAG2,
						FeaturedProductFLAG3,
<!--- 						FormulaTypeID, --->
				BrandID,
				FreeShippingFlag,
				HeavyItemFlag,
				ServingSize,
				SortID,
				taxflag,MetaTitle,MetaKeywords,MetaDesc,
				PricegrabberCats
				)
				VALUES
				(
				'#GetBrand.Brand# #Title#',
				<cfif #UPC# NEQ "">#UPC#<cfelse>0</cfif>,
				'#Description#',
				'#ib#',
				#Display#,
				#Availability#,
                '#supfacts#',
				'#AdditionalHTML#',
				#MINORDRETAIL#,
				'#IntProductID#',
				#InStockFlag#,
				#ListPrice#,
				#OurPrice#,
				#Weight#,
				'#Tablets#',
				'#StrapLine#',
				'#SpecTable#',
				#FeaturedProductFLAG#,
				#FeaturedProductFLAG2#,
				#FeaturedProductFLAG3#,
				<!--- 						#FormulaTypeID#, --->
						#BrandID#,
						#FreeShippingFlag#,
						#HeavyItemFlag#,
						'#ServingSize#',
						<cfif isnumeric(sortid)>#SortID#<cfelse>0</cfif>,
				#taxflag#	,'#MetaTitle#','#MetaKeywords#','#MetaDesc#',
				'#PricegrabberCats#'
				)
			</cfquery>
			<cfquery name="GetData" datasource="#Application.ds#">
				Select @@IDENTITY as SKEY FROM Products
			</cfquery>
			<cfset ProdID = #GetData.SKEY#>
			<cfloop index="LI" list="#SubCategoryID#" delimiters=",">
				<cfquery name="AddRecord" datasource="#Application.ds#">
					INSERT INTO Product_SUBCategory_Map VALUES (#ProdID#,#LI#)
				</cfquery>
			</cfloop>						
			<cfloop index="LI" list="#FormulaTypeID#" delimiters=",">
				<cfquery name="AddRecord" datasource="#Application.ds#">
					INSERT INTO Product_Formula_Map VALUES (#ProdID#,#LI#)
				</cfquery>
			</cfloop>						
			<cfcatch type="Database">
				<cfinclude template="dbc.cfm">
			</cfcatch>
		</cftry>
		</cftransaction>
	</cfcase>
	
	<cfcase value="M">	


<cfset IB= "#IB#">	


<!--- ImageBig --->
<cfif ImageBig NEQ "">
	<cftry>
		<cffile action="upload"
			accept = "image/*, application/pdf"
			fileField="ImageBig"
			destination="#parentDirectory#images"
			nameConflict="MakeUnique"
			result="fileResult">

		<cfscript>
			MyFile = parentDirectory & "\images\" & fileResult.serverFile;
			MyFileCart = parentDirectory & "\cartpreviewimages\" & fileResult.serverFile;
			myImage = ImageRead(MyFile);
			ImageScaleToFit(myImage, 520, 700);
			ImageWrite(myImage, MyFile);
			ImageScaleToFit(myImage, 40, 40);
			ImageWrite(myImage, MyFileCart);
		</cfscript>

		<cfcatch>
			There was a problem uploading your small image. Please try again. Error: <cfoutput>#CFCATCH.message#</cfoutput>
			<cfabort>
		</cfcatch>
	</cftry>
	<cfset IB = fileResult.serverFile />
</cfif>

		<cftransaction>
		<cftry>
			<cfquery name="GetData" datasource="#Application.ds#">
				UPDATE Products
					SET Title = '#Title#',
					UPC = <cfif #UPC# NEQ "">'#UPC#'<cfelse>0</cfif>,
					Description = '#Description#',
					ServingSize = '#ServingSize#',
					minordretail = #minordretail#,
					imagebig = '#IB#',
					Weight = #Weight#,
					Display = #Display#,
					Availability = #Availability#,
                    supfacts = '#SUPFACTS#',
					ADDITIONALHTML = '#ADDITIONALHTML#',
					IntProductID = '#IntProductID#',
					Tablets = '#Tablets#',
					StrapLine = '#StrapLine#',
					SpecTable = '#SpecTable#',
					INSTOCKFLAG = #INSTOCKFLAG#,
					taxflag = #taxflag#,
					ListPrice = #ListPrice#,
					OurPrice = #OurPrice#, 
					<cfif isnumeric(sortid)>SortID = #SortID#,</cfif>
					FeaturedProductFLAG = #FeaturedProductFLAG#,
					FeaturedProductFLAG2 = #FeaturedProductFLAG2#,
					FeaturedProductFLAG3 = #FeaturedProductFLAG3#,
					<!--- FormulaTypeID = #FormulaTypeID#, --->
				BrandID	= #BrandID#,
				FreeShippingFlag = #FreeShippingFlag#,
				HeavyItemFlag =	#HeavyItemFlag#,
				MetaTitle  = '#MetaTitle#',
				MetaKeywords =  '#MetaKeywords#',
				MetaDesc = '#MetaDesc#'
				WHERE ProductID = #ProductID#
			</cfquery>
			<cfif PricegrabberCats NEQ "">
				<cfquery name="GetData" datasource="#Application.ds#">
				UPDATE Products
					SET PricegrabberCats = '#PricegrabberCats#'
				WHERE ProductID = #ProductID#
				</cfquery>
			</cfif>
			<cfquery name="AddRecord" datasource="#Application.ds#">
					DELETE FROM Product_SUBCategory_Map 
					WHERE ProductID = #ProductID#
			</cfquery>			
			<cfquery name="AddRecord" datasource="#Application.ds#">
					DELETE FROM Product_Formula_Map 
					WHERE ProductID = #ProductID#
			</cfquery>			

			<cfloop index="LI" list="#SubCategoryID#" delimiters=",">
				<cfquery name="AddRecord" datasource="#Application.ds#">
					INSERT INTO Product_SUBCategory_Map VALUES (#ProductID#,#LI#)
				</cfquery>
			</cfloop>						
			<cfloop index="LI" list="#FormulaTypeID#" delimiters=",">
				<cfquery name="AddRecord" datasource="#Application.ds#">
					INSERT INTO Product_Formula_Map VALUES (#ProductID#,#LI#)
				</cfquery>
			</cfloop>						
			
			<cfcatch type="Database">
				<cfinclude template="dbc.cfm">
			</cfcatch>
		</cftry>
		</cftransaction>
	</cfcase>		
</cfswitch>
<cflocation url="Products-l.cfm?SCategoryID=#SCategoryID#&SSubCategoryID=#SSubCategoryID#&FormulaTypeID=#bFormulaTypeID#&KEYWORD=#urlencodedformat(KEYWORD)#&FEATURED=#FEATURED#&IMPORT=#IMPORT#&FEATURED2=#FEATURED2#&FEATURED3=#FEATURED3#&SBrandID=#SBrandID#" addtoken="Yes">

<cfabort>

