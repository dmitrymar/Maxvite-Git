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

    var Listpage = {
        request_url: "/staging/listpage-test-query.cfm?searchkeywords=" + Searchkeywords.query,
        view: "grid",
        startpage: 0,
        numberonpage: 30,
        brand_id_list: [],
        specials_id_list: [],
        product_id_filter_list: [],
        sort: "nameaz",
        init: function () {
            this.cacheElements();
            this.getData();
            this.bindEvents();
            this.render();
        },
        cacheElements: function () {
            this.listTpl = Handlebars.compile($('#listTpl').html());
            this.filterTpl = Handlebars.compile($('#filterTpl').html());
            this.$filterSection = $("#filterSection");
            this.$filterModule = this.$filterSection.find(".filter-module");
            this.$listProductsWrap = $('#listProductsWrap');
            this.$viewsWrap = this.$listProductsWrap.find(".listpage-toolbar-view");
            this.$filterSlider = $("#filterPriceSlider");
        },
        bindEvents: function () {
            this.$filterSection.on("click", ".filter-module-toggler", this.moduleSlideToggle);
            this.$filterSection.on("click", ".filter-module-clear", this.resetClear); //Reset Clear for any filter module
            this.$filterSection.on("click", ".filter-module .checkbox-list li", this.toggleFilters);
            this.$filterSlider.on("mousedown", ".filter-price-handle-min", this.slide)
                .on("mouseUp", ".filter-price-handle-max", this.slide)
            this.$listProductsWrap.on("click", ".paginator li a", this.paginate);
            this.$listProductsWrap.on("submit", ".additemform", this.addToCart);
            this.$listProductsWrap.on("click", ".listpage-toolbar-view li", this.toggleView);
            this.$listProductsWrap.on("change", ".listpage-toolbar-numberonpage select", this.togglePerPage);
            this.$listProductsWrap.on("change", ".listpage-toolbar-sortby select", this.toggleSort);


            //Toggle Clear All using filters sessionStorage
            //Find common place to store temporary data (possible options sessionStorage, array, object, jquery data)
            /*    if (data.filters === true) {
        $(".refine-results-clearall").removeClass("hidden");
    }*/



        },
        slide: function (e) {
            var el = e.pageX;
            alert(el);
        },
        toggleSort: function (e) {
            var $el = $(e.target).find(":selected").val();
            Listpage.sort = $el;
            Listpage.getData();
        },
        togglePerPage: function (e) {
            var $el = $(e.target).find(":selected").val();
            localStorage.setItem('numberonpage', $el);
            Listpage.getData();
        },
        addToCart: function (e) {
            e.preventDefault();
            $(e.target).closest(".additemform").sitePlugins('additem');
        },
        checkView: function () {
            //Get display view from local storage & render page accordingly			
            if (localStorage.getItem("view") === "list") {
                Listpage.setView("list");
            }
        },
        setView: function (val) {
            var $view = Listpage.$listProductsWrap.find(".listpage-toolbar-view li");
            $view.removeClass('listpage-toolbar-view-selected');
            $view.filter("." + val + "-view").addClass('listpage-toolbar-view-selected');
            Listpage.$listProductsWrap.find(".items").removeClass("block").addClass("hidden");
            $(".items-" + val).addClass('block').removeClass('hidden');

        },
        toggleView: function (e) {
            var $view = $(e.target).data("view");
            localStorage.setItem("view", $view);
            Listpage.setView($view);
            $("body,html").scrollTop(100); // go all the way to the top.            
        },
        paginate: function (e) {
            e.preventDefault();
            Listpage.startpage = $(e.target).attr('href');
            Listpage.getData();
        },
        moduleSlideToggle: function (e) {
            $(e.target).toggleClass("filter-module-toggler-plus")
                .closest(".filter-module").find(".filter-module-main").slideToggle();
        },
        toggleFilters: function () {
            var $checkbox = $(this).find(".checkbox-list-option");
            var $module = $checkbox.closest(".filter-module").data("module");
            var $checkBoxVal = $checkbox.attr("value");
            var $productIDs = $(this).data("productids");

            if ($(this).hasClass("checkbox-list-selected")) {
                if ($module === "brand") {
                    Listpage.brand_id_list.splice(Listpage.brand_id_list.indexOf($checkBoxVal), 1); //remove brandid from brand_id_list property
                }
                if ($module === "specials") {
                    Listpage.specials_id_list.splice(Listpage.specials_id_list.indexOf($checkBoxVal), 1); //remove specials from specials_id_list property
                    Listpage.product_id_filter_list.splice(Listpage.product_id_filter_list.indexOf($productIDs), 1); //remove product id from product_id_filter_list property
                }

            } else {

                if ($module === "brand") {
                    Listpage.brand_id_list.push($checkBoxVal); //add brandid to brand_id_list property
                }
                if ($module === "specials") {
                    Listpage.specials_id_list.push($checkBoxVal); //add specials id to specials_id_list property
                    Listpage.product_id_filter_list.push($productIDs); //add product id to product_id_filter_list property

                }
            }
            Listpage.startpage = 0;
            Listpage.getData();

        },
        resetClear: function (e) {
            e.preventDefault();
            var $module = $(this).closest(".filter-module").data("module");
            if ($module === "brand") {
                Listpage.brand_id_list.length = 0;
            }
            if ($module === "specials") {
                Listpage.specials_id_list.length = 0;
                Listpage.product_id_filter_list.length = 0;
            }
            Listpage.startpage = 0;
            Listpage.getData();
        },
        render: function (response) {
            var listHTML = Listpage.listTpl(response);
            var filterHTML = Listpage.filterTpl(response);

            Listpage.$listProductsWrap.html(listHTML);
            Listpage.$filterSection.html(filterHTML);
            Listpage.insertSeparator();
            Listpage.checkView();
        },
        insertSeparator: function () {
            //Insert separator lines for grid view
            Listpage.$listProductsWrap.find(".items-grid").find(".items-grid-node")
                .filter(function (index) {
                return index % 3 == 2;
            })
                .after("<li class='items-grid-separator'></li>");
        },
        setSidebarFilters: function () {
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

        },
        //Block list data and show spinner
        blockContent: function () {
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
        },
        buildUrl: function () {
            //Create a script that adds checkbox to all brands inside of data-module="brand" based on values taken from brand_id_list 
            var url = Listpage.request_url;

            if (localStorage.getItem("numberonpage") !== null) {
                Listpage.numberonpage = localStorage.getItem("numberonpage");
                url = url + "&numberonpage=" + Listpage.numberonpage;
            }
            if (Listpage.startpage > 0) {
                url = url + "&startpage=" + Listpage.startpage;
            }
            if (Listpage.brand_id_list.length > 0) {
                url += "&brandfilter=" + Listpage.brand_id_list.toString();
            }
            if (Listpage.specials_id_list.length > 0) {
                url += "&specialsfilter=" + Listpage.specials_id_list.toString();
            }
            if (Listpage.product_id_filter_list.length > 0) {
                url += "&productidfilter=" + Listpage.product_id_filter_list.toString();
            }
            url = url + "&sort=" + Listpage.sort;

            return url;
        },
        ajaxSuccess: function (response) {
            //remove spinner
            if (response.found_products === true) {
                Listpage.render(response);
                $('body,html').scrollTop(0); // go all the way to the top. especially useful when using dashboard at the bottom of the page   
            } else {
                $('#listProductsWrap').html('No products found');
            }
        },
        getData: function () {            
            var requestURL = Listpage.buildUrl();

            var jqxhr = $.ajax({
                dataType: "json",
                url: requestURL,
                cache: false,
                timeout: 10000,
                beforeSend: function () {
                    Listpage.blockContent();
                }
            })
                .done(function (response) {
                Listpage.ajaxSuccess(response);
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

    };


    //Initial product load
    Listpage.init();
    /*Listpage.setSidebarFilters();*/

});