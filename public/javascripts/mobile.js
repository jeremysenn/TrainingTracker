//$.jQTouch({});

var jQT = new $.jQTouch({
  icon: 'jqtouch/images/logo_small.png'
});

//$(function() {
//  $('#workouts').getCalendar();
//});

$(function() {
  $('#delete-alert').bind('click', function() {
    return confirm("Delete this item?");
  });
});