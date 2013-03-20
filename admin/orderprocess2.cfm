<cfinclude template="isuserok.cfm">
<cfparam name="ShippingMethod" default="">

			<cfswitch expression="#Process#">
			<cfcase value="CC">
			<cfquery name="AddRecord" datasource="#Application.dsoo#">
					UPDATE Orders
					Set CreditCardNumber = '',
					CreditCardExpMonth = '',
					CreditCardExpYear = ''
					WHERE OrderID = #OrderID#
			</cfquery>
			Card Number Deleted!
			</cfcase>

			<cfcase value="CS">
			<cfquery name="AddRecord" datasource="#Application.dso#">
					UPDATE Orders
					Set Status = #Status#
					WHERE OrderID = #OrderID#
			</cfquery>

			<cfif Status EQ 3>
				<cfquery name="UpdateOrder" datasource="#Application.dso#">
					Update Orders
					set TrackingNumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(TrackingNumber)#">
					,FinalShipMethod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ShippingMethod#">
					WHERE OrderID = #OrderID#
				</cfquery>

				<cfquery name="GetEmail" datasource="#Application.dso#">
					Select * from Orders
					WHERE OrderID = #OrderID#
				</cfquery>

<cfquery name="GetData" datasource="#Application.dso#">
	SELECT * FROM Orders
	WHERE OrderID = #OrderID#
</CFQUERY>
<cfquery name="GetProductData" datasource="#Application.dso#">
	SELECT * FROM OrderLineItems
	WHERE OrderID = #OrderID#
</CFQUERY>

				<cfif isvalid("email",#GetEmail.Email#)>

<cfmail TO="#GetEmail.Email#" FROM="maxvite@maxvite.com" subject="Order Tracking" server="#Application.mailserver#" username="#Application.mailuser#" password="#Application.mailpassword#" type="html">

<cfinclude template = "../email-template-top.cfm">

<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">Dear #ucase(left(GetData.Bill_Firstname,1))##lcase(mid(GetData.Bill_Firstname, 2, len(GetData.Bill_Firstname) -1 ))#,
<br><br>
We are happy to inform you that your MaxVite order number #OrderID# has shipped.
<br><br>
<b>This shipment was sent to:</b>
<br><br>                       
#ucase(left(GetData.Ship_Firstname,1))##lcase(mid(GetData.Ship_Firstname, 2, len(GetData.Ship_Firstname) -1 ))# #ucase(left(GetData.Ship_Lastname,1))##lcase(mid(GetData.Ship_Lastname, 2, len(GetData.Ship_Lastname) -1 ))#
<br>
#GetData.Ship_Address# #GetData.Ship_RoomFloor#
<br>
#GetData.Ship_City#, #GetData.Ship_State# #GetData.Ship_Zipcode#
<br><br>
Shipping Method: #UCase(ShippingMethod)#
<br>
Tracking Number: <cfif ucase(trim(ShippingMethod)) EQ "USPS"><a href="http://trkcnfrm1.smi.usps.com/PTSInternetWeb/InterLabelInquiry.do?origTrackNum=#Trim(TrackingNumber)#" style="text-decoration: underline; color: ##004922;">#Trim(TrackingNumber)#</a><cfelse><a href="http://wwwapps.ups.com/WebTracking/processInputRequest?sort_by=status&tracknums_displayed=1&TypeOfInquiryNumber=T&loc=en_us&InquiryNumber1=#Trim(TrackingNumber)#&track.x=0&track.y=0" style="text-decoration: underline; color: ##004922;">#Trim(TrackingNumber)#</a></cfif>
<br><br>
<b>You ordered the following items:</b>
<br>
</p> 


<table cellspacing="0" style="font-family: Arial, Helvetica, sans-serif; color: ##004922; width: 564px; border-collapse: collapse;">
<thead style="border: 1px solid ##c0c0c0; background-color: ##F1F1F1; font-size: 11px; font-weight: bold;"><tr>
<th style="padding-top: 3px; padding-bottom: 3px; width: 70px;" align="center">Item</th>
<th align="left" style="padding: 3px;">Description</th>
<th align="left" style="padding: 3px;">Price</th>
<th align="left" style="padding: 3px;">Qty</th>
<th align="left" style="padding: 3px;">Subtotal</th>
</tr></thead>
<cfloop query="GetProductData">
    <cfquery name="GetProductImage" datasource="#Application.ds#">
    SELECT *
    FROM Products
    Where ProductID = #ProductID#
    </CFQUERY> 

<tr style="font-size: 13px; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: ##C0C0C0;">
<td align="center" style="vertical-align: top; padding:7px 3px 7px 3px;" valign="top">
                  <a href="http://www.maxvite.com/itemdetail.cfm?ProductID=#ProductID#"><img src="http://www.maxvite.com/images/#GetProductImage.imagebig#" style="max-height: 40px; max-width: 40px;" alt="#Product#" border="0" /></a>
</td>
    <td align="left" style="vertical-align: top; padding:7px 3px 7px 3px;" valign="top">
<a href="http://www.maxvite.com/itemdetail.cfm?ProductID=#ProductID#" style="color: ##004922; text-decoration: none; font-weight: bold;">#GetProductImage.Title#</a><br><em>#GetProductImage.Tablets#</em>
</td>
    <td align="left" style="vertical-align: top; padding:7px 3px 7px 3px;" valign="top">#DollarFormat(Price)#</td>
    <td align="left" style="vertical-align: top; padding:7px 3px 7px 3px;" valign="top">#NumberFormat(Qty,'_')#</td>
    <td align="left" style="vertical-align: top; padding:7px 3px 7px 3px;" valign="top">#DollarFormat(total)#</td>
  </tr>    
</cfloop>
</table>




<br>
<p style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; line-height: 1.5; color: ##004922; margin: 0; padding: 0;">
Happy Shopping!
<br><br>
MaxVite Customer Service Team
<br><br>
</p>
                                               
<cfinclude template = "../email-template-bottom.cfm">                        
					</cfmail>
				</cfif>
				<script language="javascript">
					window.opener.refreshParent();
					window.close();
				</script>

			<cfelse>
				<cfif isDefined("Name")>
					<cflocation url="orders-l.cfm?B1=#B1#&Name=#Name#" addtoken="yes">
				<cfelseif isDefined("OrderDate")>
					<cflocation url="orders-l.cfm?B1=#B1#&OrderDate=#OrderDate#" addtoken="yes">
				<cfelseif isDefined("OrdID")>
					<cflocation url="orders-l.cfm?B1=#B1#&OrderID=#OrdID#" addtoken="yes">
				<cfelse>
					<cflocation url="orders-l.cfm?B1=#B1#" addtoken="yes">
				</cfif>
			</cfif>
			</cfcase>
			</cfswitch>




