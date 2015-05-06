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

$(document).on("click", ".delete-button", function(e) {
  // $('.delete-button').click(function(e) {
    e.preventDefault();
    var parent = $(this).parent().parent().parent().parent();
    var url = $(this).attr("id")
    $.ajax({
      type: 'DELETE',
      url: url,
      beforeSend: function() {
        parent.css("background-color", "#E6E6FA");
      },
      success: function() {
        parent.slideUp(300,function() {
          parent.remove();
        });
      }
    });
  });
});
