// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  $("ul.tabs").tabs("div.ajax_pane > div.block > div.panes > div");

  //binds to onchange event of image input field to check for size before allowing upload
  $('#myImageFile').bind('change', function() {
    //this.files[0].size gets the size of your file.
    if (this.files[0].size > 16000) {
      alert("File must be 16KB or less, this one is too large: " + this.files[0].size);
      $(this).val("");
    }
  });

  $('a[rel*=facebox]').facebox()

  $("img[rel]").overlay();

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

function remove_video_fields (link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".video").hide();
  //$(link).next(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).after(content.replace(regexp, new_id));
}

function add_video_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
}

function add_weight_set_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
}

//used in client.show
function toggle_client_info(link) {
  $(link).next('#fields').toggle();
  //$(link).text($(link).text() == 'Information' ? 'Hide Information' : 'Information');
}
function toggle_client_pictures(link) {
  $(link).next('#picture_fields').toggle();
  //$(link).text($(link).text() == 'Pictures' ? 'Hide Pictures' : 'Pictures');
}

function toggle_client_workouts(link) {
  $(link).next('#workout_fields').toggle();
  //$(link).text($(link).text() == 'Workouts' ? 'Hide Workouts' : 'Workouts');
}

function toggle_learn_more(link) {
  $(link).next('#learn_fields').toggle();
  $(link).text($(link).text() == 'Learn More' ? 'Close' : 'Learn More');
}