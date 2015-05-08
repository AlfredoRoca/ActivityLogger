$(function() {
    var startDate;
    var endDate;
    
    var selectCurrentWeek = function() {
        window.setTimeout(function () {
            $('#weekpicker').datepicker('widget').find('.ui-datepicker-current-day a').addClass('ui-state-active');
        }, 1);
    }
    
    $('#weekpicker').datepicker( {
        showOtherMonths: true,
        selectOtherMonths: true,
        numberOfMonths: 1,
        firstDay: 1,
        beforeShow: function() {
            selectCurrentWeek();
        },
        beforeShowDay: function(date) {
            var cssClass = '';
            if(date >= startDate && date <= endDate)
                cssClass = 'ui-datepicker-current-day';
            return [true, cssClass];
        },
        onChangeMonthYear: function(year, month, inst) {
            selectCurrentWeek();
        }
    }).datepicker('widget').addClass('ui-weekpicker');
    
    $("#weekpicker").change(function(dateText, inst){
      var date = $(this).datepicker('getDate');
      var dateFormatToSee = "D, dd/mm/yy";
      var dateFormatToSend = "dd/mm/yy";
      var daysOffsetStartWeekSelection = 1;
      startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + daysOffsetStartWeekSelection);
      endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + daysOffsetStartWeekSelection + 6 );
      $("#weekpicker").val($.datepicker.formatDate(dateFormatToSee, startDate) + ' - ' + $.datepicker.formatDate(dateFormatToSee, endDate));
      $('#start').val($.datepicker.formatDate( dateFormatToSend, startDate ));
      $('#ended').val($.datepicker.formatDate( dateFormatToSend, endDate ));
      selectCurrentWeek();
    });
 
});


