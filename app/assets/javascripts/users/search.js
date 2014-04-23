$(document).ready(function()
{
  $("#validate-search").click(function() {
        var search = $('#search').val();

        if ($.trim(search).length == 0) {
            alert('Please enter text to search'); 
            return false;
        }
   });
});
