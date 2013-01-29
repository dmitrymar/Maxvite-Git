function disableEnterKey(e)
{
     var key;
     if(window.event)
          key = window.event.keyCode; //IE
     else
          key = e.which; //firefox

     return (key != 13);
}

function validateFields() {
  if (document.nutritionistForm.email.value.indexOf('@') < 0) {
  alert('Please Enter a Valid E-Mail Address');
  return false;
  }
return true;
}

function addToCart(qtyName) {
 var currentQty = document.getElementById(qtyName);
  if (currentQty.value == '' || (isNaN(currentQty.value)))
	{
		alert('Please enter a qty!!');
		return false;
	}
  if (currentQty.value < 1)
	  {
		  alert('The minimum qty for this item is 1');
		  return false;
	  }
return true;
}

// make link "Read x Review" go to "Reviews" tab
		function reviewstab() {
		$('#productTabs').tabs('select', 'reviewsContent');// switch to reviews tab
		var productTabs = $("#productTabs");
		var tabPosition = productTabs.position();		
		window.scrollTo(0,tabPosition.top);
  		}
		
//****** jQuery - Execute scripts after DOM is loaded
$(function(){ 
//Customer feedback
if (localStorage.getItem("feedback") === null) {
  $('#feedbackLink').show();
}
  $('#feedbackLink').click(function(ev){
	popUp(this.href, 600, 400);

	return false;
  });


//header tab flyout function
$('.headerTab').click(function() {
var $parent = $(this).parent();							   
//hide other flyouts							   
$('#signinFlyout, #cartPreviewItemsBox').hide();
$('#hdrAccount li, #cartPreviewTab').removeClass("active");
$parent.siblings().children('.topNavFlyout').hide();
$parent.siblings().removeClass("active");
//main function
$parent.toggleClass("active").children(".topNavFlyout").slideToggle(100);
	return false;
})


// toggle categories on product page
$(".xpandList").show();
var $moreCats = $(".xpandList li").not(":first-child");
$moreCats.hide();
$(".formulaHead, .categoryHead").click(function(){
$(this).next().find($moreCats).slideToggle(100);
})
.toggle( function() {
    $(this).children("span").empty().append("<img src='/img/list-minus.gif'>");
}, function() {
    $(this).children("span").empty().append("<img src='/img/list-plus.gif'>");
}); 


 		// Email a Friend Popup
		$("#emailProductDialog").dialog({ autoOpen: false })	   
		$('ul#productTools li.productToolEmail a').click(function() {
 		$("#emailProductDialog").dialog('open')
		// prevent the default action, e.g., following a link
		return false;
		});

		// tab menu on product page
		$("#productTabs").tabs();
		//remove some default jquery ui classes
		$('#productTabs').removeClass('ui-corner-all ui-widget-content');
		$('#productTabs ul').removeClass('ui-corner-all ui-widget-header');
		$('#productTabs div').removeClass('ui-tabs-panel ui-corner-bottom');
		$('#productTabs li').removeClass('ui-corner-top');


// regular popup window function
function popUp(url, width, height) {
    var page = url;
    var width = width;
    var height = height;
    var windowprops = "toolbar=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width="+width+", height="+height+"";
    window.open(page, 'PopupName', windowprops);
}
//
$('.productToolEmail a').click(function(ev){
popUp(this.href, 600, 400);
return false;
})

var ajax_load = "<img class='loading' src='/img/spinner.gif' alt='loading...' />";

function rollDown() {
	$("#hdrCartListShowMiniCart span").addClass("active");
	setTimeout(function() { $("#cartPreviewItemsBox").slideDown("slow");}, 400);
}
function rollUp() {
   	$("#cartPreviewItemsBox").slideUp("200");
	$("#hdrCartListShowMiniCart span").removeClass("active");
}

// AJAX
$.ajaxSetup ({
	cache: false
/*	,
	error:function(x,e){
		if(x.status==404){
		alert('Requested URL not found.');
		}else if(x.status==500){
		alert('Internel Server Error.');
		}else if(e=='parsererror'){
		alert('Error.\nParsing JSON Request failed.');
		}else if(e=='timeout'){
		alert('Request Time out.');
		}
	}
*/
});
	
function minicart() {
    var loadMinicart = "/minicart_process.cfm";

    $.ajax({
        type: "GET",
        url: '/ajax/store_items2.cfc',
        dataType: "json",
        data: {
            method: "GetStoreItemsCount"
        },
        success: storeItemsResponse
    });

    function storeItemsResponse(data) {
        //var obj = jQuery.parseJSON(data);

        if (data.STOREITEMS >= 1) {
            $('#emptyCartList').hide();
            $('#cartHeaderNav').show();
        } else {
            $('#emptyCartList').show();
        }
        $('.storeItemsQty').html(data.STOREITEMS);
    }

    $("#cartPreviewItemsBox").html(ajax_load).load(loadMinicart);

}

minicart();

$(".additemform").submit(addItem);

  function addItem() {
	  //$(this).find(":button").hide();
	  $(":button", this).hide();
	  $('.addingItemMsg', this).show();

	  var allFields = $(this).serialize();
		$.ajax({
		type: 'POST',
		url: '/additem.cfm',
		data: allFields,
		success: minicart,
	  	complete: function(){
		$('.addingItemMsg').hide();
		$(":button").show();
		$( 'html, body' ).animate( { scrollTop: 0 }, 'slow' );
		rollDown();
		setTimeout(rollUp, 7000);
   		}
		
	  });
	  return false;
  }
// end cart preview code


/* Tab menu by Soh Tonaka http://www.sohtanaka.com/web-design/simple-tabs-w-css-jquery/ */
	//Default Action
	$(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {
		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content
		var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active content
		return false;
	});

	$('#brandSpecials').html(globals.spinner).load('/brand-specials-tab.cfm');	
	$('#weeklySpecials').html(globals.spinner).load('/weekly-specials-tab.cfm', function() {$("#weeklySpecials .additemform").submit(addItem);});
	$('#superDeals').html(globals.spinner).load('/super-deals-tab.cfm', function() {$("#superDeals .additemform").submit(addItem);});
	$('#buy1get1free').html(globals.spinner).load('/buy1get1free-tab.cfm', function() {$("#buy1get1free .additemform").submit(addItem);});

});
		