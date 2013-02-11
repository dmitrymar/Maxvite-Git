$.mockjax({
  url: 'listpage-query.cfm',
  responseTime: 750,
  responseText: {
    status: 'success',
    total_products: 87,
	current_page: 1,
	per_page: {
		thirty_per_page: [
	{
		start: '1',
		end: '30'
	},
	{
		start: '31',
		end: '60'
	},
	{
		start: '61',
		end: '87'
	}	
	],
		sixty_per_page: [
	{
		start: '1',
		end: '60'
	},
	{
		start: '61',
		end: '87'
	}	
	],
		ninty_per_page: [
	{
		start: '1',
		end: '87'
	}	
	]
	},
	products: [
	{
		name: 'product a'
	},
	{
		name: 'product b'
	}	
	]
  }
});

$.getJSON('listpage-query.cfm', function(response) {
    if (response.status == 'success') {

    var template = $('#listTpl').html();
    var html = Mustache.to_html(template, response);
    $('#listProductsGrid').html(html);

} else {
        $('#listProductsGrid').html('No products found');
    }
});