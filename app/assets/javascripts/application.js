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
  $(function() {
    $('div.current_role').find('.info')
      .replaceWith(
        '<div class="info"><p class="text-center"><b>You</b></p><p class="text-center">are awesome.</p></div>'
      );

    // Disable the reminders and hide when guest has RSVP'd
    $('#user_rsvp').click(function() {
      if ($(this).is(':checked')) {
        $('#reminder-field').addClass('hide');
        $('#user_reminders').prop( 'checked', false );
      } else {
        $('#user_reminders').prop( 'checked', true );
        $('#reminder-field').removeClass('hide');
      }
    });
  });
});
