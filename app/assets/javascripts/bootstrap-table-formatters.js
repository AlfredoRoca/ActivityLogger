

var url = "/activities/";


// Complementary code for bootstrap-table
// 

//
// Date and time pickers for filtering
//

var setPickers = function () {
    $('#starting_date').datetimepicker({
        calendarWeeks: true,
        showTodayButton: true,
        showClear: true,
        showClose: true,
        useCurrent: false,
        locale: 'es',
        collapse: true,
        sideBySide: true,
        // viewDate: true,
        format: 'DD/MM/YYYY HH:mm',
    });
    $('#ending_date').datetimepicker({
        calendarWeeks: true,
        showTodayButton: true,
        showClear: true,
        showClose: true,
        useCurrent: false,
        locale: 'es',
        collapse: true,
        sideBySide: true,
        // viewDate: true,
        format: 'DD/MM/YYYY HH:mm',
    });
  };


  function booleanFormatter(value, row) {
    var result;
    if (!value) { result = ""; } else { if (value == true) { result = "\u2713"; } else { result = ""; } }
    return result;
  }

  function dateFormatter(value, row) {
    if (value) { 
      result = moment(value).format("DD/MM/YYYY HH:mm"); 
    } else { 
      result = ""; 
    }
    return result;
  }

  function onlyDateFormatter(value, row) {
    if (value) { 
      result = moment(value).format("DD/MM/YYYY"); 
    } else { 
      result = ""; 
    }
    return result;
  }

  function showLinkFormatter(value, row) {
    if (value) {
      result = "<a href='" + url + row.id + "'>Ver</a>";
    } else {
      result = null;
    }
    return result;
  }

  function editLinkFormatter(value, row) {
    if (value) {
      result = "<a href='" + url + row.id + "/edit'>Editar</a>";
    } else {
      result = null;
    }
    return result;
  }

  function destroyLinkFormatter(value, row) {
    if (value) {
      result = "<a href='" + url + row.id + "' data-method='delete' rel='nofollow' data-confirm='¿Estás seguro?'>Eliminar</a>";
    } else {
      result = null;
    }
    return result;
  }

  function toggleChargeableLinkFormatter(value, row) {
    if (value) {
      result = "<a href='" + url + row.id + "' onclick=\"toggleChargeable('" + row.id + "'); return false;\">Toggle chargeable</a>";
    } else {
      result = null;
    }
    return result;
  }

  function toggleChargeable(row) {
    $.ajax({
      method: "PUT",
      url: url + row + '/toggle_chargeable'
    })
      .done(function(){
        $('#table').bootstrapTable('refresh');
      })
      .fail(function(){
        console.log("Toggle chargeable failed!");
      })
  }

  var bindEventsToTable = function () {
    var showPopupMenu = function (row) {
      $('#showPath').html(showLinkFormatter(true, row));
      $('#editPath').html(editLinkFormatter(true, row));
      $('#destroyPath').html(destroyLinkFormatter(true, row));
      $('#toggleChargeable').html(toggleChargeableLinkFormatter(true, row));
      $('#managmentModal .modal-title').html("Managment activity " + row.id);
      $('#managmentModal').modal('show');
    }
    $('#table').bootstrapTable({
        onDblClickRow: function (row, $element) {
            showPopupMenu(row);
        },
        onClickRow: function (row, $element) {
            showPopupMenu(row);
        },
    });
  }

  function queryParams() {
      var params = new Object();
      // emergencies and recordings controllers set the vars to fill these ellements
      // these are necessary to set pickers on load (the only way i can make it work
      // if they exists, params get their values and updates pickers
      // if not params get pickers values

      // var start_at = $('#start_at');
      // var end_at = $('#end_at');
      // if (start_at.length > 0) {
      //     params['starting_date'] = start_at.data('start_at');
      //     $('#starting_date').val(params['starting_date']);
      // } else {
      //     params['starting_date'] = $('#starting_date').val();
      // }
      // if (end_at.length > 0) {
      //     params['ending_date'] = end_at.data('end_at');
      //     $('#ending_date').val(params['ending_date']);
      // } else {
      //     params['ending_date'] = $('#ending_date').val();
      // }

          params['starting_date'] = $('#starting_date').val();
          params['ending_date'] = $('#ending_date').val();
          params['chargeable'] = $('#chargeable').val();
          params['charged'] = $('#charged').val();


      return params;
  }

$(document).ready(setPickers);
$(document).on('page:load', setPickers);
