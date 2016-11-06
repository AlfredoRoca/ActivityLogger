var setupDateTimePickers = function (start, ended, charged) {
  $('#datetimepicker_start').datetimepicker({
    format: "D/M/YYYY HH:mm",
    defaultDate: start,
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
    defaultDate: ended,
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
  $('#datetimepicker_charged_date').datetimepicker({
    format: "D/M/YYYY",
    defaultDate: charged,
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

}

// $(document).ready(setupDateTimePickers);
// $(document).on('page:load', setupDateTimePickers(moment(),moment()));
