//= require rails-ujs
//= require_tree .

window.onbeforeunload = function () {
  window.scrollTo(0, 0);
}


window.onload = toggleMobile();

function toggleMobile()
{
   document.getElementById('mobilesearch').onclick = function()
   {
       document.getElementById('tabmobilesearch').classList.toggle("aa-search-hidden");
       document.getElementById('tabmobileform').classList.toggle("aa-search-mobile");

       // document.getElementById('tabmobileform2').classList.toggle("aa-search-mobile2");
   }
}
// window.onload = navbarWidth();
// window.onresize = navbarWidth();
// function navbarWidth ()
// {
//    // var bodyWidth = document.getElementById('navbar-lewagon').parentElement.width;
//    var bodyWidth = document.body.clientWidth;
//    document.getElementById('navbar-lewagon').width = bodyWidth
//    var navWidth = document.getElementById('navbar-lewagon').width
//   console.log(bodyWidth);
//   console.log(navWidth);
// }

document.getElementById('aa-decouvrir').onclick = function()
{
  window.location = this.querySelector("a").href;
}

document.getElementById('aa-deposer').onclick = function()
{
  window.location = this.querySelector("a").href;
}



const _C = document.querySelector('.container-annonces'),
      N = _C.children.length, NF = 30,
      TFN = {
         // can remove these if not used
        // 'linear': function(k) { return k },
        // 'ease-in': function(k, e = 1.675) {
        //   return Math.pow(k, e)
        // },
        // 'ease-out': function(k, e = 1.675) {
        //   return 1 - Math.pow(1 - k, e)
        // },
        // 'ease-in-out': function(k) {
        //   return .5*(Math.sin((k - .5)*Math.PI) + 1)
        // },
        'bounce-out': function(k, a = 2.75, b = 1.5) {
          return 1 - Math.pow(1 - k, a)*Math.abs(Math.cos(Math.pow(k, b)*(n + .5)*Math.PI))
        }
      };

let i = 0, x0 = null, locked = false, w, ini, fin, rID = null, anf, n;

function stopAni() {
  cancelAnimationFrame(rID);
  rID = null
};

function ani(cf = 0) {
  _C.style.setProperty('--i', ini + (fin - ini));
 // _C.style.setProperty('--i', ini + (fin - ini)*TFN['bounce-out'](cf/anf));
 // bounce

  if(cf === anf) {
    stopAni();
    return
  }

  rID = requestAnimationFrame(ani.bind(this, ++cf))
};

function unify(e) { return e.changedTouches ? e.changedTouches[0] : e };

function lock(e) {
  x0 = unify(e).clientX;
  locked = true
};

function drag(e) {
  e.preventDefault();

  if(locked) {
    let dx = unify(e).clientX - x0, f = +(dx/w).toFixed(2);

    _C.style.setProperty('--i', i - f)
  }
};

function move(e) {
  if(locked) {
    let dx = unify(e).clientX - x0,
        s = Math.sign(dx),
        f = +(s*dx/w).toFixed(2);

    ini = i - s*f;

    if((i > 0 || s < 0) && (i < N - 1 || s > 0) && f > .2) {
      i -= s;
      f = 1 - f
    }

    fin = i;
    anf = Math.round(f*NF);
    n = 2 + Math.round(f)
    ani();
    x0 = null;
    locked = false;
  }
};

function size() { w = window.innerWidth };

size();
_C.style.setProperty('--n', N);

addEventListener('resize', size, false);

_C.addEventListener('mousedown', lock, false);
_C.addEventListener('touchstart', lock, false);

_C.addEventListener('mousemove', drag, false);
_C.addEventListener('touchmove', drag, false);

_C.addEventListener('mouseup', move, false);
_C.addEventListener('touchend', move, false);


// function getRandomSize(min, max) {
//   return Math.round(Math.random() * (max - min) + min);
// }

// function appendCat(container) {
// var allImages = "";
// for (var ka = 0; ka < 4; ka++) {
//   var width = getRandomSize(200, 400);
//   var height =  getRandomSize(200, 400);
//   allImages += '<img src="https://placekitten.com/'+width+'/'+height+'" alt="pretty kitty">';
// }
// var div = document.getElementById(container);
// div.innerHTML += allImages;
// }


// appendCat('photos1');
// appendCat('photos2');
// appendCat('photos3');
// appendCat('photos4');
// appendCat('photos5');
// appendCat('photos6');
// appendCat('photos7');
// appendCat('photos8');
// appendCat('photos9');
// appendCat('photos10');
// appendCat('photos11');
// appendCat('photos12');
// appendCat('photos13');
// appendCat('photos14');
// appendCat('photos15');


