$(document).ready(function() {
    $('#contactValidate').click(function() {
        var name = $('#contact_name').val();
        var email = $('#contact_email').val();
        var message = $('#contact_message').val();
        var regxEmail = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;

       if ($.trim(name).length == 0) {
            alert('Please enter Name'); 
            return false;
        }
        else if (!regxEmail.test(email))
        {
            alert("Enter valid Email Address");
            return false;
        }
        else if($.trim(email).length == 0) {
            alert('Please enter valid email address'); 
            return false;
        }
        else if ($.trim(message).length == 0) {
           alert('Please enter Message');
            return false;
        } 
        else {
            return true;
        }
    });   
});