$('#myTable1').DataTable({
  lengthMenu: [ 15, 25, 50, 100],
  order: [[ 0, 'asc' ]],
  processing: true,
  serverSide: true,
  stateSave: true,
  responsive: true,
  bDestroy: true,
  drawCallback: function() {
    var api = this.api();
    api.$('#btn-click-action2').click(function() {
      $('table tr').hide()
      $('table tr:has(a.'+"view2"+')').show()
        });
    }
    });
