var setupDateTimePickers = function (start, ended) {
  $('#datetimepicker_start').datetimepicker({
    format: "D/M/YYYY HH:mm",
    defaultDate: moment(start),
    collapse: false,
    sideBySide: true,
    calendarWeeks: true,
    showTodayButton: true,
    showClear: true,
    showClose: true,
    stepping: 15,
    useCurrent: false,
    locale: 'es'
  });
  $('#datetimepicker_ended').datetimepicker({
    format: "D/M/YYYY HH:mm",
    defaultDate: moment(ended),
    collapse: false,
    sideBySide: true,
    calendarWeeks: true,
    showTodayButton: true,
    showClear: true,
    showClose: true,
    stepping: 15,
    useCurrent: false,
    locale: 'es'
  });
  // $("#datetimepicker_start").on("dp.change", function (e) {
  //     $('#datetimepicker_ended').data("DateTimePicker").minDate(e.date);
  // });
  // $("#datetimepicker_ended").on("dp.change", function (e) {
  //     $('#datetimepicker_start').data("DateTimePicker").maxDate(e.date);
  // });

}

// $(document).ready(setupDateTimePickers);
// $(document).on('page:load', setupDateTimePickers(moment(),moment()));
