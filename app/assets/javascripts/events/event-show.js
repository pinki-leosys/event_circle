$(document).ready(function() {
    $('.playuservideo').click(function() {
      $('#playallmodal').modal('show');      
      var videopath=$(this).data('videopath');
      var videotag='<video width="100%" height="70%"  controls>'+
                  '<source src="'+videopath+'" type="video/mp4">'+
                  ' <source src="'+videopath+'" type="video/ogg">'+
                  '  <source src="'+videopath+'" type="video/webm">'+
                  ' <object src="'+videopath+'">'+
                  '<embed src="'+videopath+'">'+
                   '</object> </video>';

      $('#userchoice').html(videotag);
      console.log('this image is '+$(this).id);
      console.log('image src is '+$(this).attr('src'));
      console.log('Description is is '+$(this).data('videopath'));

    });
    $(".uploadmedia").click(function(){
      $("#myModal").modal("show");
    });
    $(".uploadvideo").click(function(){
      $("#myVideo").modal("show");
    });

    })