$(document).ready(function(){
var a = 1;
$(".header1").click(function(){
	
	if(false==$(this).hasClass('expand')){

		$(".table-dummy").show();
	    $(".table-main").hide();
	    $(".dataTables_wrapper").hide();
		$(this).children(".table-dummy").hide();
		$(this).children(".table-main").show();
		div = $(this).children('.dataTables_wrapper');

		$(div).show().children(".table-main").show();

$(".header1").addClass("fixed")
$(".header1").removeClass("expand")
$(this).addClass( "expand");

$(this).children(".table-main").dataTable({
    sPaginationType: "full_numbers",
    bJQueryUI: true,
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $(this).children(".table-main").data('source')
  });

	}
		
});
});
