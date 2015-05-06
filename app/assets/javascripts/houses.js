$(document).ready(function() {


  $("#edit-house-link").on("click", function(event) {
    event.preventDefault();
    if ($("#edit-house-form-div").css("display")=="none"){
      $("#edit-house-form-div").css("display", "block")
    } else {
      $("#edit-house-form-div").css("display", "none")
    }
  })

  $("#edit-house-manager-link").on("click", function(event) {
    event.preventDefault();
    if ($("#edit-house-manager-form-div").css("display")=="none"){
    $("#edit-house-manager-form-div").css("display", "block")
    } else {
      $("#edit-house-manager-form-div").css("display", "none")
    }
  })
});
