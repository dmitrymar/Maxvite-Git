<div class="listpage-toolbar">
<span class="listpage-toolbar-display">Items <strong>{{product_start}}</strong>&nbsp;-&nbsp;<strong>{{product_end}}</strong> of <strong>{{total_products}}</strong></span>
    
    
 <ul class="paginator">

 <li class="begin-arrow{{#unless first_page}} paginator-active{{/unless}}"><a href="0" title="First Page">First Page</a></li>
 <li class="prev-arrow{{#unless first_page}} paginator-active{{/unless}}"><a href="{{prev_page}}" title="Previous Page">Previous Page</a></li>

 <li class="current-page">{{current_page}}</li>

<li class="next-arrow{{#unless is_last_page}} paginator-active{{/unless}}"><a href="{{next_page}}" title="Next Page">Next Page</a></li>
 <li class="last-arrow{{#unless is_last_page}} paginator-active{{/unless}}"><a href="{{last_page_id}}" title="Last Page">Last Page</a></li>


 </ul>



{{#if show_per_page}}
<ul class="listpage-toolbar-numberonpage"><li>Items per page: </li><li>
<form>
          <select>
{{#each products_per_page}}
            <option value="{{products}}" {{#if selected}}selected{{/if}}>{{products}}</option>
{{/each}}
          </select>
        </form>
</li></ul>
{{/if}}



 <ul class="listpage-toolbar-view">
 <li>View: </li>
 <li class="views grid-view listpage-toolbar-view-selected" title="Grid View" data-view="grid">Grid View</li>
 <li class="views list-view" title="List View" data-view="list">List View</li>
 </ul>

<ul class="listpage-toolbar-sortby"><li>Sort by: </li><li>
<form>
          <select>
{{#each products_sort}}
            <option value="{{sort_value}}" {{#if selected}}selected{{/if}}>{{sort_title}}</option>
{{/each}}
            <!---<option value="reviews">Reviews</option>--->			
          </select>
        </form>
</li></ul>


  </div>