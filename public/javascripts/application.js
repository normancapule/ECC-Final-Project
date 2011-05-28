// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

	$(document).ready(function() {
    $('.rate_form').bind('ajax:success', function() {
    $('.rate_form').fadeOut();
    $('.rate_form').html("<p>Thank you for rating!</p>");
    $('.rate_form').fadeIn();
        });
        
      $('.delete_post').bind('ajax:success', function() {
      $(this).closest('tr').fadeOut();
        });    
        

    $('#new_proj').click(function() {
      if ($("#new_project").is(":hidden")) {
        $("#new_project").slideDown("fast");
      } else {
        $("#new_project").slideUp();
      }});
      
      
      $('#new_rel').click(function() {
      if ($("#new_release").is(":hidden")) {
        $("#new_release").slideDown("fast");
      } else {
        $("#new_release").slideUp();
      }});
  
   
  });



