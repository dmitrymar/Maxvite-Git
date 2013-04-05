$(function(){
	/*$( "#holidayDialog" ).dialog({ autoOpen: true, modal: true, minWidth: 600}).html(globals.spinner).load("/holiday-schedule.cfm");*/

$('#slides').after('<div id="dashboard">')
			.cycle({
				fx:'fade',
				force: 1,
				timeout: 8000,
				pause: 1,
				pauseOnPagerHover: 1,
				pager:  '#dashboard'
	});
	$("a:contains('HIDDEN')").hide();

	//Default Action
	$(".tab_content").hide(); //Hide all content
	$("ul.hometabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	/*$('#weeklySpecials').html(globals.spinner).load('/weekly-specials-tab.cfm', function() {$("#weeklySpecials .additemform").submit(addItem);});*/

		$('#homeSpecialsContent').html(globals.spinner).load('/home-specials.cfm', function() {$(".additemform").submit(function(event) {
	event.preventDefault();																															 
  $(this).sitePlugins('additem');

});
});




	//On Click Event
	$("ul.hometabs li").click(function() {
		$("ul.hometabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content
		var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active content
		return false;
	});

});