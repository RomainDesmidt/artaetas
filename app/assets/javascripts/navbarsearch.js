window.onload = toggleMobile();

function toggleMobile()
{
   document.getElementById('mobilesearch').onclick = function()
   {
       document.getElementById('tabmobilesearch').classList.toggle("aa-search-hidden");
       document.getElementById('tabmobileform').classList.toggle("aa-search-mobile");
       document.getElementById('aa-textfield-on').readOnly = false;

       // document.getElementById('tabmobileform2').classList.toggle("aa-search-mobile2");
   }
}

function triggerEvent( elem, event ) {
  var clickEvent = new Event( event ); // Create the event.
  elem.dispatchEvent( clickEvent );    // Dispatch the event.
}



document.getElementById('mobilesearch').onclick = function()
{
  document.getElementById("navbar-lewagon").classList.toggle("aa-nowrap");
  document.getElementById("Calque_1").classList.toggle("hidden");
  document.getElementById("aa-nav-search-input-mobile").classList.toggle("toggled-search-mobile");
  // document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
  // document.getElementById('aa-nav-deposer').classList.toggle("hidden");
  // document.getElementById('aa-link-rechercher').classList.toggle("hidden");
  document.getElementById("aa-nav-search-input-mobile").focus();
}


var searchFocus = document.getElementById("aa-nav-search-input-mobile");
// searchFocus.addEventListener("focusin", searchExpand);
searchFocus.addEventListener("focusout", searchContractMobile);


function searchContractMobile() {
  document.getElementById("aa-nav-search-input-mobile").classList.toggle("toggled-search-mobile");
  document.getElementById("Calque_1").classList.toggle("hidden");
  document.getElementById("navbar-lewagon").classList.toggle("aa-nowrap");
  // document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
  // document.getElementById('aa-nav-deposer').classList.toggle("hidden");
  // document.getElementById('aa-link-rechercher').classList.toggle("hidden");
}

// var rechercherLink = document.querySelector('#aa-link-rechercher') !== null;
// if (rechercherLink) {
  var navDeposer = document.querySelector('#aa-nav-deposer') !== null;
  document.getElementById('aa-link-rechercher').onclick = function()
  {
    document.getElementById("aa-nav-search-input").classList.toggle("toggled-search");
    document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
    document.getElementById('aa-link-rechercher').classList.toggle("hidden");
    document.getElementById("aa-nav-search-input").focus();
    if (navDeposer) { 
      document.getElementById('aa-nav-deposer').classList.toggle("hidden");
    };
  }

// };

// var rechercherPicto = document.querySelector('#aa-link-rechercher-picto') !== null;
// if (rechercherPicto) {

  document.getElementById('aa-link-rechercher-picto').onclick = function()
  {
    document.getElementById("aa-nav-search-input").classList.toggle("toggled-search");
    document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
    document.getElementById('aa-link-rechercher').classList.toggle("hidden");
    document.getElementById("aa-nav-search-input").focus();
    if (navDeposer) { 
      document.getElementById('aa-nav-deposer').classList.toggle("hidden");
    };
  }

// };

var searchFocus = document.getElementById("aa-nav-search-input");
// searchFocus.addEventListener("focusin", searchExpand);
searchFocus.addEventListener("focusout", searchContract);

// function searchExpand() {
//   document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
//   document.getElementById('aa-nav-deposer').classList.toggle("hidden");
// }

function searchContract() {
  document.getElementById("aa-nav-search-input").classList.toggle("toggled-search");
  document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
  document.getElementById('aa-link-rechercher').classList.toggle("hidden");
  if (navDeposer) { 
    document.getElementById('aa-nav-deposer').classList.toggle("hidden");
  };
}

//   document.getElementById('aa-search-red-id').onclick = function()
//   {
//     document.getElementsByClassName("aa-search-field-select-tag").forEach(newmyFunction);
    
//     //document.getElementById("aa-search-field-select-tag").classList.toggle("hidden");
//     //document.getElementById("aa-nav-search-input").classList.toggle("toggled-search");
//   }
  
//   function newmyFunction(item)  {
//     item.classList.toggle("hidden"); 
//   }
  
//   for (var i = 0; i < children.length; i++){
//     console.log(children[i]);
// }

$("#aa-search-red-id").click(function() {
  $("div.aa-search-field-select").toggleClass("hidden-mobile-576-only");
  $(".slider-horizontal").toggleClass("hidden-mobile-576-only");
  $("#aa-search-red-plus").toggleClass("hidden");
  $("#aa-search-red-moins").toggleClass("hidden");
  //$(".aa-search-field-select").toggleClass("aa-search-field-select-hidden");
 // $("#aa-hide-slider").toggleClass("hidden-mobile-576-only");
  //$("#aa-search-red-id").nextAll("select").toggle();
  //$("#aa-search-red-id").nextAll("option").toggle();
  
  
// setTimeout(
//   function() 
//   {
// $("div.multiple-dd9>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Artiste...";
// $("div.multiple-dd8>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Taille...";
// $("div.multiple-dd7>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Pays...";
// $("div.multiple-dd6>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Code Postaux...";
// $("div.multiple-dd5>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Disposition...";
// $("div.multiple-dd4>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Spécificités...";
// $("div.multiple-dd3>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Choisissez une couleur...";
// $("div.multiple-dd2>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Choisissez un courant/style...";
// $("div.multiple-dd>div.ss-multi-selected>div.ss-values>span.ss-disabled")[0].innerText = "Choisissez une catégorie...";
//   }, 50);

  
  // $("select").toggle();
  // $("option").toggle();
});
