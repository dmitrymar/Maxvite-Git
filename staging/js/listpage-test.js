/*global jQuery, Mustache */

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
        }
    };

    var Listpage = {
        request_url: "/staging/listpage-test-query.cfm?searchkeywords=" + Searchkeywords.query,
        default_view: "grid",
        startpage: "",
        numberonpage: "",
        brand_id_list: [],
        init: function () {
            this.cacheElements();
            this.getData();
            this.bindEvents();
        },
        cacheElements: function () {
            this.$filterModule = $(".filter-module");
        },
        bindEvents: function () {
            //Toggle module slide
            this.$filterModule.on("click", ".filter-module-toggler", function () {
                $(this).toggleClass("filter-module-toggler-plus");
                $(this).closest(Listpage.$filterModule).find(".checkbox-list").slideToggle();
            });
            $(".filter-module-clear").on("click", this.resetClear); //Reset Clear for any filter module
            $("#filterSection .filter-module-brand .checkbox-list").on("click", "li", this.toggleFilters);

            //Control Pagination
            $('#listProductsWrap').on("click", ".paginator li a", function (e) {
                e.preventDefault();
            });
            $('#listProductsWrap').on("click", "ul.paginator li.paginator-active a", function () {
                Listpage.startpage = $(this).attr('href');
                Listpage.getData();

            });
        },
        getLocHash: function () {
            var hashSubstr = location.hash;
            hashSubstr = hashSubstr.substr(1);
            return hashSubstr;
        },
        toggleFilters: function () {
            var $checkbox = $(this).find(".checkbox-list-option");
            var $checkBoxVal = $checkbox.attr("value");

            if ($(this).hasClass("checkbox-list-selected")) {
                $checkbox.prop("checked", false);
                $(this).removeClass("checkbox-list-selected");
                Listpage.brand_id_list.splice(Listpage.brand_id_list.indexOf($checkBoxVal), 1); //remove brandid from brand_id_list property
            } else {
                $(this).addClass("checkbox-list-selected");
                $checkbox.prop("checked", true);
                Listpage.brand_id_list.push($checkBoxVal); //add brandid to brand_id_list property
            }
            Listpage.getData();

        },
        resetClear: function (e) {
            e.preventDefault();
            var $listItem = $(this).parent().next().find("li");
            var $checkbox = $listItem.find(".checkbox-list-option");
            var $module = $(this).closest(".filter-module").data("module");
            $listItem.removeClass("checkbox-list-selected");
            $checkbox.prop("checked", false);
            if ($module === "brand") {
                Listpage.brand_id_list.length = 0;
            }
            Listpage.getData();
        },
        renderSidebar: function () {
            if (Listpage.brand_id_list.length < 1) {
                $(".filter-module-brand .filter-module-clear").addClass("hidden");
            } else {
                $(".filter-module-brand .filter-module-clear").removeClass("hidden");
            }
        },
        renderProductTpl: function (response) {
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

                Listpage.startpage = 0;

                var jsonurl = Listpage.request_url;

                if (Listpage.brand_id_list.length > 0) {
                    jsonurl = jsonurl + "&brandfilter=" + Listpage.brand_id_list.toString();
                }

                Listpage.setLocHash();
                Listpage.getData(jsonurl);
            });





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

            Listpage.setLocHash();


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
        },
        ajaxSuccess: function (response) {
            $('.content').unblock(); //remove spinner
            Listpage.renderProductTpl(response);
            this.renderSidebar();
            $('body,html').scrollTop(0); // go all the way to the top. especially useful when using dashboard at the bottom of the page    
        },
        getData: function () {
            this.blockContent();
            var requestURL = Listpage.buildUrl();
            $.getJSON(requestURL, function (response) {
                if (response.status == 'success') {
                    Listpage.ajaxSuccess(response);
                } else {
                    $('#listProductsWrap').html('No products found');
                }
            });

        }

    };


    //Initial product load
    Listpage.init();
    /*Listpage.setSidebarFilters();*/

});