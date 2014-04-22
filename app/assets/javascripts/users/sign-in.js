$(document).ready(function() {
    $('#btnValidate').click(function() {
        var sEmail = $('#user_email').val();
        var password = $('#password').val();
        if ($.trim(sEmail).length == 0) {
           alert('Please enter valid email address');
            return false;
        }
        else if ($.trim(password).length == 0) {
            alert('Please enter password');
            return false;
        }          
        else if ($('input[name=role]:checked').length<=0) {
            alert("Please select Role");
            return false;
        }   
        else {
            return true;
        }
    });
});