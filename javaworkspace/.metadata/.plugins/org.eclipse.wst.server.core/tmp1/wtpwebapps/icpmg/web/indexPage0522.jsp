<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
</head>
<body>

<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath();
%>
<style type="text/css">
		body{color:#222;-webkit-text-size-adjust:none;}
		body,h1,h2,h3,h4,h5,h6,hr,p,blockquote,dl, dt,dd,ul,ol,li,pre,form,fieldset,legend,button,input,textarea,th,td,iframe{margin:0; padding:0;}
		h1,h2,h3,h4,h5,h6{font-size:100%;}
		body,button,input,select,textarea {font-family:Tahoma,Arial,Roboto,”Droid Sans”,”Helvetica Neue”,”Droid Sans Fallback”,”Heiti SC”,sans-self;font-size:62.5%; line-height:1.5;}
		ol,ul{list-style:none;}
		
		html,body{ width:100%; height:100%; overflow:hidden;}
		.section-wrap{ width:100%;height:100%;overflow:visible;transition:transform 1s cubic-bezier(0.86,0,0.03,1);-webkit-transition:-webkit-transform 1s cubic-bezier(0.86,0,0.03,1);}
		.section-wrap .section{ position:relative; width:100%; height:100%; background-position:center center; background-repeat:no-repeat;}
		.section-wrap .section .title{width:100%;position:absolute;top:10%;color:#fff;font-size:2.4em;text-align:center;}
		.section-wrap .section .title p{ padding:0 4%;opacity:0}
		.section-wrap .section .title.active .tit{ opacity:1;transform:translateY(-25px);-webkit-transform:translateY(-25px);transition:all 2s cubic-bezier(0.86,0,0.8,1);-webkit-transition:all 2s cubic-bezier(0.86,0,0.8,1);}
		.put-section-0{ transform:translateY(0);-webkit-transform:translateY(0);}
		.put-section-1{ transform:translateY(-100%);-webkit-transform:translateY(-100%);}
		.put-section-2{ transform:translateY(-200%);-webkit-transform:translateY(-200%);}
		.put-section-3{ transform:translateY(-300%);-webkit-transform:translateY(-300%);}
		.put-section-4{ transform:translateY(-400%);-webkit-transform:translateY(-400%);}
		.section-btn{ width:80px;position:fixed;right:4%;top:50%;}
		.section-btn li2{ width:44px;height:44px;cursor:pointer;text-indent:-9999px;
		/* border-radius:50%;
		-webkit-border-radius:50%; */
		margin-bottom:12px; 
		 background:#BD362F;
		text-align:center; color:#fff; onsor:pointer;}
		
		.section-btn li.on{ background:#fff}
		.section-btn li{ background:#BD362F; opacity:1;animation:arrow 3s cubic-bezier(0.5,0,0.1,1) infinite;
	/* 	-webkit-animation:arrow 3s cubic-bezier(0.5,0,0.1,1) infinite; */
		transform:rotate(-90deg);
		-webkit-transform:rotate(-90deg); position:absolute;bottom:10px;left:50%;margin-left:-30px;
		width:80px;height:80px;border-radius:100%;
		-webkit-border-radius:100%;line-height:60px;text-align:center;font-size:20px;color:#fff;border:1px solid #fff;cursor:pointer;overflow:hidden;}
		.arrow:hover{ animation-play-state:paused;-webkit-animation-play-state:paused;}
		@keyframes arrow{ %0,%100{bottom:10px; opacity:1;} 50%{bottom:50px; opacity:.5} }
		@-webkit-keyframes arrow{ %0,%100{bottom:10px; opacity:1;} 50%{bottom:50px; opacity:.5} }
	</style>

<style>
    .ppss{width:753px;height:300px;}
	.ppss h2{padding:0;margin:0;height:20px;width:500px;}
    .box{
		width:48%;height:45%;
		//float:left;
		margin:5px 5px;
		
		overflow:hidden;
	}
	.box-use {
		background: url("images/server-use.jpg") no-repeat center center
		#41B0BD;
	}
	.box-left{
		float:left;width:30%;height:100%;
		vertical-align:middle;
		background: url("images/c-server.jpg") no-repeat center center
		#42B0BD;
	}
	.bg-percentage .box-left {
	background: url("images/server-percent.jpg") no-repeat center
		center #2F9DEC;
	}

	.bg-server .box-left {
	background: url("images/server.jpg") no-repeat center center
		#826BBB;
	}
	
	
	.bg-use .box-left {
		background: url("images/server-use.jpg") no-repeat center center
		#41B0BD;
	}
	.box-right{
		color:#fff;float:left;height:100%;width:70%;background:#61C6D0;
	}
	.bg-percentage .box-right{
		background:#49B7F2;
	}
	.bg-server .box-right{
		background:#A08BCE;
	}
	.server-use .box-right{
		background:#4DB8C8;
	}
	.box-right .nums{
		font-size:28px;
	}
	.box-right p{
		/* margin:10px 0px 10px 10px; */
	}
	.box-right .center{
		text-align:center;
	}
	
	</style>

<style>
* {
	padding: 0;
	font-size: 9pt;
}

.contact {
	width: 960px;
	border: solid 1px #ccc;
}

.leftside {
	width: 200px;
	float: left;
	//background: #CCC;
	height: 100px;
}

.rightside {
	height: 100px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/easyui-1.4/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/easyui-1.4//themes/icon.css" />

<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/easyui-1.4//themes/icon.css" />


<script type="text/javascript"
	src="<%=contextPath%>/logreg/js/jquery-1.8.3.min.js"></script>

<script type="text/javascript"
	src="<%=contextPath%>/easyui-1.4/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=contextPath%>/highchart/highcharts.js"></script>
<script src="<%=contextPath%>/highchart/highcharts-more.js"></script>
<script type="text/javascript" src="<%=contextPath%>/highchart/highcharts-3d.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/IndexPage.js"></script>
	
	<section class="section-wrap">
	
<div class="section section-1">
		<div class="leftside" 
			style=" width: 50%;height: 270px;display:inline ; float:left;" >
			<table id="tbsj"  title="资源利用同比图" style="width: 100%; height:100%"
				>
				<thead>
					<tr>
						<th data-options="field:'starttime',width:80,align:'center'" formatter="dateFormat">时间</th>
						<th data-options="field:'poolName',width:80,align:'center'">资源池</th>
						<th data-options="field:'kpiName',width:80,align:'center'">指标</th>
						<th data-options="field:'units',width:80,align:'center'">单位</th>
						<th data-options="field:'nowValue',width:80,align:'center'">当前</th>
						<th data-options="field:'lastValue',width:80">昨天</th>
						<th data-options="field:'pentVal',width:80,align:'center'" formatter="tbsjFormatPrice">同比</th>
					</tr>
				</thead>
			</table>
		</div>
		<div   class="ppss" style="display:inline ; float:left;width: 50%;">
							<div class="box bg-percentage" style="display:inline ; float:left;">
							<div class="box-left">设备</div>
								<div class="box-right">
									<p>总数
										<span class="nums" id="enum"></span>台
									</p>
									<p>正常
										<span class="nums" id="eoknum"></span>台
									</p>
									<p>故障
										<span class="nums" id="eerrornum"></span>台
									</p>
								</div>
							</div>
							<div class="box  server-use" >
								<div class="box-left">用户</div>
								<div class="box-right box-right-bg-percentage">
									<p>合作
										<span class="nums" id="customnum"></span>
									</p>
									<p>终端
										<span class="nums" id="usernum"> </span>
									</p>
									<p>访问
										<span class="nums" id="usenum"> </span>
									</p>
								</div>
							</div>

							<div class="box bg-server" style="display:inline ; float:left;">
								<div class="box-left">应用</div>
								<div class="box-right">
									<p>总数
										<span class="nums" id="appnum"></span>个
									</p>
									<p>正常
										<span class="nums" id="appoknum"></span>个
									</p>
									<p>故障
										<span class="nums" id="apperrornum"></span>个
									</p>
								</div>
							</div>

							<div class="box" style="margin-top:10px;">
								<div class="box-left">待办</div>
								<div class="box-right">
									<p>开通
										<span class="nums" id="flowoknum"></span>个
									</p>
									<p>故障
										<span class="nums" id="flowerrornum"></span>个
									</p>
								</div>
							</div>

						
					
			
		</div>
	<div style="height:275px"		>
		<div style="padding:5px; width: 850px;height: 275px;display:inline ; float:left;" class="leftside" 		>
		<div id="containerScatter" style="height: 270px;width:850px;  margin: 0 auto"></div>
		</div>
		<div   style="display:inline ; float:left;width:500;">
			<table id="useratio"  title="资源利用率"	style="width: 550px; height: 270px;"  >
				<thead>
					<tr>
						<th data-options="field:'starttime',width:80,align:'center'" >时间</th>
						<th data-options="field:'poolname',width:80,align:'center'">资源池</th>
						<th data-options="field:'cpu',width:80,align:'center'">CPU利用率</th>
						<th data-options="field:'mem',width:80,align:'center'">内存利用率</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	

</div>

<div class="section section-2"  style="margin-top: 50px">
	
	<div id="container" style="min-width: 500px; height: 500px;  position: relative;dispaly:block;"></div>	
	</div>
</section>

<!-- <ul class="section-btn">
	  <li >管理界面</li>
</ul> -->


<script type="text/javascript">

var delayTime;
$.parser.onComplete = function(){
	eqOverview();
    initIndexPage();
}

function eqOverview(){
	$.ajax({
	  		type : 'post',
	  		url:'<%=contextPath%>/eoverview.do',
	  		//data:{apid:$(':input[name="id"]').val()},
	  		success:function(result){
	  				var obj = eval("("+result+")");
	  				$("#enum").html(obj.mapEquipment.eqnum);
	  				$("#eoknum").html(obj.mapEquipment.eqoknum);
	  				$("#eerrornum").html(obj.mapEquipment.eqerrornum)
	  				
	  				$("#appnum").html(obj.mapApp.appnum);
	  				$("#appoknum").html(obj.mapApp.appoknum);
	  				$("#apperrornum").html(obj.mapApp.apperrornum)
	  				
	  				$("#customnum").html(obj.mapUser.customnum);
	  				$("#usernum").html(obj.mapUser.usernum);
	  				$("#usenum").html(obj.mapUser.usenum);
	  				$("#flowoknum").html(obj.mapFlow.flowoknum);
	  				$("#flowerrornum").html(obj.mapFlow.flowerroenum)
	  		}
	  	});
	
}

	 //初始化dategrid   
	$('#useratio').datagrid({   
		fitColumns:true,
		striped:true,
		loadMsg:'正在拼命加载数据',
		border:false,
		singleSelect:true,
		url:'<%=contextPath%>/eoverviewDataGrid.do',
		method:'post',
		pagination:true,
		pagePosition:'bottom',
		pageList:[5,10,15],
	    pageSize:5,   
	    pageNumber:1,   
	    onLoadSuccess:function (data){
	    	console.log(data);
	    },
	  //  rownumbers:true,   
	    doPagination:function(pPageIndex, pPageSize) {   
	        //改变opts.pageNumber和opts.pageSize的参数值，用于下次查询传给数据层查询指定页码的数据   
	        var gridOpts = $('#useratio').datagrid('options');   
	        gridOpts.pageNumber = pPageIndex;   
	        gridOpts.pageSize = pPageSize;     
	       // Exec_Wait('tbsj','loadDateGrid()');   
	    },   
	});    
	
		 function tbsjFormatPrice(val,row){
			 if (row.trend =='-1'){
					return row.pentVal+'<span><img src=\'../images/arrowdown.gif\'>'+'</img><span>';
				} else  if (row.trend =='1'){
					 return row.pentVal+'<span><img src=\'../images/arrowup.gif\'>'+'</img><span>';
				}else{
					 return row.pentVal+'<span><img src=\'../images/arrow0.gif\'>'+'</img><span>';
				}
				
			}
		 function dateFormat(val,row){
			 //var data  = row.starttime;
			// return row.starttime.substr(0,8);
			 
		 }
	 
	//初始化dategrid   
	$('#tbsj').datagrid({   
		fitColumns:true,
		rownumbers:true,
		striped:true,
		loadMsg:'正在拼命加载数据',
		singleSelect:true,
		url:'<%=contextPath%>/tbsjList.do',
		method:'post',
		pagination:true,
		pagePosition:'bottom',
		pageList:[5,10,15],
	    pageSize:5,   
	    pageNumber:1,   
	  //  rownumbers:true,   
	    doPagination:function(pPageIndex, pPageSize) {   
	        //改变opts.pageNumber和opts.pageSize的参数值，用于下次查询传给数据层查询指定页码的数据   
	        var gridOpts = $('#tbsj').datagrid('options');   
	        gridOpts.pageNumber = pPageIndex;   
	        gridOpts.pageSize = pPageSize;     
	       // Exec_Wait('tbsj','loadDateGrid()');   
	    },   
	});    
	function loadDateGrid(){   
	    var gridOpts = $('#tbsj').datagrid('options');   
	    //定义查询条件   
	    //异步获取数据到javascript对象，入参为查询条件和页码信息   
	    //var oData = getAjaxDate("orderManageBuz","qryWorkOrderPaged",queryCondition,gridOpts);   
	    //使用loadDate方法加载Dao层返回的数据   
	   // $('#tt').datagrid('loadData',{"total" : oData.page.recordCount,"rows" : oData.data});   
	}   
	  
	/**
	 * 封装一个公用的方法  
	 * @param {Object} grid table的id  
	 * @param {Object} func 获取异步数据的方法  
	 * @param {Object} time 延时执行时间  
	 */  
	function Exec_Wait(grid,func,time){   
	    var dalayTime = 500;   
	    __func_=func;   
	    __selector_ = '#' + grid;   
	    $(__selector_).datagrid("loading");   
	    if (time) {   
	        dalayTime = time;   
	    }   
	    gTimeout=window.setTimeout(_Exec_Wait_,dalayTime);   
	}   
	function _Exec_Wait_(){   
	    try{eval(__func_);   
	    }catch(e){   
	        alert("__func_:" + __func_ + ";_ExecWait_" + e.message);   
	    }finally{   
	        window.clearTimeout(gTimeout);   
	        $(__selector_).datagrid("loaded");   
	    }   
	}  
	
	
	
	
</script>
<script type="text/javascript">
	var urlrootpath = "${pageContext.request.contextPath}";

	//此处引用：鼠标滚轮mousewheel插件
	!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof exports?module.exports=a:a(jQuery)}(function(a){function b(b){var g=b||window.event,h=i.call(arguments,1),j=0,l=0,m=0,n=0,o=0,p=0;if(b=a.event.fix(g),b.type="mousewheel","detail"in g&&(m=-1*g.detail),"wheelDelta"in g&&(m=g.wheelDelta),"wheelDeltaY"in g&&(m=g.wheelDeltaY),"wheelDeltaX"in g&&(l=-1*g.wheelDeltaX),"axis"in g&&g.axis===g.HORIZONTAL_AXIS&&(l=-1*m,m=0),j=0===m?l:m,"deltaY"in g&&(m=-1*g.deltaY,j=m),"deltaX"in g&&(l=g.deltaX,0===m&&(j=-1*l)),0!==m||0!==l){if(1===g.deltaMode){var q=a.data(this,"mousewheel-line-height");j*=q,m*=q,l*=q}else if(2===g.deltaMode){var r=a.data(this,"mousewheel-page-height");j*=r,m*=r,l*=r}if(n=Math.max(Math.abs(m),Math.abs(l)),(!f||f>n)&&(f=n,d(g,n)&&(f/=40)),d(g,n)&&(j/=40,l/=40,m/=40),j=Math[j>=1?"floor":"ceil"](j/f),l=Math[l>=1?"floor":"ceil"](l/f),m=Math[m>=1?"floor":"ceil"](m/f),k.settings.normalizeOffset&&this.getBoundingClientRect){var s=this.getBoundingClientRect();o=b.clientX-s.left,p=b.clientY-s.top}return b.deltaX=l,b.deltaY=m,b.deltaFactor=f,b.offsetX=o,b.offsetY=p,b.deltaMode=0,h.unshift(b,j,l,m),e&&clearTimeout(e),e=setTimeout(c,200),(a.event.dispatch||a.event.handle).apply(this,h)}}function c(){f=null}function d(a,b){return k.settings.adjustOldDeltas&&"mousewheel"===a.type&&b%120===0}var e,f,g=["wheel","mousewheel","DOMMouseScroll","MozMousePixelScroll"],h="onwheel"in document||document.documentMode>=9?["wheel"]:["mousewheel","DomMouseScroll","MozMousePixelScroll"],i=Array.prototype.slice;if(a.event.fixHooks)for(var j=g.length;j;)a.event.fixHooks[g[--j]]=a.event.mouseHooks;var k=a.event.special.mousewheel={version:"3.1.12",setup:function(){if(this.addEventListener)for(var c=h.length;c;)this.addEventListener(h[--c],b,!1);else this.onmousewheel=b;a.data(this,"mousewheel-line-height",k.getLineHeight(this)),a.data(this,"mousewheel-page-height",k.getPageHeight(this))},teardown:function(){if(this.removeEventListener)for(var c=h.length;c;)this.removeEventListener(h[--c],b,!1);else this.onmousewheel=null;a.removeData(this,"mousewheel-line-height"),a.removeData(this,"mousewheel-page-height")},getLineHeight:function(b){var c=a(b),d=c["offsetParent"in a.fn?"offsetParent":"parent"]();return d.length||(d=a("body")),parseInt(d.css("fontSize"),10)||parseInt(c.css("fontSize"),10)||16},getPageHeight:function(b){return a(b).height()},settings:{adjustOldDeltas:!0,normalizeOffset:!0}};a.fn.extend({mousewheel:function(a){return a?this.bind("mousewheel",a):this.trigger("mousewheel")},unmousewheel:function(a){return this.unbind("mousewheel",a)}})});

	$(function(){
		var i=0;
		/*   $btn = $('.section-btn li'),*/
		 var	$wrap = $('.section-wrap'),
			$arrow = $('.arrow');
		var length = $(".section").length;//一共有几个 section 
		
		/*当前页面赋值*/
		function up(){i++;if(i==length){i=0};}
		function down(){i--;if(i<0){i=length-1};}
		
		/*页面滑动*/
		function run(){
			//$btn.eq(i).addClass('on').siblings().removeClass('on');	
			$wrap.attr("class","section-wrap").addClass(function() { return "put-section-"+i; }).find('.section').eq(i).find('.title').addClass('active');
		};
		
		/*右侧按钮点击*/
	<%-- 	$btn.each(function(index) {
			$(this).click(function(){
				var url="<%=contextPath%>/web/Frames/authBase.jsp";
				 window.location.href=url;
			})
		}); --%>
		
		/*翻页按钮点击
		$arrow.one('click',go);
		function go(){
			up();run();	
			setTimeout(function(){$arrow.one('click',go)},1000)
		};
		*/
		/*响应鼠标*/
		$wrap.one('mousewheel',mouse_);
		function mouse_(event){
			if(event.deltaY<0) {up()}
			else{down()}
			run();
			setTimeout(function(){$wrap.one('mousewheel',mouse_)},1000)
		};
		
		/*响应键盘上下键*/
		$(document).one('keydown',k);
		function k(event){
			var e=event||window.event;
			var key=e.keyCode||e.which||e.charCode;
			switch(key)	{
				case 38: down();run();	
				break;
				case 40: up();run();	
				break;
			};
			setTimeout(function(){$(document).one('keydown',k)},1000);
		}
	});
</script>
</body>
</html>