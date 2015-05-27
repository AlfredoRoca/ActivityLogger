var set_pickers = function () {
  $('#start').datetimepicker({
    format: 'dd/MM/yyyy hh:mm',
    language: 'es',
    weekStart: 1,
    maskInput: true,           // disables the text input mask
    pickDate: true,            // disables the date picker
    pickTime: true,            // disables de time picker
    pick12HourFormat: false,   // enables the 12-hour format time picker
    pickSeconds: false,         // disables seconds in the time picker
    startDate: Date.now,      // set a minimum date
    endDate: Infinity          // set a maximum date
      });

  $('#ended').datetimepicker({
    format: 'dd/MM/yyyy hh:mm',
    language: 'es',
    weekStart: 1,
    maskInput: true,           // disables the text input mask
    pickDate: true,            // disables the date picker
    pickTime: true,            // disables de time picker
    pick12HourFormat: false,   // enables the 12-hour format time picker
    pickSeconds: false,         // disables seconds in the time picker
    startDate: Date.now,      // set a minimum date
    endDate: Infinity          // set a maximum date
      });
  
};

$(document).ready(set_pickers);
$(document).on('page:load', set_pickers);