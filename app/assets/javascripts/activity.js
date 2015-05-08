$(function() {
  $("#activity_start").datetimepicker({
    dayOfWeekStart: 1,
    format: 'd/m/Y H:i',
    step: 5,
    validateOnBlur: false
  });

  $("#activity_ended").datetimepicker({
    dayOfWeekStart: 1,
    format: 'd/m/Y H:i',
    step: 5,
    validateOnBlur: false
  });
});