/*global jQuery, Handlebars */

//To Do
//$input.prop doesn't work in IE8. Troubleshoot with checkbox.cfm in tests folder
// When all checkboxes are unchecked after being checked an error is thrown
// Show spinner only if json data takes more than 2 seconds

/*jslint plusplus: true, vars: true, browser: true */
//Behavior Table Of Contents:
//1. User lands on a search page or enters url with parameters
//  a. Display loading data spinner.
//  b. request url for server is set to a default.
//  c. parameter to request url is added for products per page(ppp) if local storage has previously set ppp.
//  d. if location.hash is not empty then: 
//      *add hash parameters to request url
//      *highlight brands that were specified in location hash

//Notes encapsulated entire script

jQuery(function ($) {
    'use strict';

    var Utils = {
        getLocHash: function () {
            var hashSubstr = location.hash;
            hashSubstr = hashSubstr.substr(1);
            return hashSubstr;
        },
        setLocHash: function () {
            var numberonpage = localStorage.getItem("numberonpage") !== null ? localStorage.getItem("numberonpage") : 30;
            var locationhash = "numberonpage=" + numberonpage;

            /*            if (this.startpage !== "") {
                locationhash += "&startpage=" + Listpage.startpage;
            }
            if (this.startpage === "" && this.getLocHash().indexOf("startpage=") !== -1) {
                locationhash += "&" + Listpage.extractLocHash("startpage=");
            }
            console.log("brandfilter: " + this.getLocHash().indexOf("brandfilter="));*/

            if (this.brand_id_list.length === 0 && this.getLocHash().indexOf("brandfilter=") !== -1) {
                locationhash += "&" + Listpage.extractLocHash("brandfilter=");
            }
            if (this.brand_id_list.length !== 0) {
                locationhash += "&brandfilter=" + this.brand_id_list.toString();
            }
            console.log(this.brand_id_list.length);
            location.hash = locationhash;
        },
        extractLocHash: function (hashparam) {
            var hashSubstr = this.getLocHash();
            var filterProperty = hashparam;
            var filterFirstPosition = hashSubstr.indexOf(filterProperty);
            var stringBeforeFilter = hashSubstr.slice(0, filterFirstPosition);
            stringBeforeFilter = stringBeforeFilter === "" ? hashSubstr.length : stringBeforeFilter.length;
            var hashSubstrFilter = hashSubstr.slice(filterFirstPosition, hashSubstr.length);
            if (hashSubstrFilter.indexOf("&") !== -1) {
                var filterLastPosition = hashSubstrFilter.indexOf("&");
                hashSubstrFilter = hashSubstrFilter.slice(0, filterLastPosition);
            }
            return hashSubstrFilter;
        },
        buildUrl: function () {
            //Create a script that adds checkbox to all brands inside of data-module="brand" based on values taken from brand_id_list 
            var url = Listpage.request_url;

            if (localStorage.getItem("numberonpage") !== null) {
                this.numberonpage = localStorage.getItem("numberonpage");
                url = url + "&numberonpage=" + Listpage.numberonpage;
            }


            if (this.getLocHash().indexOf("brandfilter=") !== -1 && Listpage.brand_id_list.length === 0) {
                var brandhash = this.extractLocHash("brandfilter=");
                url = url + "&" + brandhash;
                //push into brand_id_list
                var brandIDList = brandhash.slice(12, brandhash.length);
                Listpage.brand_id_list = brandIDList.split(',');

                //add class checkbox-list-selected to every li element within filter-module-brand if data-brandid matches brand_id_list
                $.each(Listpage.brand_id_list, function (index, value) {
                    var $lidatael = $("#filterSection .filter-module-brand .checkbox-list li").filter('[data-brandid=' + value + ']');
                    $lidatael.addClass("checkbox-list-selected");
                    $lidatael.find(".checkbox-list-option").prop("checked", true);
                });

            }

            if (Listpage.getLocHash().indexOf("startpage=") !== -1 && Listpage.startpage === "") {
                var startpagehash = this.extractLocHash("startpage=");
                //push into startpage
                var startpagenum = startpagehash.slice(10, startpagehash.length);
                Listpage.startpage = startpagenum;
            }
            if (Listpage.startpage !== "") {
                url = url + "&startpage=" + Listpage.startpage;
            }

            if (Listpage.brand_id_list.length > 0) {
                url = url + "&brandfilter=" + Listpage.brand_id_list.toString();
            }



            return url;
        }
    };

    var filters = (function () {

        var request_url = Searchkeywords.query,
            view = "grid",
            startpage = 0,
            numberonpage = 30,
            brand_id_list = [],
            specials_id_list = [],
            product_id_filter_list = [],
            sort = "nameaz",
            listTpl = Handlebars.compile($('#listTpl').html()),
            filterTpl = Handlebars.compile($('#filterTpl').html()),
            $filterSection = $("#filterSection"),
            $filterModule = $filterSection.find(".filter-module"),
            $listProductsWrap = $('#listProductsWrap'),
            $viewsWrap = $listProductsWrap.find(".listpage-toolbar-view"),
            $filterSlider = $("#filterPriceSlider");


        function init() {
            getData();
            bindEvents();
            render();
        }

        function insertSeparator() {
            //Insert separator lines for grid view
            $listProductsWrap.find(".items-grid").find(".items-grid-node")
                .filter(function (index) {
                return index % 3 == 2;
            })
                .after("<li class='items-grid-separator'></li>");
        }

        function bindEvents() {
            $filterSection.on("click", ".filter-module-toggler", moduleSlideToggle);
            $filterSlider.on("mousedown", ".filter-price-handle-min", slide);
            $listProductsWrap.on("submit", ".additemform", addToCart);
            $listProductsWrap.on("click", ".listpage-toolbar-view li", toggleView);
            $listProductsWrap.on("change", ".listpage-toolbar-numberonpage select", togglePerPage);
            $filterSection.on("click", ".filter-module .checkbox-list li", toggleFilters);
            $listProductsWrap.on("change", ".listpage-toolbar-sortby select", toggleSort);
            $filterSection.on("click", ".filter-module-clear", resetClear); //Reset Clear for any filter module
            $listProductsWrap.on("click", ".paginator li a", paginate);



            //Toggle Clear All using filters sessionStorage
            //Find common place to store temporary data (possible options sessionStorage, array, object, jquery data)
            /*    if (data.filters === true) {
        $(".refine-results-clearall").removeClass("hidden");
    }*/



        }

        function addToCart(e) {
            e.preventDefault();
            $(e.target).closest(".additemform").sitePlugins('additem');
        }

        function toggleSort(e) {
            var $el = $(e.target).find(":selected").val();
            sort = $el;
            getData();
        }

        function moduleSlideToggle(e) {
            $(e.target).toggleClass("filter-module-toggler-plus")
                .closest(".filter-module").find(".filter-module-main").slideToggle();
        }

        function checkView() {
            //Get display view from local storage & render page accordingly			
            if (localStorage.getItem("view") === "list") {
                setView("list");
            }
        }

        function setView(val) {
            var $view = $listProductsWrap.find(".listpage-toolbar-view li");
            $view.removeClass('listpage-toolbar-view-selected');
            $view.filter("." + val + "-view").addClass('listpage-toolbar-view-selected');
            $listProductsWrap.find(".items").removeClass("block").addClass("hidden");
            $(".items-" + val).addClass('block').removeClass('hidden');

        }

        function toggleView(e) {
            var $view = $(e.target).data("view");
            localStorage.setItem("view", $view);
            setView($view);
            $("body,html").scrollTop(100); // go all the way to the top.            
        }


        function togglePerPage(e) {
            var $el = $(e.target).find(":selected").val();
            localStorage.setItem('numberonpage', $el);
            getData();
        }

        function paginate(e) {
            e.preventDefault();
            startpage = $(e.target).attr('href');
            getData();
        }

        function resetClear(e) {
            e.preventDefault();
            var $module = $(e.target).closest(".filter-module").data("module");
            if ($module === "brand") {
                brand_id_list.length = 0;
            }
            if ($module === "specials") {
                specials_id_list.length = 0;
                product_id_filter_list.length = 0;
            }
            startpage = 0;
            getData();
        }


        function toggleFilters(e) {
            var $el = $(e.target),
                $module = $el.closest(".filter-module").data("module"),
                $li = $el.closest("li"),
                $brandID = $li.data("brandid"),
                $specialID = $li.data("specialid"),
                $productIDs = $li.data("productids");

            if ($li.hasClass("checkbox-list-selected")) {
                if ($module === "brand") {
                    brand_id_list.splice(brand_id_list.indexOf($brandID), 1); //remove brandid from brand_id_list property
                    console.log(brand_id_list);
                }
                if ($module === "specials") {
                    specials_id_list.splice(specials_id_list.indexOf($specialID), 1); //remove specials from specials_id_list property
                    product_id_filter_list.splice(product_id_filter_list.indexOf($productIDs), 1); //remove product id from product_id_filter_list property
                }

            } else {

                if ($module === "brand") {
                    brand_id_list.push($brandID); //add brandid to brand_id_list property
                }
                if ($module === "specials") {
                    specials_id_list.push($specialID); //add specials id to specials_id_list property
                    product_id_filter_list.push($productIDs); //add product id to product_id_filter_list property
                }
            }
            startpage = 0;
            getData();

        }

        function render(response) {
            var listHTML = listTpl(response);
            var filterHTML = filterTpl(response);

            $listProductsWrap.html(listHTML);
            $filterSection.html(filterHTML);
            insertSeparator();
            checkView();
        }



        function blockContent() {
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
        };

        function buildUrl() {
            //Create a script that adds checkbox to all brands inside of data-module="brand" based on values taken from brand_id_list 
            var url = request_url;

            if (localStorage.getItem("numberonpage") !== null) {
                numberonpage = localStorage.getItem("numberonpage");
                url = url + "&numberonpage=" + numberonpage;
            }
            if (startpage > 0) {
                url = url + "&startpage=" + startpage;
            }
            if (brand_id_list.length > 0) {
                url += "&brandfilter=" + brand_id_list.toString();
            }
            if (specials_id_list.length > 0) {
                url += "&specialsfilter=" + specials_id_list.toString();
            }
            if (product_id_filter_list.length > 0) {
                url += "&productidfilter=" + product_id_filter_list.toString();
            }
            url = url + "&sort=" + sort;

            return url;
        }

        function ajaxSuccess(response) {
            //remove spinner
            if (response.found_products === true) {
                render(response);
                $('body,html').scrollTop(0); // go all the way to the top. especially useful when using dashboard at the bottom of the page   
            } else {
                $('#listProductsWrap').html('No products found');
            }
        }

        function getData() {
            var requestURL = buildUrl();

            var jqxhr = $.ajax({
                dataType: "json",
                url: requestURL,
                cache: false,
                timeout: 30000,
                contentType: 'application/json',
                beforeSend: function () {
                    blockContent();
                }
            })
                .done(function (response) {
                ajaxSuccess(response);
            })
                .fail(function (jqxhr, textStatus, error) {
                var err = textStatus + ', ' + error;
                ajaxFail(err);
            })
                .always(function () {
                $('.content').unblock();
            });

            function ajaxFail(err) {
                $('#listProductsWrap').html("Request Failed: " + err);
            }

        }

        //Future code        

        function slide(e) {
            var el = e.pageX;
            alert(el);
        }

        function setSidebarFilters() {
            //Create a script that adds checkbox to all brands inside of data-module="brand" based on values taken from brand_id_list

            /*             //push into brand_id_list
             var brandIDList = brandhash.slice(12, brandhash.length);
             this.brand_id_list = brandIDList.split(',');
-            
+
+            //add class checkbox-list-selected to every li element within filter-module-brand if data-brandid matches this.brand_id_list
+            $.each(Listpage.brand_id_list, function (index, value) {
+                var $lidatael = $("#filterSection .filter-module-brand .checkbox-list li").filter('[data-brandid=' + value + ']');
+                $lidatael.addClass("checkbox-list-selected");
+                $lidatael.find(".checkbox-list-option").prop("checked", true);
+            });     */

        }

        return {
            init: init
        };

    })();

    filters.init();




});