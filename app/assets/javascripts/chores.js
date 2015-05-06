$(document).ready(function() {

    $(document).on("click", "img.issue-mark", function(e) {
        e.preventDefault();
        var form = $(this).parent().find("form.chore_issue");
        if (form.css("display") == "none") {
            form.css("display", "block");
        } else {
            form.css("display", "none");
        }
    });

    $(".view_chore_issues").click(function(){
        $(this).siblings(".view_issues").toggle();
    });
     $(".view_chore_promises").click(function(){
        $(this).siblings(".view_promises").toggle();
    });


    $("form.chore_issue").submit(function(e) {
        e.preventDefault();
        var form = $(this);
        var list = form.parent().find("div.issue_body");
        $.ajax({
            url: form.attr("action"),
            method: form.attr("method"),
            data: form.serialize(),
            success: function(response) {
                list.append(response);
                form[0].reset();
                form.css("display", "none");
            }
        });
    });
});