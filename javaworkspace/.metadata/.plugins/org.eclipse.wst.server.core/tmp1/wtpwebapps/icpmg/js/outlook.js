var _menus;
$(document).ready(function(){
//////////////////////////////////////////////
	$.ajaxSetup({ 
		 error: function (XMLHttpRequest, textStatus, errorThrown){
				//if(XMLHttpRequest.status==403){
				//	alert('您没有权限访问此资源或进行此操作');
				//	return false;
				//}
			if(XMLHttpRequest.status==999){
				  var top = getTopWinow(); //获取当前页面的顶层窗口对象
	   		      //alert('登录超时, 请重新登录.'); 
	   	          top.location.href=urlrootpath+"/login.jsp"; //跳转到登陆页面
			}
			  
			},
		//请求成功后触发
		success: function (data) {
			
			},
		complete: function (xhr, status) {
			
			if(xhr.status==999){
				  var top = getTopWinow(); //获取当前页面的顶层窗口对象
	   		      //alert('登录超时, 请重新登录.'); 
	   	          top.location.href=urlrootpath+"/login.jsp"; //跳转到登陆页面
			}
			}
			
	}); 
$.ajax({  
    url:urlrootpath+'/authMgr/getRootMenu.do',  
    type:'post',  
    async: false,  
    dataType:'text',  
    success:function(data){ 
    	_data = eval("(" + data + ")"); 
    	var html =""; 
    	//alert(_data.rootmenu);
      $.each(_data.rootmenu,function(i,item){
    	         
    	  html += "<li><a name=\""+item.menuid+"\" href=\"javascript:;\" url="+item.menuurl+" title=\""+item.menuname+"\">"+item.menuname+"</a></li>";
       });
      // var html ="<li><a class=\"active\" name=\"1001\" href=\"javascript:;\" title=\"业务管理\">业务管理</a></li>"+
		//		"<li><a name=\"point\" href=\"javascript:;\" title=\"系统管理\">系统管理</a></li>"+
		//		"<li><a name=\"point1\" href=\"javascript:;\" title=\"资源管理\">资源管理</a></li>"+
		//		"<li><a name=\"point2\" href=\"javascript:;\" title=\"指标管理\">指标管理</a></li>"+
		//		"<li><a name=\"point3\" href=\"javascript:;\" title=\"运营门户\">运营门户</a></li>"+
		//		"<li><a name=\"point4\" href=\"javascript:;\" title=\"电子运维\">电子运维</a></li>";
      	//alert(html);
		 $("#css3menu").append(html);
		 $('#css3menu a:first').addClass('active');
       //alert(_menus);
    } 
});

$.ajax({  
    url:urlrootpath+'/authMgr/getshowBaseFuntion.do',   
    type:'post',  
    async: false,  
    dataType:'text',  
    success:function(data){ 
    	//alert(data);
       _menus = eval("(" + data + ")");
       init();
    }  
});

	/*获取一级菜单id和名称*/
	$('#css3menu li a').click(function(){
		var menuname = $(this).html();
		var menuid = $(this).attr('name');
		menuLog(menuid,menuname);
	});
	
	/*获取二级菜单*/
	$('#wnav').accordion({
		onSelect:function(title,index){
			var m = title.match(/<span[^>]*>([\s\S]*?)<\/span>/);
			var secondMenu = m[1];
			secndMenuLog(secondMenu);
		}
	});
});

/*一级菜单日志*/
function menuLog(menuid,menuname){
	$("#overview").hide();
	$.ajax({
		url:urlrootpath+'/menuLog/firstMenuLog.do',
		type:'post',
		cache:false,
		async:true,
		data:{
			mid:menuid,
			mname:menuname
		},
		success:function(b){
		}
	});
}
/*二级菜单日志*/
function secndMenuLog(menuname){
	$.ajax({
		url:urlrootpath+'/menuLog/secondMenuLog.do',
		type:'post',
		cache:false,
		async:true,
		data:{
			mname:menuname
		},
		success:function(b){
		}
	});
}
/** 
* 在页面中任何嵌套层次的窗口中获取顶层窗口 
* @return 当前页面的顶层窗口对象 
*/
function getTopWinow(){  
var p = window;  
while(p != p.parent){  
   p = p.parent;  
}  
return p;  
}  

/////////////////////////////////////////////

function init() {

	
	$('#css3menu a').click(function() {
		
		$('#css3menu a').removeClass('active');
		$(this).addClass('active');
		
		$('body').layout('show','west'); 
		$("#shouyeframe").attr("src","");
		$("#title").show();
		$("#centerTab").show();
		 $("#shouye").hide();
		 
		var d = _menus[$(this).attr('name')];
		Clearnav();
		addNav(d);
		var url = $(this).attr("url");
		$('#title').hide();
		 $("#centerTab").css({
             "padding-top": "0px",
             "margin-top": "0px"
         });
		$('#centerTab').panel({
		href:urlrootpath+'/'+url
		});	
		InitLeftMenu();
	});

	// 导航菜单绑定初始化
	$("#wnav").accordion({
		animate : false,
		onAdd : function(panel) {
			
		},
		onSelect:function(title,index){
			pp = $('#wnav').accordion('getSelected');
			if (pp) {
				$('#title').hide();
				$('#centerTab').panel({
					href:urlrootpath+'/'+pp.attr('id')
					});	
			}
		}
	});

	var firstMenuName = $('#css3menu a:first').attr('name');
	addNav(_menus[firstMenuName]);
	InitLeftMenu();
}

function Clearnav() {
//	var pp = $('#wnav').accordion('panels');
//
//	$.each(pp, function(i, n) {
//		if (n) {
//			var t = n.panel('options').title;
//			$('#wnav').accordion('remove', t);
//		}
//	});
	//debugger;
	for(var i=$('#wnav').accordion('panels').length-1;i>=0;i--)
	{
		$('#wnav').accordion('remove', i);
	}

	var pp = $('#wnav').accordion('getSelected');
	if (pp) {
		var title = pp.panel('options').title;
		$('#wnav').accordion('remove', title);
	}
}

function addNav(data) {

	$.each(data, function(i, sm) {
		var menulist = "";
		menulist += '<ul name="'+sm.menuname+'">';
		$.each(sm.menus, function(j, o) {
			menulist += '<li><div ><a ref="' + o.menuid + '" href="#" rel="'
					+ urlrootpath+'/'+o.url + '" ><img src="'+urlrootpath+'/images/unselect/'+o.icon+'" style="width:18px;height:18px;align:center" />&nbsp;&nbsp;<span style="color: #fff;font-size:14px" class="">' + o.menuname
					+ '</span></a></div></li> ';
		});
		menulist += '</ul>';
		$('#wnav').accordion('add', {
			title : '<img src="'+urlrootpath+'/images/unselect/'+sm.icon+'" style="width:18px;height:18px" />&nbsp;&nbsp;<span style="color: #fff;font-size:15px">'+sm.menuname+ '</span>',
			content : menulist,
			id:sm.menuurl
			//iconCls:"icon-nav"
		});

	});

	var pp = $('#wnav').accordion('panels');
	if(null!=pp[0])
	{
		var t = pp[0].panel('options').title;
		$('#wnav').accordion('select', t);
	}

}

// 初始化左侧
function InitLeftMenu() {
	
	hoverMenuItem();
	$('#wnav li a').click(function() {
		//change icons
		$('#wnav ul').find('img').each(function(){
			//debugger;
			//alert(":"+$(this).parent()[0].innerHTML);
			$(this).attr("src",$(this).attr("src").replace('selected','unselect'));
			
		});
		
	    $(this).find('img').attr("src", $(this).find('img').attr("src").replace('unselect','selected'));
		//change text
	    $('#wnav ul').find('span').each(function(){
	    		//debugger;
	    	  $(this).css("color","#fff");
		});
		
	    $(this).find('span').css("color","#0d5d9e");
		
	    
		//title处理
		$('#titletd').text('');
		$('#titleimg').attr("src",$(this).find('img').attr("src").replace("unselect","selected"));
		//var str = $(this).find('img').attr("src").replace("unselect","selected");
		$('#titletd').append($(this).parent().parent().parent().attr("name")+'&nbsp;&gt;&nbsp;<span class="ys_06">'+$(this).find('span')[0].innerText+'</span>');
		$('#title').show();
		$("#centerTab").css({
            "padding-top": "58px",
            "margin-top": "-48px"
        });

		var url = $(this).attr("rel");
		$('#centerTab').panel({
		href:url
		});	
		//$('#centerTab').panel('refresh',url);
		//addTab(tabTitle, url, icon);
		$('#wnav li div').removeClass("selected");
		$(this).parent().addClass("selected");
	});
//导航菜单绑定初始化  滑动效果
	//$(".easyui-accordion1").accordion({height:50});
}

/**
 * 菜单项鼠标Hover
 */
function hoverMenuItem() {
	$(".easyui-accordion1").find('a').hover(function() {
		$(this).parent().addClass("hover");
	}, function() {
		$(this).parent().removeClass("hover");
	});
}

// 获取左侧导航的图标
/*function getIcon(menuid) {
	var icon = 'icon ';
	$.each(_menus, function(i, n) {
		$.each(n, function(j, o) {
			$.each(o.menus, function(k, m){
				if (m.menuid == menuid) {
					icon += m.icon;
					return false;
				}
			});
		});
	});
	return icon;
}
 */
function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
	return s;
}

// 弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
	$.messager.alert(title, msgString, msgType);
}

