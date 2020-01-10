//= require rails-ujs
//= require_tree .



$('a[data-popup]').on('click', function(e) { window.open($(this).attr('href')); e.preventDefault(); });


// var $container = $('.grid');

// $( "#annonces-tab" ).click(function() {
//     // $('.grid-item img.not-loaded').removeClass("not-loaded");
//     $('.grid').delay(2000).masonry('layout');
// });
$( document ).ready(function() { 
 $('.aa-navbar-artaetas title').html('');
 $('aa-footer-ae title').html('');
 
});