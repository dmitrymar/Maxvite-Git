<cfapplication name="MAXIVITE"
               clientmanagement="Yes"
               sessionmanagement="Yes"
               setclientcookies="Yes"
               sessiontimeout="#CreateTimeSpan(0, 0, 30,0)#">
			   


<!--- Create shopping cart variables if they don't already exist --->
<CFPARAM NAME="Session.StoreItems" DEFAULT=""> 
<CFPARAM NAME="Session.StoreItemsQty" DEFAULT="">
<CFPARAM NAME="Session.StoreTotalAmount" DEFAULT="">
<CFPARAM NAME="Session.StoreCoupon" DEFAULT="">
<CFPARAM NAME="Session.StoreDiscount" DEFAULT="">
<CFPARAM NAME="Session.SubTotalAmount" DEFAULT="">
<CFPARAM NAME="Session.STOREFREECOUPON" DEFAULT="">
<CFPARAM NAME="Session.CID" DEFAULT="">




			   
<!--- <cfset application.ds = "1048423_access"> --->
<cfset application.dso = "1048423_ordersmysql">
<cfset application.ds = "1048423_maxvite">
<cfset application.username = "u1048423_alex">
<cfset application.password = "jkcmeh-2oo">


<CFPARAM NAME="session.logon" DEFAULT="FALSE">
<CFPARAM NAME="session.levelid" DEFAULT="2">
<CFPARAM NAME="session.UserID" DEFAULT=-999>
<CFPARAM NAME="session.username" DEFAULT="">
<CFPARAM NAME="session.ReferURL" DEFAULT="#CGI.HTTP_REFERER#">

<!---Error Handling added by dmitry 7/26/11--->
<cferror type="exception" template="error.cfm">
<cferror type="request" template="error_request.cfm">

