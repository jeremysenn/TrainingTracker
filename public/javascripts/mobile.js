//$.jQTouch({});

var jQT = new $.jQTouch({
  icon: 'jqtouch/images/logo_small.png'
});

$(function() {
  $('#workout_sessions').getCalendar();
});

$(function() {
  $('#delete-alert').bind('click', function() {
    return confirm("Delete this item?");
  });
});