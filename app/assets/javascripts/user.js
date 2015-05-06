$(document).ready(function() {


  $("#edit_user_info_user_page").on("click", function(event) {
    event.preventDefault();
    var form = $("#edit_user_info_user_page_form")
    console.log(">>>>>>>>>>>>>>>>>>>>");
    if (form.css("display")=="none"){
    $("#edit_user_info_user_page_form").css("display", "block")}
    else {
      form.css("display", "none")
    }
  })
});
