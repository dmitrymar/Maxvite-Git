//To Do
//$input.prop doesn't work in IE8. Troubleshoot with checkbox.cfm in tests folder
// When all checkboxes are unchecked after being checked an error is thrown
// Show spinner only if json data takes more than 2 seconds

/*jslint plusplus: true, vars: true, browser: true */

//****** jQuery - Execute scripts after DOM is loaded
$(document).ready(function () {

    function blockListData() {
        $('.content').block({
            message: '<img src="/img/spinner78x78.gif">',
            overlayCSS: {
                backgroundColor: '#fff'
            },
            centerY: 0,
            css: {
                width: '88px',
                border: '1px solid #ddd',
                top: '300px'
            }
        });
    }


    //Toggle module slide
    $(".filter-module-toggler").on("click", function () {
        $(this).toggleClass("filter-module-toggler-plus");
        $(".checkbox-list").slideToggle();
    });


    //Toggle filters
    //create an array of checked brands and append it to jsonurl
    var checkedBrandsArray = [];
    $("#filterSection .filter-module .checkbox-list li").on("click", function () {
        
        var $checkbox = $(this).find(".checkbox-list-option");
        var $checkBoxVal = $checkbox.attr("value");
        var $clearLink = $(this).parent().prev().find(".filter-module-clear");
        var jsonurl = Listpage.default_json;

        if ($(this).hasClass("checkbox-list-selected")) {
            $checkbox.prop("checked", false);
            $(this).removeClass("checkbox-list-selected");
            checkedBrandsArray.splice(checkedBrandsArray.indexOf($checkBoxVal), 1);

            if($(this).siblings().filter(".checkbox-list-selected").length > 0) {
                jsonurl = jsonurl + "&brandfilter=" + checkedBrandsArray.toString();
            } else {
                $clearLink.addClass("hidden");
            }
            
        } else {
            $(this).addClass("checkbox-list-selected");
            $checkbox.prop("checked", true);
            checkedBrandsArray.push($checkBoxVal);            
            jsonurl = jsonurl + "&brandfilter=" + checkedBrandsArray.toString();
            console.log(jsonurl);
            $clearLink.removeClass("hidden"); 
        }
                
        getData(jsonurl);
        
    });
    
    
    //Reset Clear for any filter module
    $(".filter-module-clear").on("click", function(event) {
        event.preventDefault();
        $(this).addClass("hidden");
        var $listItem = $(this).parent().next().find("li");
        var $checkbox = $listItem.find(".checkbox-list-option");
        $listItem.removeClass("checkbox-list-selected");
        $checkbox.prop("checked", false);
        checkedBrandsArray = []; // Clear all parameters for this filter
        getData(Listpage.default_json);
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

			$('.checkbox-list-option').click(function() {
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



    var renderProductTpl = function (response) {
        var template = $('#listTpl').html();
        var html = Mustache.to_html(template, response);
        $('#listProductsWrap').html(html);

        // this forces rating to display on its own. need to figure out how to stick it into pr_snippet_min_reviews
        /*var str="
		<script>POWERREVIEWS.display.snippet(document, {pr_page_id: '3833',pr_snippet_min_reviews: 1});</script>
		";$('.pr_snippet_category').append(str);*/

        //Get display view from local storage & render page accordingly			
        if (localStorage.getItem("view") === "list") {
            $('.items-list').addClass('block').removeClass('hidden');
            $('.items-grid').addClass('hidden').removeClass('block');
            $(".list-view").addClass("list-view-selected");
            $(".grid-view").removeClass("grid-view-selected");
        }

        //Add item
        $(".additemform").submit(function (event) {
            event.preventDefault();
            $(this).sitePlugins('additem');
        });


        //Toggle Grid or List View
        $(".listpage-toolbar-view li a").on("click", function (event) {
            event.preventDefault();

            $parent = $(this).parent();
            if (!$parent.is('.grid-view-selected, .list-view-selected')) {

                if ($(this).attr('href') === 'grid') {
                    $parent.addClass('grid-view-selected');
                    $(".list-view").removeClass("list-view-selected");
                    $('.items-grid').addClass('block').removeClass('hidden');
                    $('.items-list').addClass('hidden').removeClass('block');
                    localStorage.setItem('view', 'grid');
                } else {
                    $parent.addClass('list-view-selected');
                    $(".grid-view").removeClass("grid-view-selected");
                    $('.items-list').addClass('block').removeClass('hidden');
                    $('.items-grid').addClass('hidden').removeClass('block');
                    localStorage.setItem('view', 'list');
                }
            }

        });
        

    //Toggle Clear All using filters sessionStorage
    //Find common place to store temporary data (possible options sessionStorage, array, object, jquery data)
/*    if (data.filters === true) {
        $(".refine-results-clearall").removeClass("hidden");
    }*/        


        
        
        
        //Per Page toggle
        $(".listpage-toolbar-numberonpage select").change(function () {
            
            $(this).find(":selected").each(function () {
                localStorage.setItem('numberonpage', $(this).val());
            });
            
            var jsonurl = Listpage.default_json;
            
            if (checkedBrandsArray.length > 0) {
                jsonurl = jsonurl + "&brandfilter=" + checkedBrandsArray.toString();
            }
            
            getData(jsonurl);
        });

        //Control Pagination
        $('.paginator a').click(function (event) {
            event.preventDefault();
        });
        $('.paginator .paginator-active a').click(function () {
            var jsonurl = Listpage.default_json + "&startpage=" + $(this).attr('href');
            getData(jsonurl);
        });

        /*goToPage();*/

    };


//Populate listProductsWrap div with products 
    var getData = function (jsonurl) {

        blockListData(); //show spinner
        
        var url = jsonurl;
            
        if (localStorage.getItem("numberonpage") !== null) {
            var numberonpage = localStorage.getItem("numberonpage");
            url = url + "&numberonpage=" + numberonpage;
        }        
        
        $.getJSON(url, function (response) {



            if (response.status == 'success') {
                $('.content').unblock(); //remove spinner
                renderProductTpl(response);
                /*renderFilterTpl(response);*/

            } else {
                $('#listProductsWrap').html('No products found');
            }
        });

    };

//Initial product load
    getData(Listpage.default_json);


}); //end jQuery execute after DOM loaded