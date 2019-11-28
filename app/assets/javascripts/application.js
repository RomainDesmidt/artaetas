//= require rails-ujs
//= require_tree .



$('a[data-popup]').on('click', function(e) { window.open($(this).attr('href')); e.preventDefault(); });




