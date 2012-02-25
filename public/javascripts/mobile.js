//$.jQTouch({});

var jQT = new $.jQTouch({
  icon: 'jqtouch/images/logo_small.png'
});

$(function() {
  $('#workout_calendar').getCalendar(); //This is the important bit
});

$(function() {
  $('#delete-alert').bind('click', function() {
    return confirm("Delete this item?");
  });
});