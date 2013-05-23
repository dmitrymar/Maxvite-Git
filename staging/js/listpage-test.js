//To Do
//$input.prop doesn't work in IE8. Troubleshoot with checkbox.cfm in tests folder
// When all checkboxes are unchecked after being checked an error is thrown
// Show spinner only if json data takes more than 2 seconds

/*jslint plusplus: true, vars: true, browser: true */
//Behavior Table Of Contents:
//1. User lands on a search page or enters url with parameters
//  a. Display loading data spinner.
//  b. request url for server is set to a default.
//  c. paremeter to request url is added for products per page(ppp) if local storage has previously set ppp.
//  d. if location.hash is not empty then: 
//      *add hash parameters to request url
//      *highlight brands that were specified in location hash


var Listpage = {
    default_json: "/staging/listpage-test-query.cfm?searchkeywords=" + Searchkeywords.query,
    default_view: "grid",
    startpage: 0,
    brand_id_list: [],
    getLocHash: function () {
        var hashSubstr = location.hash;
        hashSubstr = hashSubstr.substr(1);
        return hashSubstr;
    },
    setLocHash: function (hashsubstring) {

/*            if (this.getLocHash().indexOf("&") !== -1) {
                //find and replace brandfilter=1,129 with brandfilter=5  
                location.hash = this.getLocHash() + hashsubstring;
            } else {                
                var mystring = hashsubstring.slice(0, 5);
                if (this.getLocHash().indexOf(mystring) === 0 || this.getLocHash() === "") {
                location.hash = hashsubstring;
                }
            }*/
    var locationhash = "startpage=" + this.startpage;
    locationhash = this.brand_id_list.length !== -1 ? locationhash + "&brandfilter=" + this.brand_id_list.toString() : locationhash;
    location.hash = locationhash;
/*        if (hashparam === "startpage") {
            if (this.getLocHash().indexOf("&") !== -1) {
                //find and replace brandfilter=1,129 with brandfilter=5  
                location.hash = this.getLocHash() + "startpage=" + this.startpage;
            } else {
                location.hash = "startpage=" + this.startpage;
            }
        }*/

    },
    checkLocHash: function (hashparam) {
        var hashSubstr = this.getLocHash();

        if (hashparam === "brand") {

            var brandfilterProperty = "brandfilter=";
            var brandfilterFirstPosition = hashSubstr.indexOf(brandfilterProperty);
            var stringBeforeBrand = hashSubstr.slice(0, brandfilterFirstPosition);
            stringBeforeBrand = stringBeforeBrand === "" ? hashSubstr.length : stringBeforeBrand.length;
            var hashSubstrBrand = hashSubstr.slice(brandfilterFirstPosition, hashSubstr.length);
            if (hashSubstrBrand.indexOf("&") !== -1) {

                var brandfilterLastPosition = hashSubstrBrand.indexOf("&");

                hashSubstrBrand = hashSubstrBrand.slice(0, brandfilterLastPosition);

            }
            return hashSubstrBrand;
        }
        if (hashparam === "startpage") {

            var pageProperty = "startpage=";
            var brandfilterFirstPosition = hashSubstr.indexOf(brandfilterProperty);
            var stringBeforeBrand = hashSubstr.slice(0, brandfilterFirstPosition);
            stringBeforeBrand = stringBeforeBrand === "" ? hashSubstr.length : stringBeforeBrand.length;
            var hashSubstrBrand = hashSubstr.slice(brandfilterFirstPosition, hashSubstr.length);
            if (hashSubstrBrand.indexOf("&") !== -1) {

                var brandfilterLastPosition = hashSubstrBrand.indexOf("&");

                hashSubstrBrand = hashSubstrBrand.slice(0, brandfilterLastPosition);

            }
            return hashSubstrBrand;
        }        
    },
    setSidebarFilters: function () {
        if (this.getLocHash() !== "") {
            var hashSubstr = this.getLocHash();
            var brandfilterProperty = "brandfilter=";
            var brandfilterFirstPosition = hashSubstr.indexOf(brandfilterProperty) + brandfilterProperty.length;
            var hashSubstrBrand = hashSubstr.slice(brandfilterFirstPosition, hashSubstr.length);
            var brandfilterLastPosition = hashSubstrBrand.indexOf("&") === -1 ? hashSubstr.length : hashSubstrBrand.indexOf("&");
            hashSubstrBrand = hashSubstrBrand.slice(0, brandfilterLastPosition);
            this.brand_id_list = hashSubstrBrand.split(',');
            console.log(hashSubstrBrand);
            //Create a script that adds checkbox to all brands inside of data-module="brand" based on values taken from brand_id_list 



        }
    }
};


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
$("#filterSection .filter-module-brand .checkbox-list").on("click", "li", function () {

    var $checkbox = $(this).find(".checkbox-list-option");
    var $checkBoxVal = $checkbox.attr("value");
    var $clearLink = $(this).parent().prev().find(".filter-module-clear");
    var jsonurl = Listpage.default_json;
    var brandhash = ""


    if ($(this).hasClass("checkbox-list-selected")) {
        $checkbox.prop("checked", false);
        $(this).removeClass("checkbox-list-selected");
        Listpage.brand_id_list.splice(Listpage.brand_id_list.indexOf($checkBoxVal), 1); //remove brandid from brand_id_list property

        if ($(this).siblings().filter(".checkbox-list-selected").length > 0) {
            brandhash = "brandfilter=" + Listpage.brand_id_list.toString();
        jsonurl = jsonurl + "&" + brandhash;
            Listpage.setLocHash(brandhash);
        } else {
            $clearLink.addClass("hidden");
            location.hash = "";
        }

    } else {
        $(this).addClass("checkbox-list-selected");
        $checkbox.prop("checked", true);
        Listpage.brand_id_list.push($checkBoxVal); //add brandid to brand_id_list property
        brandhash = "brandfilter=" + Listpage.brand_id_list.toString();
        Listpage.setLocHash(brandhash);
        jsonurl = jsonurl + "&" + brandhash;
        $clearLink.removeClass("hidden");
    }

    getData(jsonurl);

});


//Reset Clear for any filter module
$(".filter-module-clear").on("click", function (event) {
    event.preventDefault();
    $(this).addClass("hidden");
    var $listItem = $(this).parent().next().find("li");
    var $checkbox = $listItem.find(".checkbox-list-option");
    $listItem.removeClass("checkbox-list-selected");
    $checkbox.prop("checked", false);
    checkedBrandsArray = []; // Clear all parameters for this filter
    getData(Listpage.default_json);
});



var renderProductTpl = function (response) {
    var template = $('#listTpl').html();
    var html = Mustache.to_html(template, response);
    $('#listProductsWrap').html(html);

    //Get display view from local storage & render page accordingly			
    if (localStorage.getItem("view") === "list") {
        $('.items-list').addClass('block').removeClass('hidden');
        $('.items-grid').addClass('hidden').removeClass('block');
        $(".list-view").addClass("list-view-selected");
        $(".grid-view").removeClass("grid-view-selected");
    }

    //Insert separator lines for grid view
    $(".items-grid").find(".items-grid-node")
        .filter(function (index) {
        return index % 3 == 2;
    })
        .after("<li class='items-grid-separator'></li>");


    //Add item
    $(".additemform").submit(function (event) {
        event.preventDefault();
        $(this).sitePlugins('additem');
    });


    //Toggle Grid or List View
    $(".listpage-toolbar-view").on("click", ".views", function () {

        $view = $(".listpage-toolbar-view").find(".views");

        if ($(this).is(".grid-view")) {
            $view.filter(".list-view").removeClass('list-view-selected');
            $view.filter(".grid-view").addClass('grid-view-selected');
            $('.items-grid').addClass('block').removeClass('hidden');
            $('.items-list').addClass('hidden').removeClass('block');
            localStorage.setItem('view', 'grid');
        } else {
            $view.filter(".grid-view").removeClass('grid-view-selected');
            $view.filter(".list-view").addClass('list-view-selected');
            $('.items-list').addClass('block').removeClass('hidden');
            $('.items-grid').addClass('hidden').removeClass('block');
            localStorage.setItem('view', 'list');
        }
        $("body,html").scrollTop(100); // go all the way to the top.
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

        if (Listpage.brand_id_list.length > 0) {
            jsonurl = jsonurl + "&brandfilter=" + Listpage.brand_id_list.toString();
        }

        getData(jsonurl);
    });

    //Control Pagination
    $('.paginator a').click(function (event) {
        event.preventDefault();
    });
    $('.paginator .paginator-active a').click(function () {

        Listpage.startpage = $(this).attr('href');

        var pagePropVal = "startpage=" + $(this).attr('href');

        var jsonurl = Listpage.default_json + "&" + pagePropVal;

        jsonurl = Listpage.brand_id_list.length > 0 ? jsonurl + "&brandfilter=" + Listpage.brand_id_list.toString() : jsonurl;
        
        getData(jsonurl);

        Listpage.setLocHash("startpage");

    });


};


//Populate listProductsWrap div with products 
var getData = function (jsonurl) {

    blockListData(); //show spinner

    var url = jsonurl;

    if (localStorage.getItem("numberonpage") !== null) {
        var numberonpage = localStorage.getItem("numberonpage");
        url = url + "&numberonpage=" + numberonpage;
    }

    //Check if hash value exists - add parameters to url        
/*    url = location.hash !== "" ? url + "&" + Listpage.getLocHash() : url;*/

    $.getJSON(url, function (response) {



        if (response.status == 'success') {
            $('.content').unblock(); //remove spinner
            renderProductTpl(response);
            /*renderFilterTpl(response);*/

        } else {
            $('#listProductsWrap').html('No products found');
        }
    });

    $('body,html').scrollTop(0); // go all the way to the top. especially useful when using dashboard at the bottom of the page
};

//Initial product load
getData(Listpage.default_json);
/*Listpage.setSidebarFilters();*/