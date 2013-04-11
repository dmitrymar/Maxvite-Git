<cfset Filename_Temp = "">
<cfloop index="I" list="#ATTRIBUTES.IMAGE#" delimiters="/,\">
	<cfset Filename_Temp = "#I#">
</cfloop>

<!--- 				<cfset StatDir = ExpandPath(".")>
				<CFFILE ACTION="UPLOAD" FILEFIELD="ImageSmall" DESTINATION="#StatDir#" NAMECONFLICT="Overwrite">
 --->				<cftry>
				<cfftp action="OPEN"
				       server="#ATTRIBUTES.FtpServer#" 
				       username="#ATTRIBUTES.FtpUsername#"
				       password="#ATTRIBUTES.FtpPassword#"
				       stoponerror="Yes"
				       passive="Yes"
				       connection="DOCMGR">
					<cfcatch type="Any">	   
					<cfoutput>#CFCATCH.message#</cfoutput>
						There was a problem uploading your file. Please try again.
						<cfabort>
					</cfcatch>
				</cftry>
				<cftry>	   
				<cfftp action="CHANGEDIR"
				       server="#ATTRIBUTES.FtpServer#" 
				       username="#ATTRIBUTES.FtpUsername#"
				       password="#ATTRIBUTES.FtpPassword#"
				       stoponerror="Yes"
				       directory="images"
				       connection="DOCMGR"
					   retrycount="1"
				       timeout="60" 
				       passive="Yes">				
					<cfcatch type="Any">	   
						<cfoutput>C:#CFCATCH.message#</cfoutput>
						There was a problem uploading your file. Please try again.
						<cfabort>
					</cfcatch>
				</cftry>	  
				
				<cfftp action="EXISTSFILE"
				   connection="DOCMGR"
			       stoponerror="Yes"
			       remotefile="#Filename_Temp#">
				<cfif cfftp.ReturnValue EQ "YES">   
					<cfftp action="REMOVE"
				       stoponerror="Yes"
				       item="#Filename_Temp#"
				       connection="DOCMGR"
					   retrycount="1"
				       timeout="60" 
				       passive="Yes">
				</cfif>
				<cfif #CFFTP.Succeeded#	NEQ "YES">
						There was a problem uploading your file. Please try again. Error: <cfoutput>D:#CFCATCH.message#</cfoutput>
					<cfabort>
				<cfelse>
						Exists...replacing...	
				</cfif>
				
				 
				<cftry>
						<cfftp action="PUTFILE"
					       server="#ATTRIBUTES.FtpServer#" 
				    	   username="#ATTRIBUTES.FtpUsername#"
					       password="#ATTRIBUTES.FtpPassword#"
				    	   stoponerror="No"
						   localfile="#ATTRIBUTES.LOCALIMAGEFILE#"
						   remotefile="#Filename_Temp#"
					       transfermode="BINARY"
				    	   connection="DOCMGR"
						   retrycount="1"
				    	   timeout="60" 
					       passive="Yes">

<!---Shrink image if its height or width is too large--->                    
<cfset thisPath = ExpandPath(".")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>
<cfset MyFile="#thisDirectory#\images\#Filename_Temp#">
<cfset MyFileCart="#thisDirectory#\cartpreviewimages\#Filename_Temp#">
<cfimage source="#MyFile#" action="info" structName="bigImgInfo">

<!---shrink to cart images--->
<cfif bigImgInfo.height GT bigImgInfo.width>
  <cfimage source="#MyFile#" action="resize" width="" height="40" destination="#MyFileCart#" overwrite="yes">
<cfelse>
  <cfimage source="#MyFile#" action="resize" width="40" height="" destination="#MyFileCart#" overwrite="yes">
</cfif>

<!---shrink if original image is too large --->
<cfif bigImgInfo.height GT 700>
  <cfimage source="#MyFile#" action="resize" width="" height="700" destination="#MyFile#" overwrite="yes">
</cfif>
<cfif bigImgInfo.width GT 520>
  <cfimage source="#MyFile#" action="resize" width="520" height="" destination="#MyFile#" overwrite="yes">
</cfif>                   
<!------>                   
                    
					<cfcatch type="Any">	   
						<cfoutput>D:#CFCATCH.message#</cfoutput>
						There was a problem uploading your file. Please try again.
						<cfabort>
					</cfcatch>
				</cftry>
				<cfftp action="CLOSE"
				       stoponerror="Yes"
				       connection="DOCMGR"
					   retrycount="1"
				       timeout="60" 
				       passive="Yes">				
				<cfif #CFFTP.Succeeded#	NEQ "YES">
						There was a problem uploading your file. Please try again. Error: <cfoutput>#CFCATCH.message#</cfoutput>
						<cfabort>
				</cfif>



				
<cfset CALLER.IMAGESAVENAME = "#Filename_Temp#">
					   
