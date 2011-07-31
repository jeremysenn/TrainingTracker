// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  $('a[rel*=facebox]').facebox()

  $(".notmonth").click(function() {
    //var me = $(this).children("a").attr("href");
    //alert(me);
    //window.location = index.php;
  });

  $('#delete-alert').click(function() {
    return confirm("Delete this item?");
  });


  if ($('.date-pick').length > 0) {
    $('.date-pick').datepicker();
  }

$(".tool-tip").each(function() {
    if ($(this).attr('title') != '') {
      $(this).tooltip({
        tip:'.tool_tip',
        position:'center right',
        offset:[28, 3],
        showURL: false
      });
    }
  });
});

function remove_exercise_fields (link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".exercise_box").hide();
  //$(link).next(".fields").hide();
}

function remove_weight_set_fields (link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".weight_set").hide();
  //$(link).next(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).after(content.replace(regexp, new_id));
}

function add_weight_set_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
}

//used in client.show
function toggle_client_info(link) {
  $(link).next('#fields').toggle();
  $(link).text($(link).text() == 'Client Information' ? 'Hide Client Information' : 'Client Information');
}
function toggle_client_pictures(link) {
  $(link).next('#picture_fields').toggle();
  $(link).text($(link).text() == 'Client Pictures' ? 'Hide Client Pictures' : 'Client Pictures');
}

function toggle_biosig_graphs(link) {
  $(link).next('#graph_fields').toggle();
  $(link).text($(link).text() == 'Biosignature Graphs' ? 'Hide Biosignature Graphs' : 'Biosignature Graphs');
}