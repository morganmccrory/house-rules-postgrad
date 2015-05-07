$(document).ready(function() {

  $(".options-button").on("click", function(e){ // binding onclick
        e.preventDefault();
        $(".options-parts").slideDown(200)
         e.stopPropagation();
     });

     $("body").click(function () { // binding onclick to body
         $(".options-parts").slideUp(100); // hiding popups
     });

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

  var list = $("#rule-list")

  $(".new_rule").on("ajax:success", function(e, data, status, xhr) {
    list.append(xhr.responseText);
    list.find(".header-empty").hide();
    list.find(".rule-table:last").hide();
    list.find(".rule-table:last").show(1000);
    $(".rule-fields").val("")
    $(".rule-length").css("display", "none")
  }).on("ajax:error", function(e, xhr, status, error) {
    return $("#new_rule").prepend("<p class='rule-length'>Must be a length of 6 or greater.</p>");
  });
});
