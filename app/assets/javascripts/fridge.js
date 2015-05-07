$(document).ready(function() {

  var fridge = $("#fridge")

  $("#new_message").on("ajax:success", function(e, data, status, xhr) {
      $(fridge).append(xhr.responseText);
      $(fridge).find(".message-table:last").hide();
      $(fridge).find(".message-table:last").show(1000);
      $("#new-content").val("")
      $(".message-content-valid").hide();
      $("#message_picture_picture_content").val("")
    }).on("ajax:error", function(e, xhr, status, error) {
      return $(fridge).append("<p class='message-content-valid'>Message length must be 6</p>");
    });
});
