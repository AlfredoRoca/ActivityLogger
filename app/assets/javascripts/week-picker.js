var setupWeekPicker = function () {
  $('#datetimepicker_week').datetimepicker({
    format: "D/M/YYYY",
    calendarWeeks: true,
    showTodayButton: true,
    showClear: true,
    showClose: true,
    useCurrent: false,
    locale: 'es'
  });

  $("#datetimepicker_week").on("dp.change", function (e) {
    var picked = e.date;
      $('#week').val(picked.week());
      $('#start').val(picked.format('L'));
      $('#ended').val(picked.add(6, 'd').format('L'));
      console.log("start", $('#start').val(),"ended", $('#ended').val(), "week", $('#week').val());
  });

}

$(document).ready(setupWeekPicker);
$(document).on('page:load', setupWeekPicker);