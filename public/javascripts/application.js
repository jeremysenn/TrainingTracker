// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

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