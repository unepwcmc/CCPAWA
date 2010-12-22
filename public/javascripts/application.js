// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() 
  { 
    var table = $("#sorted_table")
    table.tablesorter({widgets: ['zebra']}); 

    $("#filter").keyup(function() {
      $.uiTableFilter( table, this.value );
    })


    $('#document_tree').jstree({ 
      // the list of plugins to include
      "plugins" : [ "themes", "json_data"],

      "theme": "apple",

      "json_data" : { 
        "ajax" : {
          // the URL to fetch the data
          "url" : "/docs.js",
          // this function is executed in the instance's scope (this refers to the tree instance)
          // the parameter is the node being loaded (may be -1, 0, or undefined when loading the root nodes)
          "data" : function (n) { 
            // the result is fed to the AJAX request `data` option
            return { 
              "id" : n.attr ? n.attr("id") : 1 
            }; 
          }
        }
      }
    });

  } 
); 

