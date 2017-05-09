// // Create a clone of the menu, right next to original.
// $('.menu').addClass('original').clone().insertAfter('.menu').addClass('cloned').css('position','fixed').css('top','0').css('margin-top','0').css('z-index','500').removeClass('original').hide();

// scrollIntervalID = setInterval(stickIt, 10);


// function stickIt() {

//   var orgElementPos = $('.original').offset();
//   orgElementTop = orgElementPos.top;               

//   if ($(window).scrollTop() >= (orgElementTop)) {
//     // scrolled past the original position; now only show the cloned, sticky element.

//     // Cloned element should always have same left position and width as original element.     
//     orgElement = $('.original');
//     coordsOrgElement = orgElement.offset();
//     leftOrgElement = coordsOrgElement.left;  
//     widthOrgElement = orgElement.css('width');
//     $('.cloned').css('left',leftOrgElement+'px').css('top',0).css('width',widthOrgElement).show();
//     // $('.original').css('visibility','hidden');
//   } else {
//     // not scrolled past the menu; only show the original menu.
//     $('.cloned').hide();
//     $('.original').css('visibility','visible');
//   }
// }


// offset_top = $("#menu").offset().top     // absolute
// position_top = $("#menu").position().top // relative to parent
// $(window).scroll(function() {
//   if($(this).scrollTop() >= offset_top) {
//     $("#menu").css("top", $(this).scrollTop() - position_top);
//   }
// });

// $(document)
//   .ready(function() {

//     // fix menu when passed
//     $('.masthead')
//       .visibility({
//         once: false,
//         onBottomPassed: function() {
//           $('.fixed.menu').transition('fade in');
//         },
//         onBottomPassedReverse: function() {
//           $('.fixed.menu').transition('fade out');
//         }
//       })
//     ;

//     // fix menu when passed
//     $('.masthead2')
//       .visibility({
//         once: false,
//         onBottomPassed: function() {
//           $('.fixed.menu').transition('fade in');
//         },
//         onBottomPassedReverse: function() {
//           $('.fixed.menu').transition('fade out');
//         }
//       })
//     ;

//     // create sidebar and attach to menu open
//     $('.ui.vertical.sidebar')
//       .sidebar('attach events', '.toc.item')
//     ;

//   })
// ;



$(function(){
  // bind change event to select
  $('#strane').on('change', function () {
      var url = $(this).val(); // get selected value
      if (url) { // require a URL
          window.location = url; // redirect
      }
      return false;
  });
});

















      (function (window, document) {
      var menu = document.getElementById('menu'),
          WINDOW_CHANGE_EVENT = ('onorientationchange' in window) ? 'orientationchange':'resize';
      
      function toggleHorizontal() {
          [].forEach.call(
              document.getElementById('menu').querySelectorAll('.custom-can-transform'),
              function(el){
                  el.classList.toggle('pure-menu-horizontal');
              }
          );
      };
      
      function toggleMenu() {
          // set timeout so that the panel has a chance to roll up
          // before the menu switches states
          if (menu.classList.contains('open')) {
              setTimeout(toggleHorizontal, 500);
          }
          else {
              toggleHorizontal();
          }
          menu.classList.toggle('open');
          document.getElementById('toggle').classList.toggle('x');
      };
      
      function closeMenu() {
          if (menu.classList.contains('open')) {
              toggleMenu();
          }
      }
      
      document.getElementById('toggle').addEventListener('click', function (e) {
          toggleMenu();
          e.preventDefault();
      });
      
      window.addEventListener(WINDOW_CHANGE_EVENT, closeMenu);
      })(this, this.document);


// var validate = (function() {
//   var reClass = /(^|\s)required(\s|$)/;  // Field is required
//   var reValue = /^\s*$/;                 // Match all whitespace

//   return function (form) {
//     var elements = form.elements;
//     var el;

//     for (var i=0, iLen=elements.length; i<iLen; i++) {
//       el = elements[i];
//       // document.getElementById(el.id).className -= " error"
//       // document.getElementById(el.id).className = "required"

//       if (reClass.test(el.className) && reValue.test(el.value)) {
//         // Required field has no value or only whitespace
//         // Advise user to fix
//         document.getElementById(el.id).className = "required error"
//         alert('please fix ' + el.id);
//         return false;

//       }
//     }
//   }
// }());






var $menu = $('.menuinner');
$(document).scroll(function() {
  // console.log($(this).scrollTop())
    $menu.css({"box-shadow": $(this).scrollTop() > 0? "0 0 20px rgba(0, 0, 0, .75)":"none"});
    $menu.css({"background": $(this).scrollTop() > 0? "rgba(153, 0, 51, .95)":"none"});
    // $menu.css({"background": $(this).scrollTop() > 20? "#903":"transparent"});
    // $menu.css({"opacity": $(this).scrollTop() > 20? "0":"1"});
    // $menu.css({display: $(this).scrollTop() > 50? "block":"none"});
});

var $splashhome = $('.splash-container-home');
$(document).scroll(function() {

    // $splashhome.css({"opacity": $(this).scrollTop() > 60? opacity:"1"});
    // $splashhome.css({"background": $(this).scrollTop() > 60? "none":"rgba(153, 0, 51, .95)"});
    $splashhome.css({"top": $(this).scrollTop() > 0? "-120px":"0"});
    // $menu.css({"background": $(this).scrollTop() > 20? "#903":"transparent"});

    // $menu.css({display: $(this).scrollTop() > 50? "block":"none"});
});


var $logo = $('.logo');
$(document).scroll(function() {
    // $logo.css({"opacity": $(this).scrollTop() > 20? "1":"0"});
    $logo.css({"height": $(this).scrollTop() > 0? "2em":"6em"});
    // $menu.css({display: $(this).scrollTop() > 130? "block":"none"});
});

var $splash = $('.splash');
$(document).scroll(function() {
    var no = $(this).scrollTop();
    if (no > 100) no = 100;
    var opacity = (60-no)/100;
    // console.log(no);
    $splash.css({"opacity": $(this).scrollTop() > 0? opacity:"1"});
    // $menu.css({display: $(this).scrollTop() > 130? "block":"none"});
});

// var $splashhome = $('.splash-home');
// $(document).scroll(function() {
//     var no = $(this).scrollTop();
//     if (no > 100) no = 100;
//     var opacity = (60-no)/100;
//     // console.log(no);
//     $splashhome.css({"opacity": $(this).scrollTop() > 0? opacity:"1"});
//     // $menu.css({display: $(this).scrollTop() > 130? "block":"none"});
// });

var $splash = $('#edit');
$(document).scroll(function() {
    $splash.css({"width": $(this).scrollTop() > 0? "0%":"100%"});
});









var $nav = $('nav');
$(document).scroll(function() {
  // console.log($(this).scrollTop())
    $nav.css({"box-shadow": $(this).scrollTop() > 0? "0 0 20px rgba(0, 0, 0, .75)":"none"});
    $nav.css({"background": $(this).scrollTop() > 0? "rgba(153, 0, 51, .95)":"none"});
    // $menu.css({"background": $(this).scrollTop() > 20? "#903":"transparent"});
    // $menu.css({"opacity": $(this).scrollTop() > 20? "0":"1"});
    // $menu.css({display: $(this).scrollTop() > 50? "block":"none"});
});


$('article').readmore({
  speed: 75,
  lessLink: '<a href="#">Read less</a>'
});