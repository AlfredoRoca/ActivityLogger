

var url = "/activities/";


// Complementary code for bootstrap-table
// 

  function dateFormatter(value, row) {
    if (value) { 
      result = moment(value).format("DD/MM/YYYY HH:mm"); 
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

  var bindEventsToTable = function () {
    var showPopupMenu = function (row) {
      $('#showPath').html(showLinkFormatter(true, row));
      $('#editPath').html(editLinkFormatter(true, row));
      $('#destroyPath').html(destroyLinkFormatter(true, row));
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

