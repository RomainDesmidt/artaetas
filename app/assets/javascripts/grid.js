//= require masonry.pkgd.min
//= require imagesloaded.pkgd.min
//= require jquery.lazyload

var $container = false;

// ################################   INDEX & SEARCH

if (window.matchMedia('(max-width: 638px)').matches)
{

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
              fitWidth: false
            
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
}
else
{

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
}

// ################################ ME - USER


      
      // $containerme.delay(3000).masonry('layout');
      // $containerme.masonry('layout');

      
  

var $containerme = $('.grid-me');

if ( $( "#annonces-tab" ).data("view") == "primary" ) {
  
  if ( $('.grid-me').length ) {
  
        $containerme.masonry({
            itemSelector: '.grid-item-me',
            // columnWidth: function(containerWidth){
            //     return containerWidth / 12;
            // }
              columnWidth: '.grid-sizer-me',
              percentPosition: true,
              gutter: '.gutter-sizer-me',
              fitWidth: true
            
        });
        $containerme.masonry('layout');
        setTimeout(function(){
          $containerme.masonry('layout');
          $containerme.delay(3000).masonry('layout');
        },200); 
    };
    
} else {
  $( "#annonces-tab" ).click(function() {
    if ( $('.grid-me').length ) {
  
        $containerme.masonry({
            itemSelector: '.grid-item-me',
            // columnWidth: function(containerWidth){
            //     return containerWidth / 12;
            // }
              columnWidth: '.grid-sizer-me',
              percentPosition: true,
              gutter: '.gutter-sizer-me',
              fitWidth: true
            
        });
        $containerme.masonry('layout');
        setTimeout(function(){
          $containerme.masonry('layout');
          $containerme.delay(3000).masonry('layout');
        },200); 
    };
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
    };
    if ( $containerme.length ) {
      $containerme.delay(3000).masonry('layout');
      $containerme.masonry('layout');
      // console.log("hello");
    }
    
    // if ($(window).width() <= 630) {  
    //     console.log("ici");
    //     var $container = $('.grid');
    //     $container.imagesLoaded(function(){
    //         $container.masonry({
    //             itemSelector: '.grid-item',
    //             // columnWidth: function(containerWidth){
    //             //     return containerWidth / 12;
    //             // }
    //               columnWidth: '.grid-sizer',
    //               percentPosition: true,
    //               gutter: '.gutter-sizer',
    //               fitWidth: false
                
    //         });
    //         $('.grid-item img').addClass('not-loaded');
    //         $('.grid-item img.not-loaded').lazyload({
    //             effect: 'fadeIn',
    //             load: function() {
    //                 // Disable trigger on this image
    //                 $(this).removeClass("not-loaded");
    //                 $container.masonry('layout');
    //             }
    //         });
    //         $('.grid-item img.not-loaded').trigger('scroll');
    //     });

    // };    
    
  });
  
  
  $( window ).change(function() {
    if ( $container.length ) {
      $container.masonry('layout');
    };
    if ( $containerme.length ) {
      $containerme.masonry('layout');
    }
  });
   
   
});