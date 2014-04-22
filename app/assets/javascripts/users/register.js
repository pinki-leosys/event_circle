$(document).ready(function() {
    $('#testValidate').click(function() {
        var sEmail = $('#user_email1').val();
        var password = $('#user_password').val();
        var password_confirm = $('#password_confirmation').val();
        var mydropdown = $('#role_dropdown').val();
        var zip = $('#zipcode').val();
        var zipRegex = /^\d{5}$/;   
        var pattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;
        var phone = $('#user_phone1').val();
        var phoneno = /^[0-9-+]+$/;


        if ($.trim(sEmail).length == 0) {
            alert('Please enter valid email address'); 
            return false;
        }
        else if (!pattern.test(sEmail))
        {
            alert("Enter valid Email Address");
            return false;
        }
        else if ($.trim(password).length == 0) {
            alert('Please enter password'); 
            return false;
        }
        else if ($.trim(password_confirm).length == 0) {
           alert('Please enter verify password');
            return false;
        } 
        else if (password != password_confirm ) {
            alert('Password does not match with verify password');
            return false;
        }
        else if (mydropdown.length == 0 || $(mydropdown).val() == "")
        {
            alert("Please select Role");
            return false;
        }
        else if (!zipRegex.test(zip))
        {
            alert("Enter valid zipcode");
            return false;
        }
         else if (!phoneno.test(phone)){ 
            alert("Enter valid Phone number");
            return false;
        }
        else {
            return true;
        }
    });   
});