$(function(){
	tcDetail();
});

//套餐配置明细
function tcDetail(){
	$('.slide-box .bd ul li').each(function(index){
		var aobj = $(this).children('a');
		var id = aobj.attr("id");
		aobj.poshytip({
			className: 'tip-skyblue',
			bgImageFrameSize: 9,
			offsetX: 0,
			offsetY: 20,
			content: function(updateCallback) {
				window.setTimeout(function() {
					$.ajax({
						url : "/icpserver/uu/tcDetail.do?shopid="+id,
						cache : false,
						async : false,
						success : function(b) {
							updateCallback(b);
						}
					});
				}, 500);
				return 'Loading...';
			}
		});
	});
}