$(document).ready(function() {

  $(document).on("click", ".issue-mark", function(e){
  	e.preventDefault();
  	var form = $(this).parent().find("form.event_issue");
	if (form.css("display")=="none"){
		form.css("display", "block");
	} else {
		form.css("display", "none");
	}
  });

  $("form.event_issue").submit(function(e){
	e.preventDefault();
	var form = $(this);
	var list = form.parent().find("div.issue_body");
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
});
