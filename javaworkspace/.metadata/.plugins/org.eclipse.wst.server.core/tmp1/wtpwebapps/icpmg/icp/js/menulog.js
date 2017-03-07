$(function(){
	js_menulog();
});

/**
 * home.html一级菜单添加点击日志
 */
function js_menulog(){
	var span_wrap='';
	/*$('.nav ul li').click(function(){
		span_wrap = $(this).children('a').children('span');
		var tt = span_wrap.html();
		
	});*/
	
	$('.nav ul li').mouseup(function(){
		span_wrap = $(this).children('a').children('span');
		var tt = span_wrap.html();
		firstMenuLog(tt,'1');
	});
}

/**
 * 记录一级日志
 * @param menuName
 * @param menuLevel
 */
function firstMenuLog(menuName,menuLevel){
	$.ajax({
		url:'/icpserver/menulog/oneLevelMenuLog.do',
		type:'post',
		cache:false,
		async:true,
		data:{
			menuName:menuName,
			menuLevel:menuLevel
		},
		success:function(b){
		}
	});
}