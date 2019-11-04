// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require bootstrap
//= require gmaps/google

//= require_tree .


$( document ).ready(function() {
    /*Scroll to top when arrow up clicked BEGIN*/
  $(window).scroll(function() {
    var height = $(window).scrollTop();
      if (height > 500) {
          $('#back2Top').fadeIn();
      } else {
          $('#back2Top').fadeOut();
      }
  });

  $("#back2Top").click(function(event) {
      event.preventDefault();
      $("html, body").animate({ scrollTop: 0 }, "slow");
      return false;
  });


  

    
});

