// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() 
    { 
      var table = $("#sorted_table")
      table.tablesorter(); 

      $("#filter").keyup(function() {
        $.uiTableFilter( table, this.value );
      })

    } 
); 

