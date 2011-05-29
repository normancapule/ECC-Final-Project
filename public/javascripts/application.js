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
      
      
        if ($("#logs").length > 0) {
       
        setTimeout(updateLogs, 8000);
          }
      
  
      function updateLogs () {
        var project_id = $("#project").attr("data-id");
        if ($(".log").length > 0) {
          var after = $(".log:last-child").attr("data-time");
        } else {
          var after = "0";
        }
        $.getScript("/logs.js?project_id=" + project_id + "&after=" + after)
        setTimeout(updateLogs, 8000);
      }
   

  alert($('#right-sidebar').scrollTop());
   
  });
      
