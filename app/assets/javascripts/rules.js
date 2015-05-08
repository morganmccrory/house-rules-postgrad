$(document).ready(function() {

var optionsCount = 1
var issueFormCount = 1
var viewIssueCount = 1
var editCount = 1

  $("body").on("click", ".options-button", function(e){ // binding onclick
        e.preventDefault();
        if( optionsCount%2 != 0 ){
          $(this).next(".options-parts").slideDown(200);
          optionsCount += 1;
        } else {
          $(this).next(".options-parts").slideUp(100);
          $(this).parent().parent().parent().parent().parent().parent().find(".rule-issue-form").hide();
          $(this).parent().parent().parent().parent().parent().find(".rule-issue").hide();
          optionsCount += 1;
        }
         e.stopPropagation();
     });

  $("body").on("click", ".rule-edit-button", function(e) {
    e.preventDefault();
    if( editCount%2 != 0 ){
      $(this).parent().parent().parent().parent().parent().parent().find(".rule-edit-form").slideDown(200);
      editCount += 1;
    } else {
      $(this).parent().parent().parent().parent().parent().parent().find(".rule-edit-form").slideUp(200);
      editCount += 1;
    }
    e.stopPropagation();
  });

  $("body").on("click", ".rule-issue-button", function(e) {
    e.preventDefault();
    if( issueFormCount%2 != 0 ){
      $(this).parent().parent().parent().parent().parent().parent().find(".rule-issue-form").slideDown(200);
      issueFormCount += 1;
    } else {
      $(this).parent().parent().parent().parent().parent().parent().find(".rule-issue-form").slideUp(200);
      issueFormCount += 1;
    }
    e.stopPropagation();
  });

  $("body").on("click", ".issue-button", function(e) {
    e.preventDefault();
    if( viewIssueCount%2 != 0 ){
    $(this).parent().parent().parent().parent().parent().find(".rule-issue").slideDown(200);
    viewIssueCount += 1
    } else {
    $(this).parent().parent().parent().parent().parent().find(".rule-issue").slideUp(200);
    viewIssueCount += 1
    }
    e.stopPropagation();
  });

  $("body").on("submit", "form.rule-edit-form", function(e){
    e.preventDefault();
    var form = $(this);
    var ruleTitle = form.parent();
    $.ajax({
      url: form.attr("action"),
      method: form.attr("method"),
      data: $(this).serialize()
    }).success(function(response){
      form.hide();
      ruleTitle.html("")
      ruleTitle.append(response.rule.content);
    });
    e.stopPropagation();
  });

  $("body").on("submit", "form.rule-issue-form", function(e){
    e.preventDefault();
    var form = $(this);
    var issueList = form.parent().parent().find("div.rule-issue");
    $.ajax({
      url: form.attr("action"),
      method: form.attr("method"),
      data: $(this).serialize()
    }).success(function(response){
      form.hide();
      issueList.show();
      issueList.find("p").hide();
      issueList.prepend("<font color='green'>Your issue has been added!</font><br><br>");
      issueList.append(response.issue.reason + "<br>").css({ 'font-weight': 'bold' });
    });
    e.stopPropagation();
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
    e.stopPropagation();
  });

  $("body").on("click", ".delete-button", function(e) {
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
});
