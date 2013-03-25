//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require twitter/bootstrap
//= require bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require holder
//= require_self

jQuery.fn.link_dropdown = function() {
  var link = $(this).parent().find("ul li:first a");
  if (link.length) {
    var href = link.attr('href');
    var text = link.text();
    $(this).text(text).attr('href', href);
  }
};

ready = function(){

  $("a[href='" + window.location.pathname + "']").parent().addClass('active');

  // Helper para que no colapsen las filas de la tabla al arrastrarlas.
  var fixHelper = function(e, ui) {
    ui.children().each(function() {
      $(this).width($(this).width());
    });
    return ui;
  };

  $("table.ordenable tbody").sortable({
    dropOnEmpty: false,
    handle: '.handle',
    helper: fixHelper, 
    opacity: 0.4,
    scroll: true,
    update: updateSortable
  }).disableSelection();

  function updateSortable(e, ui) {
    // var elemento = $(ui.item).closest('table.ordenable').closest('.url').val();
    var url = $(e.target).closest('.ordenable').find('input.url').val();

    $.ajax({
      type: 'post',
      data: $(this).sortable('serialize'),
      dataType: 'script',
      url: url
    })
  }

  $('#fecha').datepicker();

  $('.nav-tabs a, .nav-pills a').click(function(){
    href = $(this).attr('href');
    history.pushState(null, "", href);
  });

  var tab = window.location.hash;
  (tab) ? $('.nav-tabs a[href*=' + tab + '], .nav-pills a[href*=' + tab + ']').tab("show") : $('.nav-tabs a:first, .nav-pills a:first').tab("show");

  $('a.disabled').click(function(){
    return false
  });

  $('div.dropdown a.principal').each(function(){
    $(this).link_dropdown();
  });

}

$(document).ready(ready);
$(document).on('page:load', ready);