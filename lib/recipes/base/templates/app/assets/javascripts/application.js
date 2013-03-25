//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require twitter/bootstrap
//= require bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require holder
//= require jquery.colorbox
//= require jquery.colorbox-es
//= require_self

ready = function(){
  $("a[href='" + window.location.pathname + "']").parent().addClass('active');
  $('a.colorbox').colorbox({
    rel: 'colorbox'
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);