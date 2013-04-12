//To Do
//$input.prop doesn't work in IE8. Troubleshoot with checkbox.cfm in tests folder
// When all checkboxes are unchecked after being checked an error is thrown

//****** jQuery - Execute scripts after DOM is loaded
$(document).ready(function() {

//create an array of checked brands and append it to jsonurl
var checkedBrandsArray = new Array();


		$('.filter-option').change(function(){
			var $input = $(this);
			$attrValue = $input.attr('value');	
			
			if ($input.prop('checked')) {
				checkedBrandsArray.push($attrValue);
			} else {
				checkedBrandsArray.splice(checkedBrandsArray.indexOf($attrValue), 1);
			}
			
			var jsonurl = Listpage.default_json + "&brandfilter=" + checkedBrandsArray.toString();
			getData(jsonurl);

		});


		
/*	var goToPage = function() {
		$('.pagination li a').click(function(e) {
			e.preventDefault();

			var jsonurl = "listpage-query.cfm?page=" + $(this).attr('href'); 

			$.getJSON(jsonurl, function(response) {

				renderProductTpl(response);

			});
		});


function filterPage() {

			$('.filter-option').click(function() {
				var jsonurl = "listpage-query.cfm?brandid=" + $(this).attr('value');
				alert(jsonurl);
			});

		}


		$('.pagination li a').click(function(e) {
			e.preventDefault();

			var jsonurl = "listpage-query.cfm?page=" + $(this).attr('href'); 

			$.getJSON(jsonurl, function(response) {

				renderProductTpl(response);

			});
		});
	}*/



	var renderProductTpl = function(response) {
		var template = $('#listTpl').html();
		var html = Mustache.to_html(template, response);
		$('#listProductsGrid').html(html);

		// this forces rating to display on its own. need to figure out how to stick it into pr_snippet_min_reviews
		/*var str="
		<script>POWERREVIEWS.display.snippet(document, {pr_page_id: '3833',pr_snippet_min_reviews: 1});</script>
		";$('.pr_snippet_category').append(str);*/
		
		//Add item
		$(".additemform").submit(function(event) {
			event.preventDefault();
			$(this).sitePlugins('additem');
		});

		//Per Page toggle
		$('.pageSortSize li a').click(function(event) {
			event.preventDefault();
			var jsonurl = Listpage.default_json + "&numberonpage=" + $(this).attr('href');
			getData(jsonurl);
		});

		//Control Pagination
		$('.paginator a').click(function(event) {event.preventDefault();});
		$('.paginator .paginator-active a').click(function() {
			var jsonurl = Listpage.default_json + "&startpage=" + $(this).attr('href');
			getData(jsonurl);
		});

		goToPage();

	}

/*	var renderFilterTpl = function(response) {




	}*/

	var getData = function(jsonurl) {
$('#listProductsGrid').html(globals.spinner);
		$.getJSON(jsonurl, function(response) {



			if (response.status == 'success') {

				renderProductTpl(response);
				/*renderFilterTpl(response);*/

			} else {
				$('#listProductsGrid').html('No products found');
			}
		});

	}

	var initListpage = function() {
		getData(Listpage.default_json);

	};

	initListpage();






}); //end jQuery execute after DOM loaded