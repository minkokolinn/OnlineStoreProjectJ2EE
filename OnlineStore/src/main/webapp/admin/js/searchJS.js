/**
 * 
 */
 $(document).ready(function(){
  $("#mySearchBox").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#mySearchTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});