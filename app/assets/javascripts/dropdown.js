//= require slimselect.min

function multipleDd(ddClass,placeholderText) {
  if (document.querySelector('.'+ddClass) !== null) {
    var select = new SlimSelect({
      placeholder: placeholderText, 
      select: document.querySelector('.'+ddClass) 
      })
    document.querySelector('div.'+ddClass+'>div.ss-content>div.ss-search>input').placeholder = "Saisie";
  };
}

multipleDd("multiple-dd", "Choisissez une catégorie...");
multipleDd("multiple-dd2", "Choisissez un courant/style...");
multipleDd("multiple-dd3", "Choisissez une couleur...");
multipleDd("multiple-dd4", "Spécificités...");
multipleDd("multiple-dd5", "Disposition...");
multipleDd("multiple-dd6", "Code Postaux...");
multipleDd("multiple-dd7", "Pays...");
multipleDd("multiple-dd8", "Taille...");
multipleDd("multiple-dd9", "Artiste...");









//var selection = document.querySelector('.multiple-dd') !== null;
//var infoCategory = {};
// info.searchPlaceholder = "Choisissez 2";
//infoCategory.placeholder = "Choisissez une catégorie...";
//infoCategory.select = document.querySelector('.multiple-dd');



/*
if (selection) {
//   var select = new SlimSelect({
//   config: (searchPlaceholder = "Choisissez2"),
//   select: document.querySelector('.multiple-dd'),
  
  
  
// })
var select = new SlimSelect(infoCategory)
select.config.searchPlaceholder = "Choisissez 2";
if ( document.querySelector('div.multiple-dd>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  // document.querySelector('div.multiple-dd>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Choisissez une catégorie...";
}
  document.querySelector('div.multiple-dd>div.ss-content>div.ss-search>input').placeholder = "Saisie";

};
*/


/*
var selection2 = document.querySelector('.multiple-dd2') !== null;
if (selection2) {
   var select2 = new SlimSelect({
  select: document.querySelector('.multiple-dd2')
  
})
if ( document.querySelector('div.multiple-dd2>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd2>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Choisissez un courant/style...";
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


var selection4 = document.querySelector('.multiple-dd4') !== null;
if (selection4) {
   var select4 = new SlimSelect({
  select: document.querySelector('.multiple-dd4')
  
})
if ( document.querySelector('div.multiple-dd4>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd4>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Spécificités...";
}
  document.querySelector('div.multiple-dd4>div.ss-content>div.ss-search>input').placeholder = "Saisie";
};

var selection5 = document.querySelector('.multiple-dd5') !== null;
if (selection5) {
   var select5 = new SlimSelect({
  select: document.querySelector('.multiple-dd5')
  
})
if ( document.querySelector('div.multiple-dd5>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd5>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Disposition...";
}
  document.querySelector('div.multiple-dd5>div.ss-content>div.ss-search>input').placeholder = "Saisie";
};

var selection6 = document.querySelector('.multiple-dd6') !== null;
if (selection6) {
   var select6 = new SlimSelect({
  select: document.querySelector('.multiple-dd6')
  
})
if ( document.querySelector('div.multiple-dd6>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd6>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Code Postaux...";
}
  document.querySelector('div.multiple-dd6>div.ss-content>div.ss-search>input').placeholder = "Saisie";
};

var selection7 = document.querySelector('.multiple-dd7') !== null;
if (selection7) {
   var select7 = new SlimSelect({
  select: document.querySelector('.multiple-dd7')
  
})
if ( document.querySelector('div.multiple-dd7>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd7>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Pays...";
}
  document.querySelector('div.multiple-dd7>div.ss-content>div.ss-search>input').placeholder = "Saisie";
};

var selection8 = document.querySelector('.multiple-dd8') !== null;
if (selection8) {
   var select8 = new SlimSelect({
  select: document.querySelector('.multiple-dd8')
  
})
if ( document.querySelector('div.multiple-dd8>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd8>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Taille...";
}
  document.querySelector('div.multiple-dd8>div.ss-content>div.ss-search>input').placeholder = "Saisie";
};

var selection9 = document.querySelector('.multiple-dd9') !== null;
if (selection9) {
   var select9 = new SlimSelect({
  select: document.querySelector('.multiple-dd9')
  
})
if ( document.querySelector('div.multiple-dd9>div.ss-multi-selected>div.ss-values>span.ss-disabled') != null )  {
  document.querySelector('div.multiple-dd9>div.ss-multi-selected>div.ss-values>span.ss-disabled').innerText = "Artiste...";
}
  document.querySelector('div.multiple-dd9>div.ss-content>div.ss-search>input').placeholder = "Saisie";
};

*/