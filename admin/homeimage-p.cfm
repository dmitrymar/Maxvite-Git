<cfinclude template="isuserok.cfm">

<!--- obsolete <cfinclude template="ftpinfo.cfm"> --->

<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
<cfset parentDirectory = reReplace(currentDirectory,"[^\\]+\\$","","one") />

<cfswitch expression="#PROCESS#">
	<cfcase value="D">
				<cfquery name="AddRecord" datasource="#Application.ds#">
								Select FileName
								FROM homeimages
								WHERE ImageID = #ImageID#
				</cfquery>						
				<cfset iFileName=#AddRecord.FileName#>

					<cftransaction>
					<cftry>
						<cfquery name="AddRecord" datasource="#Application.ds#">
								DELETE FROM homeimages
								WHERE ImageID = #ImageID#
						</cfquery>
						<cfif iFileName NEQ "" AND FileExists("#parentDirectory#img/featured-ads/#iFileName#")>
							<cffile action="delete" file="#parentDirectory#img/featured-ads/#iFileName#" />
						</cfif>

						<cfcatch type="Database">
							<cfinclude template="dbc.cfm">
						</cfcatch>
					</cftry>
					</cftransaction>
	</cfcase>	
	<cfcase value="A">	
	
<cfif FileName EQ "">
	Please select a image to upload!
	<cfabort>
</cfif>


<!--- ImageSmall --->
<cfif FileName NEQ "">
	<cftry>
		<cffile action="upload"
			fileField="FileName"
			destination="#parentDirectory#img/featured-ads"
			accept = "image/*, application/pdf"
			nameConflict="MakeUnique"
			result="fileResult">

		<cfcatch>
			There was a problem uploading your file. Please try again. Error: <cfoutput>#CFCATCH.message#</cfoutput>
			<cfabort>
		</cfcatch>
	</cftry>
	<cfset ISMALL = fileResult.serverFile />
</cfif>

		<cftransaction>
		<cftry>
			<cfquery name="GetData" datasource="#Application.ds#">
				INSERT INTO homeimages 
					(
						ImageName, 
						FileName,
						LinkUrl, 
						SortID
				)
				VALUES
				(
				'#ImageName#',
				'#ISMALL#',
				'#LinkURL#',
				<cfif isnumeric(sortid)>#SortID#<cfelse>0</cfif>
				)
			</cfquery>
			<cfcatch type="Database">
				<cfinclude template="dbc.cfm">
			</cfcatch>
		</cftry>
		</cftransaction>
	</cfcase>
	
	<cfcase value="M">	

<cfset ISMALL= "#ISMALL#">

<!--- ImageSmall --->
<cfif FileName NEQ "">
	<cftry>
		<cffile action="upload"
			fileField="FileName"
			accept = "image/*, application/pdf"
			destination="#parentDirectory#img/featured-ads"
			nameConflict="MakeUnique"
			result="fileResult">

		<cfcatch>
			There was a problem uploading your file. Please try again. Error: <cfoutput>#CFCATCH.message#</cfoutput>
			<cfabort>
		</cfcatch>
	</cftry>
	<cfset ISMALL = fileResult.serverFile />
</cfif>

		<cftransaction>
		<cftry>
			<cfquery name="GetData" datasource="#Application.ds#">
				UPDATE homeimages
					SET imagename = '#ImageName#',
					LinkURL = '#LinkURL#',
					FileName = '#ISMALL#',
					SortId=<cfif isnumeric(sortid)>#val(SortID)#<cfelse>0</cfif>
				WHERE ImageID = #ImageID#
			</cfquery>			

			
			<cfcatch type="Database">
				<cfinclude template="dbc.cfm">
			</cfcatch>
		</cftry>
		</cftransaction>
	</cfcase>		
</cfswitch>
<cflocation url="homeimage-l.cfm" addtoken="Yes">
<cfabort>

