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



document.getElementById('aa-link-rechercher').onclick = function()
{
  document.getElementById("aa-nav-search-input").classList.toggle("toggled-search");
  document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
  document.getElementById('aa-nav-deposer').classList.toggle("hidden");
  document.getElementById('aa-link-rechercher').classList.toggle("hidden");
  document.getElementById("aa-nav-search-input").focus();
}

document.getElementById('aa-link-rechercher-picto').onclick = function()
{
  document.getElementById("aa-nav-search-input").classList.toggle("toggled-search");
  document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
  document.getElementById('aa-nav-deposer').classList.toggle("hidden");
  document.getElementById('aa-link-rechercher').classList.toggle("hidden");
  document.getElementById("aa-nav-search-input").focus();
}

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
  document.getElementById('aa-nav-deposer').classList.toggle("hidden");
  document.getElementById('aa-link-rechercher').classList.toggle("hidden");
}