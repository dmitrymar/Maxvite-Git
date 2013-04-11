<cfinclude template="isuserok.cfm">

<!--- <cfinclude template="ftpinfo.cfm"> --->
<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
<cfset parentDirectory = ReReplace(currentDirectory,"[^\\]+\\$","","one") />

<cfswitch expression="#PROCESS#">
	<cfcase value="D">
				<cfquery name="AddRecord" datasource="#Application.ds#">
								Select FileName
								FROM brandspecials
								WHERE BrandId = #BrandId#
				</cfquery>
				<cfset iFileName=#AddRecord.FileName#>

					<cftransaction>
					<cftry>
						<cfquery name="AddRecord" datasource="#Application.ds#">
								DELETE FROM brandspecials
								WHERE BrandId = #BrandId#
						</cfquery>
						<cfif iFileName NEQ "" AND FileExists("#parentDirectory#img/brand-specials/#iFileName#")>
							<cffile action="delete" file="#parentDirectory#img/brand-specials/#iFileName#" />
						</cfif>
					<!--- <cfif iFileName NEQ "">
						<cfset FILESAVENAME = "">
						<cf_putfile LOCALFILE="" REMOTEFILE="#iFileName#"  REMOTEDIR="wwwroot/img/brand-specials" FTPserver="#FtpServer#" FTPusername="#FtpUsername#" FTPpassword="#FtpPassword#">
					</cfif> --->

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
			accept = "image/*, application/pdf"
			destination="#parentDirectory#img/brand-specials"
			nameConflict="MakeUnique"
			result="fileResult">

		<cfcatch>
			There was a problem uploading your file. Please try again. Error: <cfoutput>#CFCATCH.message#</cfoutput>
			<cfabort>
		</cfcatch>
	</cftry>
	<cfset ISMALL = fileResult.serverFile />
<!---
	<cfset FILESAVENAME = "">
	<cf_putfile LOCALFILE="#FileName#" REMOTEFILE="#NameSmall#" REMOTEDIR="wwwroot/img/brand-specials" FTPserver="#FtpServer#" FTPusername="#FtpUsername#" FTPpassword="#FtpPassword#">
	<cfset ISMALL = "#FILESAVENAME#"> --->
</cfif>

		<cftransaction>
		<cftry>
			<cfquery name="GetData" datasource="#Application.ds#">
				INSERT INTO brandspecials
					(
						BrandName,
						FileName,
						LinkUrl,
						SortID
				)
				VALUES
				(
				'#BrandName#',
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
			accept = "image/*, application/pdf"
			fileField="FileName"
			destination="#parentDirectory#img/brand-specials"
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
				UPDATE brandspecials
					SET BrandName = '#BrandName#',
					LinkURL = '#LinkURL#',
					FileName = '#ISMALL#',
					SortId=<cfif isnumeric(sortid)>#SortID#<cfelse>0</cfif>
				WHERE BrandId = #BrandId#
			</cfquery>


			<cfcatch type="Database">
				<cfinclude template="dbc.cfm">
			</cfcatch>
		</cftry>
		</cftransaction>
	</cfcase>
</cfswitch>
<cflocation url="brandspecial-l.cfm" addtoken="Yes">
<cfabort>

