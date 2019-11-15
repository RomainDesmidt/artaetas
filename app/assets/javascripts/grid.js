//= require masonry.pkgd.min
//= require imagesloaded.pkgd.min
//= require jquery.lazyload

var $container = false;

// ################################   INDEX
if ( $('.grid').length ) {
  var $container = $('.grid');
  $container.imagesLoaded(function(){
      $container.masonry({
          itemSelector: '.grid-item',
          // columnWidth: function(containerWidth){
          //     return containerWidth / 12;
          // }
            columnWidth: '.grid-sizer',
            percentPosition: true,
            gutter: '.gutter-sizer',
            fitWidth: true
          
      });
      $('.grid-item img').addClass('not-loaded');
      $('.grid-item img.not-loaded').lazyload({
          effect: 'fadeIn',
          load: function() {
              // Disable trigger on this image
              $(this).removeClass("not-loaded");
              $container.masonry('layout');
          }
      });
      $('.grid-item img.not-loaded').trigger('scroll');
  });
};


// ################################ TEST INDEX


if ( $('.gridouille').length ) {
  var $container = $('.gridouille');
  $container.imagesLoaded(function(){
      $container.masonry({
          itemSelector: '.gridouille-item',
          // columnWidth: function(containerWidth){
          //     return containerWidth / 12;
          // }
            columnWidth: '.gridouille-sizer',
            percentPosition: true,
            gutter: '.gutterouille-sizer',
            fitWidth: true
          
      });
      $('.gridouille-item img').addClass('not-loaded');
      $('.gridouille-item img.not-loaded').lazyload({
          effect: 'fadeIn',
          load: function() {
              // Disable trigger on this image
              $(this).removeClass("not-loaded");
              $container.masonry('layout');
          }
      });
      $('.gridouille-item img.not-loaded').trigger('scroll');
  });
};

// ################################ BOTH

$( document ).ready(function() {   
  $( window ).resize(function() {
    if ( $container.length ) {
      $container.delay(3000).masonry('layout');
      $container.masonry('layout');
      // console.log("hello");
    }
  });
  
  
  $( window ).change(function() {
    if ( $container.length ) {
      $container.masonry('layout');
    }
  });
   
   
});