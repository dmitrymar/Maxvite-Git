//To Do
//when you click on each page - display spinner before data displays
//add brands to json like gap added style http://www.gap.com/browse/search.do?searchText=men#department=75


//****** jQuery - Execute scripts after DOM is loaded
$(document).ready(function(){
		   
$.mockjax({
  url: 'listpage-query.cfm?page=1',
  responseTime: 750,
/*  response: function(settings) {
    this.responseText = { say: 'random ' + Math.random() };
  },*/
  responseText: {
    status: 'success',
    filters: [
        {
          filter_name: "Brand",
          filter_list: [
              {
                "fiter_option_id": 4,
                "fiter_option_name": "Natures Way"
              },
              {
                "fiter_option_id": 1,
                "fiter_option_name": "Maxi Health"
              },
              {
                "fiter_option_id": 97,
                "fiter_option_name": "American BioSciences"
              }
            ]
    }],
    total_products: 4,
	first_page: true,
	last_page: false,
	product_start: 1,
	product_end: 3,
	page_list: [{page_number: 1, current_page:true}, {page_number: 2, current_page:false}, {page_number: 3, current_page:false}],
	products_per_page: [{products: 3, selected:true}, {products: 6, selected:false}],
	products: [
	{
		product_id: 40946,
		name: 'Alive Mens Max Potency',
		brand_id: 4,
		form: '90 Tablets',
		image_url: 'Alive%20Mens%2D2%2Ejpg',
		product_url: '/40946/Alive-Men-s-Max-Potency/product.html',
		list_price: 28.99,
		our_price: 21.74,
		dollars_saved: 7.25,
		percent_saved: 25,
		rating: false
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
		rating: 'test'
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
		rating: false
	}
	]
  }
});

$.mockjax({
  url: 'listpage-query.cfm?brandid=4',
  responseTime: 750,
  responseText: {
    status: 'success',
    filters: [
        {
          filter_name: "Brand",
          filter_list: [
              {
                "fiter_option_id": 4,
                "fiter_option_name": "Natures Way"
              },
              {
                "fiter_option_id": 1,
                "fiter_option_name": "Maxi Health"
              },
              {
                "fiter_option_id": 97,
                "fiter_option_name": "American BioSciences"
              }
            ]
    }],
    total_products: 1,
	first_page: true,
	last_page: true,
	product_start: 1,
	product_end: 1,
	page_list: [{page_number: 1, current_page:true}],
	products_per_page: [{products: 3, selected:true}, {products: 6, selected:false}],
	products: [
	{
		product_id: 40946,
		name: 'Alive Mens Max Potency',
		brand_id: 4,
		form: '90 Tablets',
		image_url: 'Alive%20Mens%2D2%2Ejpg',
		product_url: '/40946/Alive-Men-s-Max-Potency/product.html',
		list_price: 28.99,
		our_price: 21.74,
		dollars_saved: 7.25,
		percent_saved: 25,
		rated: false
	}
	]
  }
});

$.mockjax({
  url: 'listpage-query.cfm?page=2',
  responseTime: 750,
  responseText: {
    status: 'success',
    total_products: 4,
	first_page: false,
	last_page: false,
	product_start: 1,
	product_end: 3,
	page_list: [{page_number: 1, current_page:false}, {page_number: 2, current_page:true}, {page_number: 3, current_page:false}],
	products_per_page: [{products: 3, selected:true}, {products: 6, selected:false}],
	products: [
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
	},
	{
		product_id: 4268,
		name: 'Dynamic Health Noni For Men Vitality Formula',
		form: '32 Oz (946 ml)',
		image_url: 'Noni%20For%20Men%20Vitality%20Formula.jpg-2.jpg',
		product_url: '/3833/Maxi-Health-Formula-605/product.html',
		list_price: 26.99,
		our_price: 20.24,
		dollars_saved: 6.75,
		percent_saved: 25,
		rated: false
	},
	{
		product_id: 4119,
		name: 'Futurebiotics Hair Skin And Nails For Men',
		form: '75 Tablets',
		image_url: 'Futurebiotics%20Hair%20Skin%20And%20Nails%20For%20Men.jpg-2.jpg',
		product_url: '/4119/American-BioSciences-HP8/product.html',
		list_price: 11.99,
		our_price: 8.99,
		dollars_saved: 3.00,
		percent_saved: 25,
		rated: false
	}
	]
  }
});

$.mockjax({
  url: 'listpage-query.cfm?page=3',
  responseTime: 750,
  responseText: {
    status: 'success',
    total_products: 4,
	first_page: false,
	last_page: true,
	product_start: 1,
	product_end: 3,
	page_list: [{page_number: 1, current_page:false}, {page_number: 2, current_page:false}, {page_number: 3, current_page:true}],
	products_per_page: [{products: 3, selected:true}, {products: 6, selected:false}],
	products: [
	{
		product_id: 4465,
		name: 'Futurebiotics Male Power',
		form: '120 Tablets',
		image_url: 'Futurebiotics%20Male%20Power.jpg-2.jpg',
		product_url: '/4202/Buried-Treasure-Mens-Prostate-Complete/product.html',
		list_price: 25.99,
		our_price: 19.49,
		dollars_saved: 6.50,
		percent_saved: 25,
		rated: false
	},
	{
		product_id: 4268,
		name: 'Futurebiotics Prostabs Plus',
		form: '90 Tablets',
		image_url: 'Futurebiotics%20Prostabs%20Plus.jpg-2.jpg',
		product_url: '/3833/Maxi-Health-Formula-605/product.html',
		list_price: 26.99,
		our_price: 20.24,
		dollars_saved: 6.75,
		percent_saved: 25,
		rated: false
	},
	{
		product_id: 4119,
		name: 'Futurebiotics ProstAdvance',
		form: '90 Capsules',
		image_url: 'Futurebiotics%20ProstAdvance.jpg-2.jpg',
		product_url: '/4119/American-BioSciences-HP8/product.html',
		list_price: 11.99,
		our_price: 8.99,
		dollars_saved: 3.00,
		percent_saved: 25,
		rated: false
	}
	]
  }
});

/*$('#test').click(function(){

	var jsonurl = "listpage-query.cfm?brandid=" + $(this).attr('value');
alert(jsonurl);

});*/

var Listpage = {
default_json: "listpage-query.cfm?page=1",
showRating: 5
}

var goToPage = function() {
$('.pagination li a').click(function(e){
	e.preventDefault();

	var jsonurl = "listpage-query.cfm?page=" + $(this).attr('href');
/*alert(jsonurl);*/

  $.getJSON(jsonurl, function(response){

renderProductTpl(response);

  });
		//alert($(this).attr('class'));
});

function filterPage() {

$('.filter-option').click(function () {
    	var jsonurl = "listpage-query.cfm?brandid=" + $(this).attr('value');
alert(jsonurl);
});

}


$('.pagination li a').click(function(e){
	e.preventDefault();

	var jsonurl = "listpage-query.cfm?page=" + $(this).attr('href');
/*alert(jsonurl);*/

  $.getJSON(jsonurl, function(response){

renderProductTpl(response);

  });
		//alert($(this).attr('class'));
});
}



var renderProductTpl = function(response) {
    var template = $('#listTpl').html();
	var partials = {rating: "need to fix rating"};
    var html = Mustache.to_html(template, response, partials);
    $('#listProductsGrid').html(html);
	
	// this forces rating to display on its own. need to figure out how to stick it into pr_snippet_min_reviews
	/*var str="<script>POWERREVIEWS.display.snippet(document, {pr_page_id: '3833',pr_snippet_min_reviews: 1});</script>";$('.pr_snippet_category').append(str);*/
	
goToPage();

}

var renderFilterTpl = function(response) {

	var filterTpl = $('#filterTpl').html();
    var filterHtml = Mustache.to_html(filterTpl, response);
    $('#filterWrpr').html(filterHtml);

$('.filter-option').change(function(){

if ($(this).is(':checked')) {
  var jsonurl = "listpage-query.cfm?brandid=" + $(this).attr('value');
} else {
  var jsonurl = Listpage.default_json;
}    

  $.getJSON(jsonurl, function(response){
renderProductTpl(response);
  });

});


}

var getData = function(jsonurl) {

$.getJSON(jsonurl, function(response) {
    if (response.status == 'success') {

renderProductTpl(response);
renderFilterTpl(response);

} else {
        $('#listProductsGrid').html('No products found');
    }
});
	
}

var initListpage = function() {
getData(Listpage.default_json);
	
};

initListpage();



		   
});//end jQuery execute after DOM loaded

