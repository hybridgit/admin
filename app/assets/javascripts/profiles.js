$(document).ready(function(){
  $("td input:checkbox").change(function(e){
    var profile_id = $(this).val();
    var checked = $(this).prop("checked");
    // Get data about the selected option
    $.ajax({
      url: "/profiles/" + profile_id + "/activate",
      data: {
        is_active: checked
      },
      success: function(response){
        if(response.status){
          Materialize.toast('Driver:&nbsp;<strong> ' + response.profile + '</strong>&nbsp; Activated!', 4000);
        } else {
          Materialize.toast('Driver:&nbsp;<strong> ' + response.profile + '</strong>&nbsp;Deactivated!', 4000);
        }
      },
      dataType: 'json'
    });
  });
});
