//滚动导航，子页面引入
var offsetList = [];
$(document).ready(function(){
	$("h3").each(function(idx, dom){
	  var a = $(this).find("a[class=bar]");
	  if(a.length>0){
		  offsetList[idx] = {
			      name : a.attr("name"), 
			      offsetTop : a[0].offsetTop
		};
	  }
	});
});
function scroll2Pos (idx) {
	idx = idx-1;
		if(offsetList.length>0&&offsetList[idx]){
			 $(parent.document.body).animate(
			            {scrollTop: offsetList[idx].offsetTop+60},
			            500
			        );
		}
}