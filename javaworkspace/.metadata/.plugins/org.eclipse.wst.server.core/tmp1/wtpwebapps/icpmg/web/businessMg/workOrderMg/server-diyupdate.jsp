<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String afterlogin = request.getParameter("afterlogin");
String message = (String)request.getAttribute("message");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <title>浪潮</title>
</head>
<body>
    <script type="text/javascript" src="<%=basePath%>js/scripts/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/scripts/jquery.cookie.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/scripts/jquery.easyui.min.js"></script>
 <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/web/businessMg/workOrderMg/flow2/styles/util.css" /> 
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/web/businessMg/workOrderMg/flow2/styles/gather.css" />
	
	<script type="text/javascript" src="<%=basePath%>/js/scripts/slide.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/scripts/TweenMax.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/scripts/myScroll.js"></script>
	<%-- <script type="text/javascript" src="<%=basePath%>/js/scripts/util.js"></script> --%>
	<script type="text/javascript" src="<%=basePath%>/js/scripts/gather.js"></script>
  <form id="conditionForm2" action="${ctx}/workorder/doOrderChange.do" method="post" onsubmit="">

	<div class="container-wrap" >
		<div class="container">
			
			<div style="float:left;width:885px;/*padding-bottom:9999px;margin-bottom:-9999px;*/">
				<div class="container-cell" style="height:95%;">
					<div class="product-details">
						<div class="product-from-con">
								<img src="${ctx}/web/businessMg/workOrderMg/images/jichupeizhi.png" />
						<div style="">
						    <div class="product-from-row">
								<lable class="product-form-name">CPU :</lable>
								<div class="product-form-cell">
									<ul class="item-01" id="cpuchoose">
									    <li onclick="choosecpu(1)"  value="1"><a href="javascript:void(0)" >1核</a></li>
										<li onclick="choosecpu(2)" class="on"  value="2"><a href="javascript:void(0)">2核</a></li>
										<li onclick="choosecpu(4)" value="4"><a href="javascript:void(0)" >4核</a></li>
										<li onclick="choosecpu(8)" value="8"><a href="javascript:void(0)" >8核</a></li>
										<li onclick="choosecpu(16)" value="16"><a href="javascript:void(0)" >16核</a></li>
										<li onclick="choosecpu(32)" value="32"><a href="javascript:void(0)" >32核</a></li>
									</ul>
								</div>
								<div class="clear"></div>
							</div>
							<div class="product-from-row">
								<lable class="product-form-name">内存 ：</lable>
								<div class="product-form-cell">
									<ul class="item-01" id="memchoose">
										<li class="on" onclick="choosemem('2')" value="2"><a href="javascript:void(0)" >2G </a></li>
										<li onclick="choosemem('4')" value="4"><a href="javascript:void(0)" >4G</a></li>
										<li onclick="choosemem('8')" value="8"><a href="javascript:void(0)" >8G</a></li>
										<li onclick="choosemem('12')" value="12"><a href="javascript:void(0)" >12G</a></li>
										<li onclick="choosemem('16')" value="16"><a href="javascript:void(0)" >16G</a></li>
										<!--<li onclick="choosemem('32')" value="32"><a href="javascript:void(0)" >32G</a></li>
										<li onclick="choosemem('64')" value="64"><a href="javascript:void(0)" >64G</a></li>
									--></ul>
								</div>
								<div class="clear"></div>
							</div>
                            <div class="product-from-row">
                                <lable class="product-form-name">操作系统 ：</lable>
                                <div class="product-form-cell">
                                    <div class="product-sel-system">
                                        <div class='str-select-system'>
                                            <select id='xt' >
                                                <option value="CentOS5.8-64bit">CentOS5.8-64bit</option>
                                                <option value="CentOS6.4-64bit">CentOS6.4-64bit</option>
                                                <option value="CentOS6.5-64bit">CentOS6.5-64bit</option>
                                                <option value="CentOS7.0-64bit">CentOS7.0-64bit</option>
                                                <option value="WinServer08-64bit">WinServer08-64bit</option>
                                                <option value="WinServer12-64bit">WinServer12-64bit</option>
                                                <option value="Windows7-64bit">Windows7-64bit</option>
                                                <option value="Ubuntu12.04">Ubuntu12.04</option>
                                                <option value="Ubuntu14.04">Ubuntu14.04</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <lable class="product-form-name">赠送系统盘 ：</lable>
                                <div class="product-form-cell">
                                    <div class="product-sel-system">
                                        <font id="xtp" size="3">40G</font>
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
							<div class="product-from-row" >
								<lable class="product-form-name" >数据盘：</lable>
								<div class="product-form-cell" id="disk1" >
									<div class="uc-slider1 uc-slider-2">
										<div class="range1 bg-01">
											<span class="block m5" >600G</span>
											<span class="block m200">2000G</span>
										</div>
										<div class="strip">
											<span class="chunk"><!--<div class="val" style="display:block;">0G</div>--></span>
										</div>
									</div>
									<div class="num1"><input id="hard1" value="0" type="text"/>  G</div>
									<div class="close1_1" ></div>
								</div>
								<div class="product-form-cell" style="margin-top:10px;margin-left:97px;" id="disk2">
									<div class="uc-slider1">
										<div class="range1 bg-01">
											<span class="block m5">600G</span>
											<span class="block m200">2000G</span>
										</div>
										<div class="strip"><span class="chunk"></span></div>
									</div>
									<div class="num1"><input id="hard2" type="text" value="0" />  G</div>
									<div class="close1_2" ></div>
								</div>
								<div class="clear"></div>
							</div>
							
							<div id="addDiskDiv" class="product-from-row">
								<div class="product-form-cell">
									<span id="addDisk" class="addDisk" style="margin-left:100px;margin-top:10px;">+增加一块</span>
								</div>
								<div><span style="color: #a4a4a4;">最多有两块数据盘</span></div>
								<div class="clear"></div>
							</div>
							
						</div>
					
							<img src="${ctx}/web/businessMg/workOrderMg/images/wangluo.png" style="" ></img>
								<div style="padding-left: 100px;">
							<div class="product-from-row">
								<lable class="product-form-name">接入模式 :</lable>
								<div class="product-form-cell" style="width:700px;">
									
								<ul class="item-01" name="imodechoose" id="10010">
								    <li ><a href="javascript:void(0)">联通</a></li>
								</ul>
								<div style="float:left;display:inline;margin-left:15px;">
									<lable class="product-form-name" style="width:80px;">公网端口：</lable>
									<div class="num" style="margin-left:0px;"><input type="text" id="ltinterport" value="多个端口请用半角逗号隔开" style="width:200px;height:28px;margin-left:0px;color:#a4a4a4;"/></div>
								</div>
								<div style="float:left;display:inline;margin-left:15px;">
									<lable class="product-form-name" style="width:80px;">公网带宽：</lable>
									<div class="num" style="margin-left:0px;"><input type="text" id="ltinterbw" value="0" style="margin-left:0px;height:28px;"/>  M</div>
								</div>
							</div>
							<div class="product-form-cell" style="margin-top:10px;width:700px;">
								<ul class="item-01" name="imodechoose" id="10086">
									<li ><a href="javascript:void(0)" >移动</a></li>
								</ul>
								<div style="float:left;display:inline;margin-left:15px;">
									<lable class="product-form-name" style="width:80px;">公网端口：</lable>
									<div class="num" style="margin-left:0px;"><input type="text" id="ydinterport" value="多个端口请用半角逗号隔开" style="width:200px;height:28px;margin-left:0px;color:#a4a4a4;"/></div>
								</div>
								<div style="float:left;display:inline;margin-left:15px;">
									<lable class="product-form-name" style="width:80px;">公网带宽：</lable>
									<div class="num" style="margin-left:0px;"><input type="text" id="ydinterbw" value="0" style="margin-left:0px;height:28px;"/>  M</div>
								</div>
							</div>
							<div class="product-form-cell" style="margin-top:10px;width:700px;">
								<ul class="item-01" name="imodechoose" id="10000">
									<li ><a href="javascript:void(0)" >电信</a></li>
								</ul>
								<div style="float:left;display:inline;margin-left:15px;">
									<lable class="product-form-name" style="width:80px;">公网端口：</lable>
									<div class="num" style="margin-left:0px;"><input type="text" id="dxinterport" value="多个端口请用半角逗号隔开" style="width:200px;height:28px;margin-left:0px;color:#a4a4a4;"/></div>
								</div>
								<div style="float:left;display:inline;margin-left:15px;">
									<lable class="product-form-name" style="width:80px;">公网带宽：</lable>
									<div class="num" style="margin-left:0px;"><input type="text" id="dxinterbw" value="0" style="margin-left:0px;height:28px;"/>  M</div>
								</div>
							</div>
								<div class="clear"></div>
							</div>
							</div>
						</div>
					</div>
					   <div class="suggest-wrap">
			<div class="button" style="margin-left:225px;float:left;"><input type="button" onclick="doChange()" value='确定' ></div>
	        <div class="button" style="float:left;"><input type="reset" onclick="doCancel()" value='取消' ></div>
	 </div>
				</div>

			</div>
		<!-- 	<input type="hidden" id="cpu" name="cpu" value="2">
			<input type="hidden" id="mem" name="mem" value="2">
			
			<input type="hidden" id="store" name="store" value="40">
			<input type="hidden" id="imode1" name="imode1" value="0">
			<input type="hidden" id="imode2" name="imode2" value="0">
			<input type="hidden" id="imode3" name="imode3" value="0">
			<input type="hidden" id="imode" name="imode" value="0">
			<input type="hidden" id="imodename" name="imodename" value="">
			<input type="hidden" id="safesoft" name="safesoft" value="0">
			<input type="hidden" id="time" name="time" value="1">
			<input type="hidden" id="region" name="region" value="00001">
			<input type="hidden" id="regionname" name="regionname" value="济南">	 -->
			<input type="hidden" id="imode1" name="imode1" value="0">
			<input type="hidden" id="imode2" name="imode2" value="0">
			<input type="hidden" id="imode3" name="imode3" value="0">	
			
				<table  style="display:none">
	<c:forEach items="${bmcServiceConfigVos}" var="vo">
	<tr  >
		<td>${vo.fieldname}:</td><td><input type="text" id="${vo.formfield}" name="${vo.formfield}" value="${vo.fieldvalue}" /></td>
	</tr>
	</c:forEach>
</table>
		</div>
	</div>

   </form>
   

<script type="text/javascript">

		var diskNum = 1;
		var diskflag1 = true;
		var diskflag2 = true;
		var flag = true;
$(document).ready(function (){
	//给cpu赋值
	var cpuNumValue = $('#cpunum').val();
	if(cpuNumValue){
	  var li_cpuchoose = $("#cpuchoose").children('li');
	  li_cpuchoose.removeClass();
	  li_cpuchoose.each(function(index,element){
	      var currentValue =  $(element).val();
	      if(currentValue == cpuNumValue){
	      	  $(element).addClass("on");
	      }
	  });
	}
	
	
	//给内存赋值
	var memNumValue = $('#memnum').val();
	if(memNumValue){
	  var li_memchoose = $("#memchoose").children('li');
	  li_memchoose.removeClass();
	  li_memchoose.each(function(index,element){
	      var currentValue =  $(element).val();
	      if(currentValue == memNumValue){
	      	  $(element).addClass("on");
	      }
	  });
	}
	
	/**
	绑定click事件
	*/
	  var li_memchoose = $("#memchoose").children('li');
	  li_memchoose.each(function(index,element){
	      var currentValue =  $(element).val();
	      $(this).bind("click" ,function (){
	    	  $("#memnum").val(currentValue);
	    	  $(element).addClass("on").siblings('li').removeClass('on');;
	      })
	  });
	
	
	var li_cpuchoose = $("#cpuchoose").children('li');
	li_cpuchoose.click(function() {
	    $(this).addClass('on').siblings('li').removeClass('on');
	    var _value = $(this).attr("value");
	    $("#cpunum").val(_value);
	    
	});

    var _osname = $("#osname").val();
    var _strnum = $("#strnum").val();
   // $("#xt").val(_osname);
    //console.log($("#xt option[value='"+_osname+"']").val());
    $("#xt option[value='"+_osname+"']").attr("selected", "selected");
//    spreadCell temp-select
   $("#xt").next().eq(0).children("div").html(_osname);
    document.getElementById("xtp").innerHTML = _strnum+"G";


	var imodel = $("#imode").val();
	var interport = $("#interport").val();联通:;移动:;电信:
	var interbw = $("#interbw").val(); //联通:1;移动:0;电信:0
	console.log(interport);
	console.log(interbw);
	
	var arrInterport = interport.split(';');
	var arrInterbw = interbw.split(';');
	
	var imodelid  = imodelswitch(imodel);
	var obj1 = $('#10010').children('li');
	var obj2 = $('#10086').children('li');
	var obj3 = $('#10000').children('li');
	obj1.click(function() {
	    if (obj1.hasClass('on')) {
	        $('#imode1').val('0');
	        $('#ltinterport').val('多个端口请用半角逗号隔开');
	        $('#ltinterbw').val('0');
	    } else {
	        $('#imode1').val('1');
	    }
	    $(this).toggleClass('on');
	});
	obj2.click(function() {
	    if (obj2.hasClass('on')) {
	        $('#imode2').val('0');
	        $('#ydinterport').val('多个端口请用半角逗号隔开');
	        $('#ydinterbw').val('0');
	    } else {
	        $('#imode2').val('1');
	    }
	    $(this).toggleClass('on');

	});
	
	obj3.click(function() {
	    if (obj3.hasClass('on')) {
	        $('#imode3').val('0');
	        $('#dxinterport').val('多个端口请用半角逗号隔开');
	        $('#dxinterbw').val('0');
	    } else {
	        $('#imode3').val('1');
	    }
	    $(this).toggleClass('on');
	});	
	dealImodel(imodelid);
	
	var netinfo = {};
	var _model10086 = {}
	var _model10010 = {}
	var _model10000 = {}
	
	netinfo._model10010 = _model10010;
	netinfo._model10086 = _model10086;
	netinfo._model10000 = _model10000;
	
	
	$.each( arrInterport, function(i, n){
		//alert( "Item #" + i + ": " + n );
		if(n.split(":")[0] == "联通"){
			_model10010.port =n.split(":")[1];
			if(!(n.split(":")[1] =="")){
				$('#10010').next("div").find("input").val(n.split(":")[1]);
			}
		}
		if(n.split(":")[0] == "移动"){
			_model10086.port =n.split(":")[1];
			if(!(n.split(":")[1] =="")){
				$('#10086').next("div").find("input").val(n.split(":")[1]);
			}
		}
		if(n.split(":")[0] == "电信"){
			_model10000.port =n.split(":")[1];
			if(!(n.split(":")[1] =="")){
				$('#10000').next("div").find("input").val(n.split(":")[1]);
			}
		}
	});
	$.each( arrInterbw, function(i, n){
		//alert( "Item #" + i + ": " + n );
		if(n.split(":")[0] == "联通"){
			_model10010.bw =n.split(":")[1];
			if(n.split(":")[1]>0){
				$('#10010').nextAll("div").eq(1).find("input").val(n.split(":")[1]);
			}
		}
		if(n.split(":")[0] == "移动"){
			_model10086.bw =n.split(":")[1];
			if(n.split(":")[1]>0){
				$('#10086').nextAll("div").eq(1).find("input").val(n.split(":")[1]);
			}
		}
		if(n.split(":")[0] == "电信"){
			_model10000.bw =n.split(":")[1];
			if(n.split(":")[1]>0){
				$('#10000').nextAll("div").eq(1).find("input").val(n.split(":")[1]);
			}
		}
	});
	
	
	
//	console.log(netinfo);
	/**
	*这个地方可以和 imodelswitch 方法并为一个
	*/
	function dealImodel(imodelid){
		switch(imodelid){
			case "1":{
				obj1.trigger("click");
				break;
			}
			case "2":{
				obj2.trigger("click");
				break;
			}
			case "3":{
				obj3.trigger("click");
				break;
			}
			case "4":{
				obj1.trigger("click");
				obj2.trigger("click");
				break;
			}
			case "5":{
				obj1.trigger("click");
				obj3.trigger("click");
				break;
			}
			case "6":{
				obj2.trigger("click");
				obj3.trigger("click");
				break;
			}
			case "7":{
				obj1.trigger("click");
				break;
			}
		
			default:
				break;
		}
		
	}

	var clickObj=$('.product-form-cell .uc-slider-2');
	var disk2Obj = $('#disk2 .uc-slider1');
	var disk3Obj = $('#disk3 .uc-slider1');
	var disk4Obj = $('#disk4 .uc-slider1');
	var memObj = $('#mem .uc-slider1');
	//点击事件
	clickObj.click(function(e){
		var winLeft=$(this).offset().left;
		var mouLeft=e.pageX-winLeft;
		count(mouLeft,1);
		/*$('.product-form-cell .uc-slider1 .strip .val').fadeIn(500);
		$('.product-form-cell .uc-slider1 .strip .val').text($('.product-form-cell .num1 input').val()+"G");*/
	});
	disk2Obj.click(function(e){
		var winLeft=$(this).offset().left;
		var mouLeft=e.pageX-winLeft;
		count(mouLeft,2);
	});
	disk3Obj.click(function(e){
		var winLeft=$(this).offset().left;
		var mouLeft=e.pageX-winLeft;
		count(mouLeft,3);
	});
	disk4Obj.click(function(e){
		var winLeft=$(this).offset().left;
		var mouLeft=e.pageX-winLeft;
		count(mouLeft,4);
	});


	var vals=null;//最后的百分比
	/*var leftValue=12;*/
	//$('#hard1').val(0);
	//$('#hard2').val(0);
	$('#hard3').val(0);
	$('#hard4').val(0);
	var strip1=$('.product-form-cell .uc-slider-2 .strip');//动画动像
	var chunk1=$('.product-form-cell .uc-slider-2 .strip .chunk');
	var strip2=$('#disk2 .uc-slider1 .strip');//动画动像
	var chunk2=$('#disk2 .uc-slider1 .strip .chunk');
	var strip3=$('#disk3 .uc-slider1 .strip');//动画动像
	var chunk3=$('#disk3 .uc-slider1 .strip .chunk');
	var strip4=$('#disk4 .uc-slider1 .strip');//动画动像
	var chunk4=$('#disk4 .uc-slider1 .strip .chunk');
	var strip5=$('#mem .uc-slider1 .strip');//动画动像
	var chunk5=$('#mem .uc-slider1 .strip .chunk');
	/*var strip=$('.product-form-cell .uc-slider1 .strip');动画动像	var chunk=$('.product-form-cell .uc-slider1 .strip .chunk');*/
	
	var width1 = 229;
    var width2 = 139;
	var width3 = 139;
	//计算百分比
	function count(num,diskNo){
		/*var conWidth=$('.product-form-cell .uc-slider1 .range1').width();
		var leftObj=$('.uc-slider1 .bg-01 .block');
		var bai=parseInt(num/588*100);*/
		if (num<=0)
		   num = 0;
        if(num<=width1){
        	vals=Math.round(num/229*600);
        	vals=Math.round(vals/10)*10;//取整，10的倍数
        	if(diskNo == 5){
        		vals=Math.round(num/229*1000);
            	vals=Math.round(vals/10)*10;//取整，10的倍数
        	}
        	if(vals<2){
        		if(diskNo == 1){
		    		strip1.css('width',num+'px');
				    chunk1.css('right','-12px');
	    		}
	    		if(diskNo == 2){
		    		strip2.css('width',num+'px');
				    chunk2.css('right','-12px');
	    		}
	    		if(diskNo == 4){
		    		strip4.css('width',num+'px');
				    chunk4.css('right','-12px');
	    		}
	    		if(diskNo == 3){
		    		strip3.css('width',num+'px');
				    chunk3.css('right','-12px');
	    		}
	    		if(diskNo == 5){
	    			chunk5.css('width',num+'px');
	    			chunk5.css('right','-12px');
	    		}
        	}
        	if(vals>=2){
        			if(diskNo == 1){
	    			strip1.css('width',num+'px');
	    			chunk1.css('right','-17px');
	    		}
	    		if(diskNo == 2){
	    			strip2.css('width',num+'px');
	    			chunk2.css('right','-17px');
	    		}
	    		if(diskNo == 3){
	    			strip3.css('width',num+'px');
	    			chunk3.css('right','-17px');
	    		}
	    		if(diskNo == 4){
	    			strip4.css('width',num+'px');
	    			chunk4.css('right','-17px');
	    		}
	    		if(diskNo == 5){
	    			strip5.css('width',num+'px');
	    			chunk5.css('right','-17px');
	    		}
        	}
        	if(vals==600){
        			if(diskNo == 1){
	    			strip1.css('width',229+'px');
	    			chunk1.css('right','-17px');
	    		}
	    		if(diskNo == 2){
	    			strip2.css('width',229+'px');
	    			chunk2.css('right','-17px');
	    		}
	    		if(diskNo == 3){
	    			strip3.css('width',229+'px');
	    			chunk3.css('right','-17px');
	    		}
	    		if(diskNo == 4){
	    			strip4.css('width',229+'px');
	    			chunk4.css('right','-17px');
	    		}
	    		if(diskNo == 5){
	    			strip5.css('width',229+'px');
	    			chunk5.css('right','-17px');
	    		}
        	}
        }
        if(num<=368 && num>229){
        	//alert(num);
        	vals=600+Math.round((num-229)/(368-229)*(2000-600));
        	//alert(vals);
        	vals=Math.round(vals/100)*100;//取整，100的倍数
        	
        	if(diskNo == 5){
        		vals=1000+Math.round((num-229)/(368-229)*(2000-1000));
            	//alert(vals);
            	vals=Math.round(vals/100)*100;//取整，100的倍数
        		
        	}
        	/*if(vals==1100)
        		vals=1000;
        	else if(vals==1300)
        		vals=1200;
        	else if(vals==1400)
        		vals=1500;*/
        	if(vals==2000){
        		if(diskNo == 1){
	    			strip1.css('width',368+'px');
	    			chunk1.css('right','-17px');	    			
	    		}
	    		if(diskNo == 2){
	    			strip2.css('width',368+'px');
	    			chunk2.css('right','-17px');	    			
	    		}
	    		if(diskNo == 3){
	    			strip3.css('width',368+'px');
	    			chunk3.css('right','-17px');	    			
	    		}
	    		if(diskNo == 4){
	    			strip4.css('width',368+'px');
	    			chunk4.css('right','-17px');	    			
	    		}	
	    		if(diskNo == 5){
	    			strip5.css('width',368+'px');
	    			chunk5.css('right','-17px');	    			
	    		}	
        	}else{
        			if(diskNo == 1){
		    		strip1.css('width',num+'px');
			        chunk1.css('right','-17px');
	    		}
	    		if(diskNo == 2){
		    		strip2.css('width',num+'px');
			        chunk2.css('right','-17px');
	    		}
	    		if(diskNo == 3){
		    		strip3.css('width',num+'px');
			        chunk3.css('right','-17px');
	    		}
	    		if(diskNo == 4){
		    		strip4.css('width',num+'px');
			        chunk4.css('right','-17px');
	    		}
	    		if(diskNo == 5){
		    		strip5.css('width',num+'px');
			        chunk5.css('right','-17px');
	    		}
        	}
  
        }
        
        if(diskNo == 1){
		   $('#hard1').val(vals);
	   }
	   if(diskNo == 2){
		   $('#hard2').val(vals);
	   }
	   if(diskNo == 3){
		   $('#hard3').val(vals);
	   }
	   if(diskNo == 4){
		   $('#hard4').val(vals);
	   }
	   if(diskNo == 5){
		   $('#dbmem').val(vals);
	   }
	  } //end count


	memObj.click(function(e){
		var winLeft=$(this).offset().left;
		var mouLeft=e.pageX-winLeft;
		count(mouLeft,5);
	});
	
		$('#hard1').keyup(function(){
			//alert("keyup");
		var val=$(this).val();
		var reg = /^[0-9]*$/;
		if(!reg.test(val)){
			val = 0;
			$(this).val(val);
		}
		if(val <= 0){
			val = -val;
			$(this).val(val);
		}
		if(val>2000){
			val = 2000;
			$(this).val(2000);
		}
		/*if(val%10 != 0){
			val = (val/10)*10 + 10;
			$(this).val(val);
		}*/
		/*
		$('.product-form-cell .uc-slider1 .strip .val').fadeIn(500);
		$('.product-form-cell .uc-slider1 .strip .val').text($('.product-form-cell .num1 input').val()+"G");
		*/
		if(val<=600){
			left=(val/600*width1);
			strip1.css('width',left+'px');
			if(val==0){
				chunk1.css('right','-12px');
			}else{
			    chunk1.css('right','-17px');
			}			
		} else if(val>600 && val<=2000){
			left = (val-600)/(2000-600)*width2+width1;
			strip1.css('width',left+'px');
		}
	});
	$('#hard2').keyup(function(){
		var val=$(this).val();
		var reg = /^[0-9]*$/;
		if(!reg.test(val)){
			val = 0;
			$(this).val(val);
		}
		if(val <= 0){
			val = -val;
			$(this).val(val);
		}
		if(val>2000){
			val = 2000;
			$(this).val(2000);
		}
		/*
		$('.product-form-cell .uc-slider1 .strip .val').fadeIn(500);
		$('.product-form-cell .uc-slider1 .strip .val').text($('.product-form-cell .num1 input').val()+"G");
		*/
		if(val<=600){
			left=(val/600*width1);
			strip2.css('width',left+'px');
			if(val==0){
				chunk2.css('right','-12px');
			}else{
			    chunk2.css('right','-17px');
			}			
		} else if(val>600 && val<=2000){
			left = (val-600)/(2000-600)*width2+width1;
			strip2.css('width',left+'px');
		}
	});


	var width1 = 229;
    var width2 = 139;
	var width3 = 139;
	//计算百分比
	function count(num,diskNo){
		/*var conWidth=$('.product-form-cell .uc-slider1 .range1').width();
		var leftObj=$('.uc-slider1 .bg-01 .block');
		var bai=parseInt(num/588*100);*/
		if (num<=0)
		   num = 0;
        if(num<=width1){
        	vals=Math.round(num/229*600);
        	vals=Math.round(vals/10)*10;//取整，10的倍数
        	if(diskNo == 5){
        		vals=Math.round(num/229*1000);
            	vals=Math.round(vals/10)*10;//取整，10的倍数
        	}
        	if(vals<2){
        		if(diskNo == 1){
		    		strip1.css('width',num+'px');
				    chunk1.css('right','-12px');
	    		}
	    		if(diskNo == 2){
		    		strip2.css('width',num+'px');
				    chunk2.css('right','-12px');
	    		}
	    		if(diskNo == 4){
		    		strip4.css('width',num+'px');
				    chunk4.css('right','-12px');
	    		}
	    		if(diskNo == 3){
		    		strip3.css('width',num+'px');
				    chunk3.css('right','-12px');
	    		}
	    		if(diskNo == 5){
	    			chunk5.css('width',num+'px');
	    			chunk5.css('right','-12px');
	    		}
        	}
        	if(vals>=2){
        			if(diskNo == 1){
	    			strip1.css('width',num+'px');
	    			chunk1.css('right','-17px');
	    		}
	    		if(diskNo == 2){
	    			strip2.css('width',num+'px');
	    			chunk2.css('right','-17px');
	    		}
	    		if(diskNo == 3){
	    			strip3.css('width',num+'px');
	    			chunk3.css('right','-17px');
	    		}
	    		if(diskNo == 4){
	    			strip4.css('width',num+'px');
	    			chunk4.css('right','-17px');
	    		}
	    		if(diskNo == 5){
	    			strip5.css('width',num+'px');
	    			chunk5.css('right','-17px');
	    		}
        	}
        	if(vals==600){
        			if(diskNo == 1){
	    			strip1.css('width',229+'px');
	    			chunk1.css('right','-17px');
	    		}
	    		if(diskNo == 2){
	    			strip2.css('width',229+'px');
	    			chunk2.css('right','-17px');
	    		}
	    		if(diskNo == 3){
	    			strip3.css('width',229+'px');
	    			chunk3.css('right','-17px');
	    		}
	    		if(diskNo == 4){
	    			strip4.css('width',229+'px');
	    			chunk4.css('right','-17px');
	    		}
	    		if(diskNo == 5){
	    			strip5.css('width',229+'px');
	    			chunk5.css('right','-17px');
	    		}
        	}
        }
        if(num<=368 && num>229){
        	//alert(num);
        	vals=600+Math.round((num-229)/(368-229)*(2000-600));
        	//alert(vals);
        	vals=Math.round(vals/100)*100;//取整，100的倍数
        	
        	if(diskNo == 5){
        		vals=1000+Math.round((num-229)/(368-229)*(2000-1000));
            	//alert(vals);
            	vals=Math.round(vals/100)*100;//取整，100的倍数
        		
        	}
        	/*if(vals==1100)
        		vals=1000;
        	else if(vals==1300)
        		vals=1200;
        	else if(vals==1400)
        		vals=1500;*/
        	if(vals==2000){
        		if(diskNo == 1){
	    			strip1.css('width',368+'px');
	    			chunk1.css('right','-17px');	    			
	    		}
	    		if(diskNo == 2){
	    			strip2.css('width',368+'px');
	    			chunk2.css('right','-17px');	    			
	    		}
	    		if(diskNo == 3){
	    			strip3.css('width',368+'px');
	    			chunk3.css('right','-17px');	    			
	    		}
	    		if(diskNo == 4){
	    			strip4.css('width',368+'px');
	    			chunk4.css('right','-17px');	    			
	    		}	
	    		if(diskNo == 5){
	    			strip5.css('width',368+'px');
	    			chunk5.css('right','-17px');	    			
	    		}	
        	}else{
        			if(diskNo == 1){
		    		strip1.css('width',num+'px');
			        chunk1.css('right','-17px');
	    		}
	    		if(diskNo == 2){
		    		strip2.css('width',num+'px');
			        chunk2.css('right','-17px');
	    		}
	    		if(diskNo == 3){
		    		strip3.css('width',num+'px');
			        chunk3.css('right','-17px');
	    		}
	    		if(diskNo == 4){
		    		strip4.css('width',num+'px');
			        chunk4.css('right','-17px');
	    		}
	    		if(diskNo == 5){
		    		strip5.css('width',num+'px');
			        chunk5.css('right','-17px');
	    		}
        	}
  
        }
        
        if(diskNo == 1){
		   $('#hard1').val(vals);
	   }
	   if(diskNo == 2){
		   $('#hard2').val(vals);
	   }
	   if(diskNo == 3){
		   $('#hard3').val(vals);
	   }
	   if(diskNo == 4){
		   $('#hard4').val(vals);
	   }
	   if(diskNo == 5){
		   $('#dbmem').val(vals);
	   }
	  }


    removeDisk();
	var hardValue1 = 0;
	var hardValue2 = 0;
	
	$('#addDisk').click(function(e) {
	    if (diskNum > 0) {
	        if (diskflag1 && flag) {
	            $('#disk1').show();
	            diskflag1 = false;
	            //				flag = false;
	            $('#hard1').val(hardValue1);
	            $("#hard1").trigger("keyup");
	            if (hardValue1 == 0) {
	                clickObj.click(function(e) {
	                    var winLeft = $(this).offset().left;
	                    var mouLeft = e.pageX - winLeft;
	                    count(mouLeft, 1);

	                });
	                $("#hard1").removeAttr("readonly");
	            }

	        }

	        if (diskflag2 && flag) {
	            $('#disk2').show();
	            diskflag2 = false;
	            //				flag = false;
	            $('#hard2').val(hardValue2);
	            $("#hard2").trigger("keyup");
	            if (hardValue2 == 0) {
	                disk2Obj.click(function(e) {
	                    var winLeft = $(this).offset().left;
	                    var mouLeft = e.pageX - winLeft;
	                    count(mouLeft, 2);
	                });
	                $("#hard2").removeAttr("readonly");
	            }
	        }

	        diskNum = diskNum - 1;
	        flag = true;

	        if (diskNum == 0) {
	            $(this).hide();
	            $(this).parent().next().hide();
	        }
	    }
	});
	
	
	 var disknumValue = $("#disknum").val();
//1,80;2,0;3,0;4,0

//分三种情况
//情况1：如果没有值或值为0，则默认显示一行，并且可修改，也可以增加一行，新增的可以修改和删除
//情况2：如果有值且只有一个值，则默认显示一行，且不能修改，但是可以删除，也可以增加一行，新增加的可以修改和删除
//情况3：如果有值且有2个值，则默认显示2行，2行都可以删除，但是都不能修改
   if(disknumValue){	
   	console.log(disknumValue);
	var diskNumArr = disknumValue.split(";"); //str 拆分为 数组
	  for(var i=0;i<diskNumArr.length;i++){
	  	 if(i == 2){
	  	 	//只判断前2个
	  	 	break;
	  	 }
	  	 
		   var _arr = diskNumArr[i].split(",");
		   var diskid = "#disk"+(i+1);
		   var hardid = "#hard"+(i+1);
		   
		   
		   if(!(_arr[1] == 0)){
		   	  diskNum++;
		      $(diskid).css("display","block");
			  $(hardid).text(_arr[1]);
			  $(hardid).attr("value",_arr[1]);
			  $(hardid).trigger("keyup");
			  //设置为不可修改
			  $(hardid).attr("readonly","readonly");
			  if(i == 0){
			  	clickObj.off("click");
			  	diskflag1 = false;
			  	hardValue1 = _arr[1];
			  }else{
			  	disk2Obj.off("click");
//			  	$(".container-cell .product-details .product-form-cell .close1_2").hide();
			  	$("#addDiskDiv").hide();
			  	diskflag2 = false;
			  	hardValue2 = _arr[1];
			  }
		   }else{
               //暂时无操作
		   }		
	  }
	  
   }

}); 

function doChange() {
    
	var _validate = doSubmit();
	//alert(_validate);
	if(_validate){
        $.ajax({
			url:'${ctx}//workorder/doOrderChange.do',
			type:'post',
			data:$("#conditionForm2").serialize(),
			success :function (data){
				//alert(data);	
				debugger;
				if(data.success == 1){
					alert("更新成功"); 
					 
					var mainTab =  window.parent.$("#centerTab").find("#tabs");
					var currentTab = mainTab.tabs("getSelected");
					var index =mainTab.tabs('getTabIndex',currentTab);
				 
				    var _showtab = mainTab.tabs("getTab",'申请资源查看');
				    var refresh_tab =  _showtab;
				    debugger;
				    var _infowshowurl ;
				    if(refresh_tab && refresh_tab.find('iframe').length > 0){
				    	// mainTab.tabs('close','申请资源查看');
				    	 var _refresh_ifram = refresh_tab.find('iframe')[0];
				    	var refresh_url = _refresh_ifram.src;
				    		//_refresh_ifram.src = refresh_url;
				    	//_refresh_ifram.contentWindow.location.href=refresh_url;
				    	_infowshowurl = refresh_url;
				    	//return refresh_tab;
				    //	refresh_tab.panel('refresh',refresh_url);
				    		
				    }
				    
				    var _centerTab = window.parent.$("#centerTab");
				    var _options  = _centerTab.panel('options');
				    _centerTab.panel({
				    	onOpen:function (){
				    	// addTab('申请资源查看',_infowshowurl,_centerTab);
				    	}
				    });
				    _centerTab.panel('refresh');
				    //alert(_centerTab.find("#tabs").length);
				  //	addTab('申请资源查看',_infowshowurl)
				   // mainTab.tabs('close',index);//关闭顺序不能变 ，因为上面的window.parent  是以当前的页面为基础的
				}
			}
		});
	}
	
	//$("#conditionForm2").submit();
}


function addTab(title, url,_centerTab) {
	// panel('options').tab
		var _tabs = $(_centerTab).find("#tabs");
		console.log($(_centerTab).find("#tabs").html());
    if (  $(_centerTab).find("#tabs").tabs('exists', title)) {
    	//alert("exist")
    	$(_centerTab).find("#tabs").tabs('select', title);
    } else {
    //	alert("add")
        var content = '<iframe id="details" scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:98%;"></iframe>';
        $(_centerTab).find("#tabs").tabs('add', {
        	id:'orderdetails',
            title: title,
            content: content,
            closable: true
        });
      
        $(_centerTab).find("#tabs").tabs({
        	
        	height:'600'
        });
        $(_centerTab).find("#tabs").tabs('select',title);
    }
}

function doSubmit() {
    //更新磁盘数
    var hardStr = "";
    var hardValue1 = $("#hard1").val();
    var hardValue2 = $("#hard2").val();

    if (!hardValue1 || hardValue1 == "0") {
        hardValue1 = 0;
        //	      	  window.alert("磁盘大小不能为零");
        //	      	  return false;
    }
    if (!hardValue2 || hardValue2 == "0") {
        hardValue2 = 0;
        if (!$("#hard2").is(":hidden")) {
            //	      	   window.alert("磁盘大小不能为零");	
            //	      	  return false;
        }
    }

    var disknumValue = $("#disknum").val();
    if (disknumValue) {
        var diskNumArr = disknumValue.split(";");
        var disNumLength = diskNumArr.length;

        for (var ct = 0; ct < disNumLength; ct++) {
            var diskObj = diskNumArr[ct];
            var diskArray = diskObj.split(",");
            if (ct == 0) {
                hardStr = diskArray[0] + "," + hardValue1 + ";";
            } else if (ct == 1) {
                hardStr = hardStr + diskArray[0] + "," + hardValue2 + ";";
            } else {
                hardStr = hardStr + diskArray[0] + "," + diskArray[1] ;
                if(ct!= (disNumLength-1)){
                	hardStr += ";";
                }
            }
        }

        //对等于1的情况特殊处理
        if (disNumLength == 1) {
            hardStr = hardStr + "2," + hardValue2 + ";3,0;4,0";
        }

    } else {
        hardStr = "1," + hardValue1 + ";2," + hardValue2 + ";3,0;4,0";
    }

    //给disnum赋值
    if (hardStr) {
        $("#disknum").val(hardStr);
    }
    //return false;
   // return false;
    var model10010 = $("#imode1").val();
    var model10086 = $("#imode2").val();
    var model10000 = $("#imode3").val();
   var imodel =  modelname(model10010,model10086,model10000);
	//$("#imode").val(imodel);
	
	return true;
}

function doCancel() {
    $('.popup .bg .close').trigger('click');
}



function removeDisk(){
		$('.container-cell .product-details .product-form-cell .close1_1').click(function(){
		/*$(this).parents('.product-form-cell').remove();*/
		
		$('#disk1').hide();
		diskflag1 = true;
		diskNum = diskNum + 1;
	
		$('#hard1').val(0);
		var strip1=$('#disk1 .uc-slider1 .strip');//动画动像
		var chunk1=$('#disk1 .uc-slider1 .strip .chunk');
		strip1.css('width','0px');
        chunk1.css('right','-17px');
        $("#addDiskDiv").show();
	});
	
	
	$('.container-cell .product-details .product-form-cell .close1_2').click(function(){
		/*$(this).parents('.product-form-cell').remove();*/
		var addButton = $('.container-cell .product-details .product-from-row .product-form-cell .addDisk');
		$('#disk2').hide();
		diskflag2 = true;
		diskNum = diskNum + 1;
		if (diskNum >0 ){
			addButton.show();
			addButton.parent().next().show();
			
		}
		$('#hard2').val(0);
		var strip2=$('#disk2 .uc-slider1 .strip');//动画动像
		var chunk2=$('#disk2 .uc-slider1 .strip .chunk');
		strip2.css('width','0px');
        chunk2.css('right','-17px');
         $("#addDiskDiv").show();
	});

}
 var shoplist = new Array();
 var shoplistid=0;

//根据选择的操作系统分配系统盘
$('#xt').select({
    endFun: function (param, text, dataPath, _this) {
        if (_this.attr('id') == 'xt') {
            if (_this.val().indexOf('Win') != -1) {
                document.getElementById("xtp").innerHTML = '60G';
              //  $("#store").val(60);
                $("#osname").val(_this.val());
                $("#strnum").val(60);

            } else {
                document.getElementById("xtp").innerHTML = '40G';
             //   $("#store").val(40);
                $("#osname").val(_this.val());
                $("#strnum").val(40);
            }
        }
    }
});

       
function imodelswitch(imodel){
	
	  var imodeid="";
      //接入模式转换
      switch(imodel){
			case '联通单线': 
				imodeid="1";
			    break;
			case '移动单线':
				imodeid="2";
			    break;
			case '电信单线':
				imodeid="3";
			    break;
			case '联通移动双线':
				imodeid="4";
			    break;
			case '联通电信双线':
				imodeid="5";
			    break;
			case '移动电信双线':
				imodeid="6";
			    break;
			case '联移电三线':
				imodeid="7";
			    break;
			default:
				imodeid="0";
			}
      
      return imodeid;
	
}

function modelname(model10010,model10086,model10000){
	 //接入模式
    var mode1=model10010;
    var mode2=model10086;
    var mode3=model10000;
    //公网带宽
    var chooseinterbw = "";
     //公网端口
    var chooseinterport = "";
  //  联通:1;移动:0;电信:0
  //联通:;移动:;电信:
	 if(mode1=='1'&&mode2=='0'&&mode3=='0'){
	 	$('#imode').val('联通单线');
	 //	$('#imodename').val('联通单线');
	 	chooseinterbw = chooseinterbw + "联通:" + $("#ltinterbw").val() + ";移动:0;电信:0";
	 	 if($("#ltinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + "联通:" + $("#ltinterport").val()+";移动:;电信:";
	 	}
	 }else if(mode1=='0'&&mode2=='1'&&mode3=='0'){
	 	$('#imode').val('移动单线');
	 	$('#imodename').val('移动单线');
	 	chooseinterbw = chooseinterbw + "联通:0"+";移动:" + $("#ydinterbw").val() + ";电信:0";
	 	if($("#ydinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport +"联通:"+";移动:" + $("#ydinterport").val()+";电信:";
	 	}
	 }else if(mode1=='0'&&mode2=='0'&&mode3=='1'){
	 	$('#imode').val('电信单线');
	 	$('#imodename').val('电信单线');
	 	chooseinterbw = chooseinterbw + "联通:0;移动:0;电信:" + $("#dxinterbw").val() + "";
	 	if($("#dxinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + "联通:;移动:;电信:" + $("#dxinterport").val();
	 	}
	 }else if(mode1=='1'&&mode2=='1'&&mode3=='0'){
	 	$('#imode').val('联通移动双线');
	 	$('#imodename').val('联通移动双线');
	 	chooseinterbw = chooseinterbw + "联通:" + $("#ltinterbw").val() + ";移动:" + $("#ydinterbw").val() + ";电信:0";
	 	if($("#ltinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + "联通:" + $("#ltinterport").val()+";";
	 	}
	 	if($("#ydinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + "移动:" + $("#ydinterport").val();
	 	}
	 	chooseinterport += ";电信:";
	 }else if(mode1=='1'&&mode2=='0'&&mode3=='1'){
	 	$('#imode').val('联通电信双线');
	 	$('#imodename').val('联通电信双线');
	 	chooseinterbw = chooseinterbw + "联通:" + $("#ltinterbw").val() + ";移动:0;电信:" + $("#dxinterbw").val() + "";
	 	if($("#ltinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + "联通:" + $("#ltinterport").val();
	 	}
	 	chooseinterport += ";移动:"
	 	if($("#dxinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + ";电信:" + $("#dxinterport").val();
	 	}
	 }else if(mode1=='0'&&mode2=='1'&&mode3=='1'){
	 	$('#imode').val('移动电信双线');
	 	$('#imodename').val('移动电信双线');
	 	chooseinterbw = chooseinterbw + "联通:0;移动:" + $("#ydinterbw").val() + ""+ ";电信:" + $("#dxinterbw").val() ;
	 	if($("#ydinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + "联通:;移动:" + $("#ydinterport").val();
	 	}
	 	if($("#dxinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + ";电信:" + $("#dxinterport").val();
	 	}
	 }else if(mode1=='1'&&mode2=='1'&&mode3=='1'){
	 	$('#imode').val('联通移动电信三线');
	 	$('#imodename').val('联通移动电信三线');
	 	chooseinterbw = chooseinterbw + "联通:" + $("#ltinterbw").val() +";移动:" + $("#ydinterbw").val() + ";电信:" + $("#dxinterbw").val() ;
	 	if($("#ltinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport +"联通:" + $("#ltinterport").val();
	    }
	    if($("#ydinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + ";移动:" + $("#ydinterport").val();
	    }
	    if($("#dxinterport").val() != '多个端口请用半角逗号隔开'){
	 	chooseinterport = chooseinterport + ";电信:" + $("#dxinterport").val();
	    }
	 }else {
	 	$('#imode').val('0');
	 	$('#imodename').val('');
	 	chooseinterbw = '';
	 	chooseinterport = '';
	 }
	 
	 $("#interport").val(chooseinterport);联通:;移动:;电信:
	 $("#interbw").val(chooseinterbw); //联通:1;移动:0;电信:0
	// $("#imode").val(imodel);
	// alert(imodel+",,,"+chooseinterbw+",,,"+chooseinterport);
}
      
function orderdetail(imodel){
            
	   var configure = shoplist[listid].split(',');
       var imodenames="";
       //接入模式转换
       switch(configure[14]){
			case '1': 
				imodenames="联通单线";
			    break;
			case '2':
				imodenames="移动单线";
			    break;
			case '3':
				imodenames="电信单线";
			    break;
			case '4':
				imodenames="联通移动双线";
			    break;
			case '5':
				imodenames="联通电信双线";
			    break;
			case '6':
				imodenames="移动电信双线";
			    break;
			case '7':
				imodenames="联移电三线";
			    break;
			default:
				imodenames="没选择";
			}
			//杀毒软件转换
			var virusnames="";
			if(configure[18] == '1'){
			virusnames="使用";
			}else{
			virusnames="不使用";
			}
			//区域转换
			var zonenames="";
			if(configure[21] == '00001'){
			zonenames="济南";
			}else{
			zonenames="绵阳";
			}
            var shopstr = '类型：'+configure[0]+'，型号：'+configure[1]+'，CPU：'+configure[2]+'核，内存：'+
            configure[3]+'G，数据盘：'+configure[4]+'G，其中数据盘1：'+configure[5]+'G，数据盘2：'+configure[6]+'G，数据盘3：'+
    				configure[7]+'G，数据盘4：'+configure[8]+'G，系统盘：'+configure[9]+'G，操作系统：'+
    				configure[10]+'，联通带宽：'+configure[11]+'M，移动带宽：'+configure[12]+'M，电信带宽：'+configure[13]+'M，接入模式：'+
    				imodenames+'，联通端口：'+configure[15]+'，移动端口：'+configure[16]+'，电信端口：'+configure[17]+'，杀毒软件：'+virusnames+'，区域：'+zonenames;
            alert(shopstr);
        }
        
        function buy(){
        //alert(shoplist.join(""));
          if(shoplist.join("")==''){
            alert("您的订购清单当中没有任何产品 !");
            return;
          }
        
          if(window.confirm("您确定要订购当前清单中的产品吗？")){
            
          debugger;
          //$.cookie("shopliststr",null); 
          
           var shopliststr = shoplist.join(":");
          document.getElementById("shopliststr").value=shopliststr;
          document.forms[0].action='<%=basePath%>/orderconfirm.do';
          document.forms[0].submit();
          }
          
        }
        
        function choosecpu(value){
           if(value=='2'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('2')\"><a href=\"javascript:void(0)\" >2G </a></li><li onclick=\"choosemem('4')\"><a href=\"javascript:void(0)\" >4G </a></li><li onclick=\"choosemem('8')\"><a href=\"javascript:void(0)\" >8G</a></li><li onclick=\"choosemem('12')\"><a href=\"javascript:void(0)\" >12G</a></li><li onclick=\"choosemem('16')\"><a href=\"javascript:void(0)\" >16G</a></li>");
             $('#memnum').val('2');
           }else if(value=='4'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('4')\"><a href=\"javascript:void(0)\" >4G </a></li><li onclick=\"choosemem('8')\"><a href=\"javascript:void(0)\" >8G </a></li><li onclick=\"choosemem('12')\"><a href=\"javascript:void(0)\" >12G </a></li><li onclick=\"choosemem('16')\"><a href=\"javascript:void(0)\" >16G</a></li><li onclick=\"choosemem('24')\"><a href=\"javascript:void(0)\" >24G </a></li><li onclick=\"choosemem('32')\"><a href=\"javascript:void(0)\" >32G</a></li>");
             $('#memnum').val('4');
           }else if(value=='8'){
          
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('8')\"><a href=\"javascript:void(0)\" >8G</a></li><li onclick=\"choosemem('16')\"><a href=\"javascript:void(0)\" >16G </a></li><li onclick=\"choosemem('24')\"><a href=\"javascript:void(0)\" >24G </a></li><li onclick=\"choosemem('32')\"><a href=\"javascript:void(0)\" >32G</a></li><li onclick=\"choosemem('64')\"><a href=\"javascript:void(0)\" >64G</a></li>");
             $('#memnum').val('8');
           }else if(value=='16'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('32')\"><a href=\"javascript:void(0)\" >32G</a></li><li onclick=\"choosemem('64')\"><a href=\"javascript:void(0)\" >64G</a></li>");
             $('#memnum').val('32');
           }else if(value=='32'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('64')\"><a href=\"javascript:void(0)\" >64G</a></li>");
             $('#memnum').val('64');
           }else if(value=='1'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('2')\"><a href=\"javascript:void(0)\" >2G </a></li><li onclick=\"choosemem('4')\"><a href=\"javascript:void(0)\" >4G</a></li>");
             $('#memnum').val('2');
           }
           
           var obj_2=$("#memchoose").children('li');
		 	obj_2.click(function(){
	   			$(this).addClass('on').siblings('li').removeClass('on');
  			})
        }
        //杀毒软件 
        function choosesafe(){
         var obj4 =  $('.product-form-cell').eq(13).find('.item-01').children('li');
         
      	 if(obj4.hasClass('on'))
      	 {
      	 	$('#safesoft').val('0');
      	 }else{
      	 
			 $('#safesoft').val('1');
		}
          
        }
        function choosemem(value){
           $('#memnum').val(value);
        }
        function choosehard(value){$('#hard').val(value);}
          
       /* function chooseimode(){
         
      	   
        }*/
        
        function choosestore(value){$('#store').val(value);}
        
        
        function chooseregion(value,name){
	       /*
        	$('#region').val(value);
	        //alert(name);
	        $('#regionname').val(name);
	        */
	        return false;
        }
        
     

        
        
</script>

</body>

</html>
