$.mockjax({
  url: 'listpage-query.cfm',
  responseTime: 750,
  responseText: {
    status: 'success',
    total_products: 4,
	first_page: true,
	last_page: false,
	product_start: 1,
	product_end: 3,
	page_list: [{page_number: 1, current_page:true}, {page_number: 2, current_page:false}],
	products_per_page: [{products: 3, selected:true}, {products: 6, selected:false}],
	products: [
	{
		product_id: 40946,
		name: 'Alive Mens Max Potency',
		form: '90 Tablets',
		image_url: 'Alive%20Mens%2D2%2Ejpg',
		product_url: '/40946/Alive-Men-s-Max-Potency/product.html',
		list_price: 28.99,
		our_price: 21.74,
		dollars_saved: 7.25,
		percent_saved: 25,
		rated: false
	},
	{
		product_id: 3833,
		name: 'Maxi Health Formula 605',
		form: '120 Capsules',
		image_url: 'Formula%20605%2D2%2Ejpg',
		product_url: '/3833/Maxi-Health-Formula-605/product.html',
		list_price: 44.95,
		our_price: 29.22,
		dollars_saved: 15.73,
		percent_saved: 35,
		rated: true
	},
	{
		product_id: 4119,
		name: 'American BioSciences HP8',
		form: '70 Capsules',
		image_url: 'abs%20hp8%5Fl%2Ejpg%2D2%2Ejpg',
		product_url: '/4119/American-BioSciences-HP8/product.html',
		list_price: 49.95,
		our_price: 37.46,
		dollars_saved: 12.49,
		percent_saved: 25,
		rated: false
	}/*,
	{
		product_id: 4202,
		name: 'Buried Treasure Mens Prostate Complete',
		form: '16 Oz',
		image_url: 'bt%20mens%5Fprostate%2Ejpg%2D2%2Ejpg',
		product_url: '/4202/Buried-Treasure-Mens-Prostate-Complete/product.html',
		list_price: 25.99,
		our_price: 19.49,
		dollars_saved: 6.50,
		percent_saved: 25,
		rated: false
	}	*/
	]
  }
});

//Get json for page 2
/*$("button").click(function(){
  $.getJSON("demo_ajax_json.js",function(result){
    $.each(result, function(i, field){
      $("div").append(field + " ");
    });
  });
});
*/

$.getJSON('listpage-query.cfm', function(response) {
    if (response.status == 'success') {

    var template = $('#listTpl').html();
    var html = Mustache.to_html(template, response);
    $('#listProductsGrid').html(html);

} else {
        $('#listProductsGrid').html('No products found');
    }
});