//= require slimselect.min
var selection = document.querySelector('.multiple-dd') !== null;
if (selection) {
   var select = new SlimSelect({
  select: document.querySelector('.multiple-dd')
  
})

if ( document.querySelector('div.multiple-dd>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Choisissez une catégorie...";
}
  document.querySelector('div.multiple-dd>div.ss-content>div.ss-search>input').placeholder = "Saisie";

};

var selection2 = document.querySelector('.multiple-dd2') !== null;
if (selection2) {
   var select2 = new SlimSelect({
  select: document.querySelector('.multiple-dd2')
  
})
if ( document.querySelector('div.multiple-dd2>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd2>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Choisissez un courant...";
}
  document.querySelector('div.multiple-dd2>div.ss-content>div.ss-search>input').placeholder = "Saisie";
};

var selection3 = document.querySelector('.multiple-dd3') !== null;
if (selection3) {
   var select3 = new SlimSelect({
  select: document.querySelector('.multiple-dd3')
  
})
if ( document.querySelector('div.multiple-dd3>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd3>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Choisissez une couleur...";
}
  document.querySelector('div.multiple-dd3>div.ss-content>div.ss-search>input').placeholder = "Saisie";
};
