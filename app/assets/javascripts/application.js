// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(document).on('ready page:load', function() {
  $('#fp-nav').addClass('hide-for-small-only');
  $('#fp-nav').addClass('hide-for-medium-only');

  $('.details').hide();
  $('.info').hover(
    function () {
      $(this).find('.details').fadeIn();
    },
    function () {
      $(this).find('.details').delay(1000).fadeOut();
    }
  );

  $(function() {
    if ($('#user_dietary_restriction').val() == 'Allergy' || $('#user_dietary_restriction').val() == 'Other') {
      $('#special_instructions').show();
    } else {
      $('#special_instructions').hide();
    }
    $('#user_dietary_restriction').change(function(){
      if ($(this).val() == 'Allergy' || $(this).val() == 'Other') {
        $('#special_instructions').show();
      } else {
        $('#special_instructions').hide();
      }
    });
  });
});
