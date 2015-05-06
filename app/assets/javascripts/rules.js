$(document).ready(function() {

  $(document).on("click", "img.issue-mark", function(e){
  	e.preventDefault();
  	var form = $(this).parent().parent().find("form.rule_issue");
   if (form.css("display")=="none"){
    form.css("display", "block");
  } else {
    form.css("display", "none");
  }
});

  $("form.rule_issue").submit(function(e){
   e.preventDefault();
   var form = $(this);
   var list = form.parent().parent().find("div.rule-issue");
   $.ajax({
     url: form.attr("action"),
     method: form.attr("method"),
     data: form.serialize(),
     success: function(response){
       list.prepend(response);
       form[0].reset();
       form.css("display","none");
     }
   });
 });

  $(".new_rule").on("ajax:success", function(e, data, status, xhr) {
    $("#rule_list").append(xhr.responseText);
    $("#rule_list").find(".rule-table:last").hide();
    $("#rule_list").find(".rule-table:last").show(1000);
    $(".rule_fields").val("")
    $(".rule-length").css("display", "none")
    return console.log("stuff", xhr.responseText);
  }).on("ajax:error", function(e, xhr, status, error) {
    return $("#new_rule").prepend("<p class='rule-length'>Must be a length of 6 or greater.</p>");
  });

  $('.delete-button').click(function(e) {
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
