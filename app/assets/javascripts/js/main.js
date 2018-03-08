$(document).ready(function(){
 //google fonts
 WebFontConfig = {
  google: { families: [ 'Roboto:300i,400,400i,500,500i,700' ] } };
  (function() {
    var wf = document.createElement('script');
    wf.src = ('https:' == document.location.protocol ? 'https' : 'http') + '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
    wf.type = 'text/javascript';
    wf.async = 'true';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(wf, s);
  })();
  //hover dropdown type money
  if ($(window).width() > 1023) {
    $(".dropdown").hover(
        function(){ $(this).addClass('open') },
        function(){ $(this).removeClass('open') }
    );
  };
  //
  $('.nav > li.dropdown > a').click(function (e) {
    var $target = $(e.target);
    var activeNav = $(this).siblings();
    if ($target.is('b')) {
        $(this).siblings().toggle("fast");
        $('.nav > li.dropdown > ul.dropdown-menu:visible').not($(this).siblings()).hide("fast");
        return false;
    }
  });
  //stick in the fixed 100% height behind the navbar but don't wrap it
  $('#slide-nav.navbar-inverse').after($('<div class="inverse" id="navbar-height-col"></div>'));
  $('#slide-nav.navbar-default').after($('<div id="navbar-height-col"></div>'));
  // Enter your ids or classes
  var toggler = '.navbar-toggle';
  var pagewrapper = '#page-content';
  var navigationwrapper = '.navbar-header';
  var menuwidth = '100%'; // the menu inside the slide menu itself
  var slidewidth = '80%';
  var menuneg = '-100%';
  var slideneg = '-80%';

  $("#slide-nav").on("click", toggler, function (e) {
    var selected = $(this).hasClass('slide-active');
    $('#slidemenu').stop().animate({
        right: selected ? menuneg : '0px'
    });
    $('#navbar-height-col').stop().animate({
        right: selected ? slideneg : '0px'
    });
    $(pagewrapper).stop().animate({
        right: selected ? '0px' : slidewidth
    });
    $(navigationwrapper).stop().animate({
        right: selected ? '0px' : slidewidth
    });
    $(this).toggleClass('slide-active', !selected);
    $('#slidemenu').toggleClass('slide-active');
    $('#page-content, .navbar, body, .navbar-header').toggleClass('slide-active');
  });
  var selected = '#slidemenu, #page-content, body, .navbar, .navbar-header';
  $(window).on("resize", function () {
      if ($(window).width() > 767 && $('.navbar-toggle').is(':hidden')) {
          $(selected).removeClass('slide-active');
      }
  });
});
