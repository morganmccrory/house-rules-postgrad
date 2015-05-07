$(document).ready(function() {

var count = 1

  $(".options-button").on("click", function(e){ // binding onclick
        e.preventDefault();
        if( count%2 != 0 ){
          $(this).next(".options-parts").slideDown(200);
          count += 1;
        } else {
          $(this).next(".options-parts").slideUp(100);
          count += 1;
        }
         e.stopPropagation();
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

  $(".options-parts").on("click", ".delete-button", function(e) {
    e.preventDefault();
    var parent = $(this).parent().parent().parent().parent().parent().parent().parent();
    var url = $(this).attr("id")
    $.ajax({
      type: 'DELETE',
      url: url,
      beforeSend: function() {
        parent.css("background-color", "#fff5b1");
      },
      success: function() {
        parent.slideUp(300,function() {
          parent.remove();
        });
      }
    });
  });

  $(".options-parts").on("click", ".issue-button", function(e) {
    e.preventDefault();
    $(this).parent().parent().parent().parent().parent().find(".rule-issue").slideDown(200);
  });
});
