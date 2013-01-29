$(function(){
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
	$( "#holidayDialog" ).load("http://www.maxvite.com/holiday-schedule.cfm").dialog( "open" );


});