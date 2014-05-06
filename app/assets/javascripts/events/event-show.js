$(document).ready(function() {
    $('.playuservideo').click(function() {
      $('#playallmodal').modal('show');      
       var videopath=$(this).data('videopath');
       jwplayer('myElement').setup({'flashplayer': "/assets/flash.swf", 'id': 'playerID', 'width': '540','height': '360', 'file': videopath });
    });
    $(".uploadmedia").click(function(){
      $("#myModal").modal("show");
    });
    $(".uploadvideo").click(function(){
      $("#myVideo").modal("show");
    });

    });



