// This file is shared by entire site (both checkout and non-checkout pages)
var globals = { 
 spinner : "<img class='loading' src='/img/spinner.gif' alt='loading...' />" 
} 
function popUp(url, width, height) {
	var page = url;
	var width = width;
	var height = height;
	var windowprops = "toolbar=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width="+width+", height="+height+"";
	window.open(page, 'PopupName', windowprops);
}

