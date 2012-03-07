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

function toggleStatus(r) {
  var new_inputs = $("#existing_workout_" + r).closest("form").find('#new_' + r).children("input");
  var old_inputs = $("#existing_workout_" + r).closest("form").find('#old_' + r).children("input,select")

  if ($("#existing_workout_" + r).is(':checked')) {
    new_inputs.attr('disabled', true);
    old_inputs.removeAttr('disabled');
  } else {
      old_inputs.attr('disabled', true);
      new_inputs.removeAttr('disabled');
  }
}