//= require rails-ujs
//= require_tree .
// window.onbeforeunload = function () {
new SlimSelect({
  select: '#multiple'
})



window.onload = function () {
  window.scrollTo(0, 0);
}

window.onbeforeunload = function () {
  window.scrollTo(0, 0);
}


window.SocialShareButton = {
  openUrl(url, width, height) {
    if (width == null) { width = 640; }
    if (height == null) { height = 480; }
    const left = (screen.width / 2) - (width / 2);
    const top = (screen.height * 0.3) - (height / 2);
    const opt = `width=${width},height=${height},left=${left},top=${top},menubar=no,status=no,location=no`;
    window.open(url, 'popup', opt);
    return false;
  },

  share(el) {
    if (el.getAttribute === null) {
      el = document.querySelector(el);
    }

    const site = el.getAttribute("data-site");
    const appkey = el.getAttribute("data-appkey") || '';
    const $parent = el.parentNode;
    let title = encodeURIComponent(el.getAttribute(`data-${site}-title`) || $parent.getAttribute('data-title') || '');
    const img = encodeURIComponent($parent.getAttribute("data-img") || '');
    let url = encodeURIComponent($parent.getAttribute("data-url") || '');
    const via = encodeURIComponent($parent.getAttribute("data-via") || el.getAttribute("data-via") || '');


    const desc = encodeURIComponent($parent.getAttribute("data-desc") || ' ');


    // tracking click events if google analytics enabled
    const ga = window[window['GoogleAnalyticsObject'] || 'ga'];
    if (typeof ga === 'function') {
      ga('send', 'event', 'Social Share Button', 'click', site);
    }

    if (url.length === 0) {
      url = encodeURIComponent(location.href);
    }
    switch (site) {
      case "email":
        location.href = `mailto:?to=&subject=${title}&body=${url}`;
        break;
      case "weibo":
        SocialShareButton.openUrl(`http://service.weibo.com/share/share.php?url=${url}&type=3&pic=${img}&title=${title}&appkey=${appkey}`, 620, 370);
        break;
      case "twitter":
        var hashtags = encodeURIComponent(el.getAttribute(`data-${site}-hashtags`) || $parent.getAttribute("data-hashtags") || '');
        var via_str = '';
        if (via.length > 0) { via_str = `&via=${via}`; }
        SocialShareButton.openUrl(`https://twitter.com/intent/tweet?url=${url}&text=${title}&hashtags=${hashtags}${via_str}`, 650, 300);
        break;
      case "douban":
        SocialShareButton.openUrl(`http://shuo.douban.com/!service/share?href=${url}&name=${title}&image=${img}&sel=${desc}`, 770, 470);
        break;
      case "facebook":
        SocialShareButton.openUrl(`http://www.facebook.com/sharer/sharer.php?u=${url}&display=popup&quote=${desc}`, 555, 400);
        break;
      case "qq":
        SocialShareButton.openUrl(`http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=${url}&title=${title}&pics=${img}&summary=${desc}&site=${appkey}`);
        break;
      case "google_plus":
        SocialShareButton.openUrl(`https://plus.google.com/share?url=${url}`);
        break;
      case "google_bookmark":
        SocialShareButton.openUrl(`https://www.google.com/bookmarks/mark?op=edit&output=popup&bkmk=${url}&title=${title}`);
        break;
      case "delicious":
        SocialShareButton.openUrl(`https://del.icio.us/save?url=${url}&title=${title}&jump=yes&pic=${img}`);
        break;
      case "pinterest":
        SocialShareButton.openUrl(`http://www.pinterest.com/pin/create/button/?url=${url}&media=${img}&description=${title}`);
        break;
      case "linkedin":
        SocialShareButton.openUrl(`https://www.linkedin.com/shareArticle?mini=true&url=${url}&title=${title}&summary=${desc}`);
        break;
      case "xing":
        SocialShareButton.openUrl(`https://www.xing.com/spi/shares/new?url=${url}`);
        break;
      case "vkontakte":
        SocialShareButton.openUrl(`http://vk.com/share.php?url=${url}&title=${title}&image=${img}`);
        break;
      case "odnoklassniki":
        SocialShareButton.openUrl(`https://connect.ok.ru/offer?url=${url}&title=${title}&description=${desc}&imageUrl=${img}`);
        break;
      case "wechat":
        if (!window.SocialShareWeChatButton) { throw new Error("You should require social-share-button/wechat to your application.js"); }
        window.SocialShareWeChatButton.qrcode({
          url: decodeURIComponent(url),
          header: el.getAttribute('title'),
          footer: el.getAttribute("data-wechat-footer")
        });
        break;

      case "tumblr":
        var get_tumblr_extra = function(param) {
          const cutom_data = el.getAttribute(`data-${param}`);
          if (cutom_data) { return encodeURIComponent(cutom_data); }
        };

        var tumblr_params = function() {
          const path = get_tumblr_extra('type') || 'link';

          const params = (() => { switch (path) {
            case 'text':
              title = get_tumblr_extra('title') || title;
              return `title=${title}`;
            case 'photo':
              title = get_tumblr_extra('caption') || title;
              var source = get_tumblr_extra('source') || img;
              return `caption=${title}&source=${source}`;
            case 'quote':
              var quote = get_tumblr_extra('quote') || title;
              source = get_tumblr_extra('source') || '';
              return `quote=${quote}&source=${source}`;
            default: // actually, it's a link clause
              title = get_tumblr_extra('title') || title;
              url = get_tumblr_extra('url') || url;
              return `name=${title}&url=${url}`;
          } })();


          return `/${path}?${params}`;
        };

        SocialShareButton.openUrl(`http://www.tumblr.com/share${tumblr_params()}`);
        break;

      case "reddit":
        SocialShareButton.openUrl(`http://www.reddit.com/submit?url=${url}&newwindow=1`, 555, 400);
        break;
      case "hacker_news":
        SocialShareButton.openUrl(`http://news.ycombinator.com/submitlink?u=${url}&t=${title}`, 770, 500);
        break;
      case "telegram":
        SocialShareButton.openUrl(`https://telegram.me/share/url?text=${title}&url=${url}`);
        break;
      case "whatsapp_app":
        var whatsapp_app_url = `whatsapp://send?text=${title}&url=${url}`;
        window.open(whatsapp_app_url, '_top');
        break;
      case "whatsapp_web":
        SocialShareButton.openUrl(`https://web.whatsapp.com/send?text=${title}&url=${url}`);
        break;
    }
    return false;
  }
};





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
function triggerEvent( elem, event ) {
  var clickEvent = new Event( event ); // Create the event.
  elem.dispatchEvent( clickEvent );    // Dispatch the event.
}

// document.getElementById('aa-show-likefunc').onclick = function()
// {
//   window.location = this.querySelector("a").click();
// }

document.getElementById('aa-decouvrir').onclick = function()
{
  window.location = this.querySelector("a").href;
}


document.getElementById('aa-deposer').onclick = function()
{
  window.location = this.querySelector("a").href;
}

// document.getElementById('aa-nav-search-form').onclick = function()
// {
//   document.getElementById('aa-nav-decouvrir').classList.toggle("hidden");
// }

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





var manyCards = document.getElementsByClassName("aa-annonce-card");
// manyCards.forEach(function(oneCard) {

//   oneCard.addEventListener('click', function() {
//     window.location = this.querySelector("a").href;

//   });
// });

Array.prototype.forEach.call(manyCards, function(oneCard) {
    oneCard.addEventListener('click', function() {
    window.location = this.querySelector("a").href;

  });
});



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


