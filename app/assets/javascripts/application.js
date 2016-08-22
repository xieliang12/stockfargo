// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require autocomplete-rails
//= require jquery.dataTables.min
//= require stocks_table_display
//= require bootstrap-datepicker
//= require_tree .

$(document).ready( function() {
  $('.datepicker').datepicker({format: 'yyyy-mm-dd'});

  $("td.currency").each(function() {
    var text = $(this).text();
    var num = parseFloat(text);
    if (num < 0) {
      $(this).addClass("negative");
    } else if (num > 0) {
      $(this).addClass("positive");
    }
  });

  $("#myButton").click(function() {
    var $btn = $(this);
    $btn.button('loading');
    setTimeout(function () {
      $btn.button('reset');
    }, 3000);
  });

  $("#myButtonEditAllSave").click(function() {
    var $btn = $(this);
    $btn.button('loading');
    setTimeout(function () {
      $btn.button('reset');
    }, 3000);
  });

});
