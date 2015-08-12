$(document).ready(function(){
    $(".card-action .btn").click(function(e){
      e.preventDefault();
      $("form").trigger("submit");
    });
});
