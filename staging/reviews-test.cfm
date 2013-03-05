<!DOCTYPE html>
<html>
<title>Untitled Document</title>
<script type="text/javascript">
var pr_style_sheet="http://cdn.powerreviews.com/aux/14165/636016/css/express.css";
</script>
<script type="text/javascript" src="http://cdn.powerreviews.com/repos/14165/pr/pwr/engine/js/full.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

</head>
<body>

<div id="sampleArea"></div>

<script src="/js/mustache.js"></script>  
<script id="listTpl" type="text/template">
<h1>{{product_name}}</h1>ID: {{product_id}}

            <div class="pr_snippet_category">
              {{{rating}}}
            </div>



</script>

<script>
//****** jQuery - Execute scripts after DOM is loaded
$(document).ready(function(){
						   
var product = {
    product_id: 3833,
	product_name: "ABC",
	rating: function() {		var pr_snippet_min_reviews=1;POWERREVIEWS.display.snippet(document, { pr_page_id : "3833" });	}
};


$.getJSON("testjson.cfm", function(data) {

var template = $('#listTpl').html();
var html = Mustache.to_html(template, data);
$('#sampleArea').html(html);


});


});//end jQuery execute after DOM loaded
</script>
</body>
</html>