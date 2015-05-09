$(document).ready(function() {

  $("body").on("click", ".options-button", function(e){ // binding onclick
        e.preventDefault();
        var optionsMenu = $(this).next(".options-parts")
        if(optionsMenu.css("display") == "none"){
          optionsMenu.slideDown(200);
        } else {
          optionsMenu.slideUp(100);
          $(this).parent().parent().parent().parent().find(".rule-edit-form").hide();
          $(this).parent().parent().parent().parent().find(".rule-issue-form").hide();
          $(this).parent().parent().parent().parent().find(".rule-issue").hide();
        }
         e.stopPropagation();
     });

  $("body").on("click", ".rule-edit-button", function(e) {
    e.preventDefault();
    var ruleEditForm = $(this).parent().parent().parent().parent().parent().parent().find(".rule-edit-form")

    if(ruleEditForm.css("display") == "none"){
      ruleEditForm.slideDown(200);
    } else {
      ruleEditForm.slideUp(200);
    }
    e.stopPropagation();
  });

  $("body").on("click", ".rule-issue-button", function(e) {
    e.preventDefault();
    var ruleIssueForm = $(this).parent().parent().parent().parent().parent().parent().find(".rule-issue-form")

    if(ruleIssueForm.css("display") == "none"){
      ruleIssueForm.slideDown(200);
    } else {
      ruleIssueForm.slideUp(200);
    }
    e.stopPropagation();
  });

  $("body").on("click", ".issue-button", function(e) {
    e.preventDefault();
    var ruleIssue = $(this).parent().parent().parent().parent().parent().find(".rule-issue")

    if(ruleIssue.css("display") == "none"){
      ruleIssue.slideDown(200);
    } else {
      ruleIssue.slideUp(200);
    }
    e.stopPropagation();
  });

  $("body").on("submit", "form.rule-edit-form", function(e){
    e.preventDefault();
    var form = $(this);
    var ruleTitle = form.parent().find(".rule-title");
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
    e.stopPropagation();

    var parent = $(this).parent().parent().parent().parent().parent().parent().parent();
    var url = $(this).attr("id")
    var confirmed = confirm("Are you sure?");

    if(confirmed) {
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
    }
  });
});
