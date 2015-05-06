$(document).ready(function(){
  $("a.postfix").click(function(e){
    e.preventDefault();

    var data = $("form#search-form").find("#search").val();
    var form = $("form#search-form");

    $.get("/houses/search/"+data).done(function(response){

      var housesListContainer = $("#houses-container");
      housesListContainer.html("");

      if (response=="No") {
        $("#search").css('border','1px solid red');
        var title = _.template('<h3>No House Found</h3>');
        housesListContainer.append(title());
        form[0].reset();
      } else {
        $("#search").css('border','1px solid lightgray');
        var title = _.template('<h3>Searched House</h3>');
        housesListContainer.append(title());
        var template = _.template('<%= name %> <a href="/houses/<%= id %>/join">Join</a><br>');
        response.forEach(function(houseData){
        housesListContainer.append(template(houseData));
        form[0].reset();
      })       
      }
    })
  })
})