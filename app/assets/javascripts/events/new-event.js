$(document).ready(function() {
  $(".eventvalidate").click(function() {
        var today = new Date();
        var title = $('#event_title').val();
        var description = CKEDITOR.instances.event_description.updateElement();
        var desc = $('#event_description').val();
        var address = $('#event_address_address').val();
        var zipcode = $('#event_address_zipcode').val();
        var state = $('#address_state').val();
        var city = $('#address_city').val();
        var zipRegex = /^\d{5}$/; 
        var startDate = new Date($('#event_start_date').val());
        var endDate = new Date($('#event_end_date').val());


        if ($.trim(title).length == 0) {
            alert('Please enter Title'); 
            return false;
        }
        else if (desc == '') {
            alert('Please enter Description'); 
            return false;
        }
        else if ($.trim(address).length == 0) {
            alert('Please enter Address'); 
            return false;
        }
       else if (($.trim(zipcode).length == 0) || (!zipRegex.test(zipcode)))
        {
            alert("Enter a valid zipcode");
            return false;
        }
        else if ($.trim(city).length == 0) {
            alert('Please enter city'); 
            return false;
        }
        else if (state.length == 0 || $(state).val() == "")
        {
            alert("Please select State");
            return false;
        }
         else if (startDate < today){ 
              alert('Start date must be today or later');
              return false;
            }
        else if (endDate == "Invalid Date" || startDate == "Invalid Date"){ 
              alert('Enter Start date and End date');
              return false;
            }
        else if (startDate != '' && endDate !='') {
           if (Date.parse(startDate) > Date.parse(endDate)) {
               $("event_end_date").val('');
               alert("Start date should not be greater than end date");
               return false;
           }
           else if (Date.parse(startDate) < today){ 
              alert('End date must be today or later');
              return false;
            }     
       }
       
    });
 
});

 $(function () {
                $('#datetimepicker1').datetimepicker();
                $('#datetimepicker2').datetimepicker();                
            });