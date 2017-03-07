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
    <script type="text/javascript" src="<%=basePath%>/js/scripts/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/icp/js/jquery.cookie.js"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/styles/util.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/styles/gather.css" />
	
	<script type="text/javascript" src="<%=basePath%>/js/scripts/slide.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/scripts/TweenMax.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/scripts/myScroll.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/scripts/util.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/scripts/gather.js"></script>
</head>
<body>
  <form>

	<div class="container-wrap">
		<div class="container">
			
			<div style="float:left;width:885px;/*padding-bottom:9999px;margin-bottom:-9999px;*/">
			<div style="height:30px;background-color: #23a0bf; margin-top:10px;padding-top:5px;padding-left:5px;"><font color="white" size="4">云服务器-DIY</font></div>

				<div class="container-cell">
					<div class="product-details">
						<div class="product-from-con">
						<div style="padding-left: 100px;">
						<div class="product-from-row">
								<lable class="product-form-name">区域选择 :</lable>
								<div class="product-form-cell">
									<ul class="item-01">
										<li class="on" onclick="chooseregion('00001','济南')"><a href="javascript:void(0)" >济南</a></li>
										<li ><a href="javascript:void(0)" >绵阳</a></li>
									</ul>
								</div>
								<lable class="product-form-name" style="color: #a4a4a4;width:160px;">绵阳地区暂不开放！</lable>
								<div class="clear"></div>
							</div>
						</div>
						<img src="/icpserver/icp/orderbuy/images/jichupeizhi.png" />
						<div style="padding-left: 100px;">
						    <div class="product-from-row">
								<lable class="product-form-name">CPU :</lable>
								<div class="product-form-cell">
									<ul class="item-01" id="cpuchoose">
									    <li onclick="choosecpu('1')"><a href="javascript:void(0)" >1核</a></li>
										<li class="on" onclick="choosecpu('2')"><a href="javascript:void(0)">2核</a></li>
										<li onclick="choosecpu('4')"><a href="javascript:void(0)" >4核</a></li>
										<li onclick="choosecpu('8')"><a href="javascript:void(0)" >8核</a></li>
										<li onclick="choosecpu('16')"><a href="javascript:void(0)" >16核</a></li>
										<li onclick="choosecpu('32')"><a href="javascript:void(0)" >32核</a></li>
									</ul>
								</div>
								<div class="clear"></div>
							</div>
							<div class="product-from-row">
								<lable class="product-form-name">内存 ：</lable>
								<div class="product-form-cell">
									<ul class="item-01" id="memchoose">
										<li class="on" onclick="choosemem('2')"><a href="javascript:void(0)" >2G </a></li>
										<li onclick="choosemem('4')"><a href="javascript:void(0)" >4G</a></li>
										<li onclick="choosemem('8')"><a href="javascript:void(0)" >8G</a></li>
										<li onclick="choosemem('12')"><a href="javascript:void(0)" >12G</a></li>
										<li onclick="choosemem('16')"><a href="javascript:void(0)" >16G</a></li>
										<!--<li onclick="choosemem('32')"><a href="javascript:void(0)" >32G</a></li>
										<li onclick="choosemem('64')"><a href="javascript:void(0)" >64G</a></li>
									--></ul>
								</div>
								<div class="clear"></div>
							</div>
							<div class="product-from-row">
							<lable class="product-form-name">操作系统 ：</lable>
								<div class="product-form-cell">
									<div class="product-sel-system">
										<div class='str-select-system'>
											<select id='xt'>
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
								<div class="product-form-cell" style="margin-top:10px;margin-left:97px;" id="disk3">
									<div class="uc-slider1">
										<div class="range1 bg-01">
											<span class="block m5">600G</span>
											<span class="block m200">2000G</span>
										</div>
										<div class="strip"><span class="chunk"></span></div>
									</div>
									<div class="num1"><input id="hard3" type="text" value="0" />  G</div>
									<div class="close1_3" ></div>
								</div>
								<div class="product-form-cell" style="margin-top:10px;margin-left:97px;" id="disk4">
									<div class="uc-slider1">
										<div class="range1 bg-01">
											<span class="block m5">600G</span>
											<span class="block m200">2000G</span>
										</div>
										<div class="strip"><span class="chunk"></span></div>
									</div>
									<div class="num1"><input id="hard4" type="text" value="0" />  G</div>
									<div class="close1_4" ></div>
								</div>
								<div class="clear"></div>
							</div>
							
							<div class="product-from-row">
								<div class="product-form-cell">
									<span class="addDisk" style="margin-left:100px;margin-top:10px;">+增加一块</span>
								</div>
								<div><span style="color: #a4a4a4;">最多可添加两块盘</span></div>
								<div class="clear"></div>
							</div>
							
						</div>
							<img src="/icpserver/icp/orderbuy/images/wangluo.png" />
							<div style="padding-left: 100px;">
							<div class="product-from-row">
								<lable class="product-form-name">接入模式 :</lable>
								<div class="product-form-cell" style="width:700px;">
									
								<ul class="item-01" id="imodechoose">
								    <li onclick="chooseimode1()"><a href="javascript:void(0)">联通</a></li>
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
								<ul class="item-01" id="imodechoose">
									<li onclick="chooseimode2()"><a href="javascript:void(0)" >移动</a></li>
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
								<ul class="item-01" id="imodechoose">
									<li onclick="chooseimode3()"><a href="javascript:void(0)" >电信</a></li>
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
								<img src="/icpserver/icp/orderbuy/images/qita.png" />
							<div style="padding-left: 100px;">
								
								<div class="product-from-row">
								<lable class="product-form-name">其他服务 ：</lable>
								<div class="product-form-cell">
									<ul class="item-01" id="imodechoose">
								    	<li onclick="choosesafe()"><a href="javascript:void(0)">杀毒软件</a></li>
									</ul>
								</div>
								<div class="clear"></div>
								</div>
							</div>
						
							<img src="/icpserver/icp/orderbuy/images/quyushichang.png" />
							<div style="padding-left: 100px;">
							<div class="product-from-row">
								<lable class="product-form-name">订购时长 ：</lable>
								<div class="product-form-cell">
									<div class="uc-slider" id="uc-duration">
										<div class="range">
											<span class="block mm hover"><t>1</t><i class="on"></i><div class="chunk-2" style="display:block;"><div class="val" style="display:block">1个月</div></div></span>
											<span class="block mm"><t>2</t><i></i><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block mm"><t>3</t><i></i><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block mm"><t>4</t><i></i><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block mm"><t>5</t><i></i><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block mm"><t>6</t><i></i><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block mm"><t>7</t><i></i><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block mm"><t>8</t><i></i><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block mm"><t>9</t><i></i><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block yy"><t>1年</t><b></b><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block yy"><t>2年</t><b></b><div class="chunk-2"><div class="val"></div></div></span>
											<span class="block yy"><t>3年</t><b></b><div class="chunk-2"><div class="val"></div></div></span>
										
										</div>
									</div>	
								</div>
								<div class="clear"></div>
							</div>
							<div class="product-from-row">
							<lable class="product-form-name">&nbsp;</lable>
								<div class="product-form-cell">
								</div>
								<div class="info info-t">订购1年的服务花10个月的钱！</div>
								<div class="clear"></div>
							</div>
							</div>
						</div>
						<div class="product-from-sum">
							<div class="product-from-row" style="padding-left: 100px;">
									<lable class="product-form-name">订购数量 ：</lable>
									<div class="product-form-cell">
										<div class="product-form-add">
											<span class="form-sub">-</span>
											   <input id="number" type="text" value="1" />
											<span class="form-add">+</span>
										</div>
									</div>
							</div>
							
						</div>	
					</div>
				</div>

			</div>
			<div style="float:right;width:280px;background-color:#f5f5f5;margin-top:10px;">
			<div  style="height:30px;background-color: #23a0bf; padding-top:5px;padding-left:5px;"><font color="white" size="4">当前配置</font></div>
			<div class="container-cell">
			  <div class="product-details" style="padding-left:10px;">
			     <div>
                    
                    <div><font size="2">CPU：</font><font id="current_cpu" size="2"></font></div>
                    <div><font size="2">内存：</font><font id="current_mem" size="2"></font></div>
                   
                    <div><font size="2">数据盘1：</font><font id="current_hard1" size="2"></font></div>
                    <div><font size="2">数据盘2：</font><font id="current_hard2" size="2"></font></div>
                   <%-- <div><font size="2">数据盘3：</font><font id="current_hard3" size="2"></font></div>
                    <div><font size="2">数据盘4：</font><font id="current_hard4" size="2"></font></div>--%>
                    <div><font size="2">系统盘：</font><font id="current_store" size="2"></font></div>
                    <div><font size="2">操作系统：</font><font id="current_xt" size="2"></font></div>
                    <!--<div><font size="2">公网IP：</font><font id="current_ip" size="2"></font>个</div>
                    <div><font size="2">独立虚拟防火墙：</font><font id="current_firewall" size="2"></font></div>
                    
                    -->
                    <div><font size="2">接入模式：</font><font id="current_imode" size="2"></font></div>
                    <div><font size="2">公网端口：</font><font id="current_interport" size="2"></font></div>
                    <!--<div><font size="2">内网端口：</font><font id="current_intraport" size="2"></font></div>
                    
                    --><div><font size="2">公网带宽：</font><font id="current_interbw" size="2"></font></div>
                    <div><font size="2">杀毒软件：</font><font id="current_sdrj" size="2"></font></div>
                    <!--<div><font size="2">内网带宽：</font><font id="current_intrabw" size="2"></font>M</div>
                    --><div><font size="2">订购时长：</font><font id="current_time" size="2"></font></div>
                    <div><font size="2">区域选择：</font><font id="current_region" size="2"></font></div>
                    <div><font size="2">台数：</font><font id="current_number" size="2"></font></div>
                  </div> 
                   <!--<div style="height: 146px; ">
                   <h5>配置费用:</h5>
                       <font id="price" size="5" color="red"></font>
                   </div>
                   --><div>
                     <!--<input type="button" class="button" id="calbutton" value="计算价格" onclick="calculate()"/>
                     --><input type="button" class="button" value="加入清单" onclick="insertlist()"/>
                   </div>
                
               
                <div class="clear"></div>
                <div style="height: 30px;">
								</div>
                <div>
                <h4>订购清单:</h4>
                   <table id="testTbl">
                   
                   </table>
                   <input type="hidden" id="shopliststr" name="shopliststr"/>
                   <input type="hidden" id="shopid" name="shopid" value="DIY">
                   <input type="button" class="button" value="立即订购" onclick="buy()"/>
                </div>
			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>
			</div>
			</div>
			<input type="hidden" id="cpu" name="cpu" value="2">
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
			<input type="hidden" id="regionname" name="regionname" value="济南">		
		</div>
	</div>
   </form>
</body>

</html>
<script type="text/javascript">

 var shoplist = new Array();
 var shoplistid=0;
  var shoplistcookie= $.cookie('shopliststr');
 if(shoplistcookie!=null&&shoplistcookie!=''){
              
              shoplist = shoplistcookie.split(':');
              for(var i=0;i<shoplist.length;i++){
                var line = shoplist[i];
                //alert(line);
                if(line!=''){
                   var linearray = line.split(',');
                  // createtableline(linearray[19],linearray[20],linearray[2],linearray[3],linearray[4]);
                   
                   if( "server" == linearray[0]){
                	   //server,DIY,2,2,120,120,0,0,0,40,CentOS5.8-64bit,1,0,0,1,,,,1,1,6,00001
	                   createtablelineServer(linearray[19],linearray[20],linearray[2],linearray[3],linearray[4]);
                   }
                   if("DB" == linearray[0]){
                	   //DB,DIY,mysql,5.5,310,130,2,6,00001
                	   var zonenames = '';
                		if(linearray[8] == '00001'){
                			zonenames="济南"
                			}else{
                			zonenames="绵阳"
                			}
           			var db = {
           				dbtype:linearray[2],
           				dbversion:linearray[3],
           				hard1:linearray[4],
           				mem1:linearray[5],
           				timelength:linearray[7],
           				regionname:zonenames,
           				choosenumber:linearray[6],
           				region:linearray[8]
           				
           			};
           			createtableline(db);
                	  // createtablelineServer();
                   }
                   
                }
                shoplistid++;
              }
  }
//根据选择的操作系统分配系统盘  
$('.str-select-system select').select({
		endFun:function(param,text,dataPath,_this){
			if(_this.attr('id')=='xt'){
				if(_this.val().indexOf('Win') != -1){
				   document.getElementById("xtp").innerHTML= '60G';
				   $("#store").val(60);
				}else{
				   document.getElementById("xtp").innerHTML= '40G';
				   $("#store").val(40);
				}
			}
		}
});  
        function calculate(){
          //公网带宽
         var chooseinterbw = "";
          //公网端口
         var chooseinterport = "";
          var choosecpu = $("#cpu").val();
          var choosemem = $("#mem").val();
          //var choosehard = $("#hard").val();
          var choosehardstr = "";
		  var choosehard1 = parseInt($("#hard1").val());
		   if(choosehard1 != 0){
			choosehardstr = choosehardstr + "数据盘1：" + $("#hard1").val() + "G";
		   }
		  var choosehard2 = parseInt($("#hard2").val());
		   if(choosehard2 != 0){
			choosehardstr = choosehardstr + ",数据盘2：" + $("#hard2").val() + "G";
		   }
	/*	  var choosehard3 = parseInt($("#hard3").val());
		   if(choosehard3 != 0){
			choosehardstr = choosehardstr + ",数据盘3：" + $("#hard3").val() + "G";
		    }
		  var choosehard4 = parseInt($("#hard4").val());
		   if(choosehard4 != 0){
			choosehardstr = choosehardstr + ",数据盘4：" + $("#hard4").val() + "G";
		   }*/
          var choosestore = $("#store").val();
          var choosesystem = $('#xt').val();
          //var chooseip = $('#ip').val();
          //var choosefirewall = $('#firewall').val();
          //var chooseintrabw = $('#intrabw').val();
          //var chooseimode = $('#imode').val();
          //接入模式
          var mode1=$('#imode1').val();
          var mode2=$('#imode2').val();
          var mode3=$('#imode3').val();
         
      	 if(mode1=='1'&&mode2=='0'&&mode3=='0'){
      	 	$('#imode').val('1');
      	 	$('#imodename').val('联通单线');
      	 	chooseinterbw = chooseinterbw + "联：" + $("#ltinterbw").val() + "M";
      	 	 if($("#ltinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "联：" + $("#ltinterport").val();
      	 	}
      	 }else if(mode1=='0'&&mode2=='1'&&mode3=='0'){
      	 	$('#imode').val('2');
      	 	$('#imodename').val('移动单线');
      	 	chooseinterbw = chooseinterbw + "移：" + $("#ydinterbw").val() + "M";
      	 	if($("#ydinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "移：" + $("#ydinterport").val();
      	 	}
      	 }else if(mode1=='0'&&mode2=='0'&&mode3=='1'){
      	 	$('#imode').val('3');
      	 	$('#imodename').val('电信单线');
      	 	chooseinterbw = chooseinterbw + "电：" + $("#dxinterbw").val() + "M";
      	 	if($("#dxinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "电：" + $("#dxinterport").val();
      	 	}
      	 }else if(mode1=='1'&&mode2=='1'&&mode3=='0'){
      	 	$('#imode').val('4');
      	 	$('#imodename').val('联通移动双线');
      	 	chooseinterbw = chooseinterbw + "联：" + $("#ltinterbw").val() + "M"+ "&nbsp;移：" + $("#ydinterbw").val() + "M";
      	 	if($("#ltinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "联：" + $("#ltinterport").val();
      	 	}
      	 	if($("#ydinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "&nbsp;移：" + $("#ydinterport").val();
      	 	}
      	 }else if(mode1=='1'&&mode2=='0'&&mode3=='1'){
      	 	$('#imode').val('5');
      	 	$('#imodename').val('联通电信双线');
      	 	chooseinterbw = chooseinterbw + "联：" + $("#ltinterbw").val() + "M"+ "&nbsp;电：" + $("#dxinterbw").val() + "M";
      	 	if($("#ltinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "联：" + $("#ltinterport").val();
      	 	}
      	 	if($("#dxinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "&nbsp;电：" + $("#dxinterport").val();
      	 	}
      	 }else if(mode1=='0'&&mode2=='1'&&mode3=='1'){
      	 	$('#imode').val('6');
      	 	$('#imodename').val('移动电信双线');
      	 	chooseinterbw = chooseinterbw + "移：" + $("#ydinterbw").val() + "M"+ "&nbsp;电：" + $("#dxinterbw").val() + "M";
      	 	if($("#ydinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "移：" + $("#ydinterport").val();
      	 	}
      	 	if($("#dxinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "&nbsp;电：" + $("#dxinterport").val();
      	 	}
      	 }else if(mode1=='1'&&mode2=='1'&&mode3=='1'){
      	 	$('#imode').val('7');
      	 	$('#imodename').val('联通移动电信三线');
      	 	chooseinterbw = chooseinterbw + "联：" + $("#ltinterbw").val() + "M"+"&nbsp;移：" + $("#ydinterbw").val() + "M"+ "&nbsp;电：" + $("#dxinterbw").val() + "M";
      	 	if($("#ltinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport +"联：" + $("#ltinterport").val();
      	    }
      	    if($("#ydinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "&nbsp;移：" + $("#ydinterport").val();
      	    }
      	    if($("#dxinterport").val() != '多个端口请用半角逗号隔开'){
      	 	chooseinterport = chooseinterport + "&nbsp;电：" + $("#dxinterport").val();
      	    }
      	 }else {
      	 	$('#imode').val('0');
      	 	$('#imodename').val('');
      	 	chooseinterbw = '';
      	 	chooseinterport = '';
      	 }
          //chooseimode();
          //var chooseinterbw = $('#interbw').val();
          
         // var chooseinterport = $('#interport').val();
          //var chooseintraport = $('#intraport').val();
          
          var choosenumber = $('#number').val();
          //杀毒软件
          var choosesafe = $('#safesoft').val();
          var timelength = $("#time").val();
          var chooseregion = $("#region").val();
          var totalprice;
          /*var totalprice =( price_cpu[choosecpu]+price_mem[choosemem]+price_hard[choosehard]+price_store[choosestore]+price_ip[chooseip]+price_firewall[choosefirewall]
                           +price_intrabw*chooseintrabw+price_interbw*chooseinterbw)*timelength + price_system[choosesystem];*/
          	/* document.getElementById("calbutton").disabled=true;
			   var request = $.ajax({  
			        url: "<%=basePath%>/calculateprice.do",  
			        type: "POST",  
			        dataType : 'text',  
			        data:{
			            shopid:'DIY',
			        	choosecpu:choosecpu,
			        	choosemem:choosemem,
			        	choosehard:choosehard,
			        	choosestore:choosestore,
			        	//chooseip:chooseip,
			        	//choosefirewall:choosefirewall,
			        	//chooseintrabw:chooseintrabw,
			        	chooseimode:chooseimode,
			        	chooseinterbw:chooseinterbw,
			        	choosesystem:choosesystem,
			        	choosenumber:choosenumber,
			        	timelength:timelength,
			        	chooseregion:chooseregion
			        },
			        success: function (r) {
			            // alert(r);
			             totalprice = r;
			             document.getElementById("price").innerHTML = "暂不提供";
			        },  
			        error: function (XMLHttpRequest, textStatus, errorThrown) { 
			           alert("计算失败 !"); 
			        }  
			    }); */
		  
	          document.getElementById("current_cpu").innerHTML= choosecpu+'核';
	          document.getElementById("current_mem").innerHTML= choosemem+'G';
	          //document.getElementById("current_hard").innerHTML= choosehard+'G';
	          document.getElementById("current_hard1").innerHTML= choosehard1+'G';
			  document.getElementById("current_hard2").innerHTML= choosehard2+'G';
//			  document.getElementById("current_hard3").innerHTML= choosehard3+'G';
//			  document.getElementById("current_hard4").innerHTML= choosehard4+'G';
	          document.getElementById("current_store").innerHTML= choosestore+'G';
	          document.getElementById("current_xt").innerHTML= $("#xt").find("option:selected").text();
	          //document.getElementById("current_ip").innerHTML= $("#ip").find("option:selected").text();
	          //document.getElementById("current_firewall").innerHTML= $("#firewall").find("option:selected").text();
	         // document.getElementById("current_intrabw").innerHTML= chooseintrabw;
	          document.getElementById("current_imode").innerHTML= $('#imodename').val();
	          document.getElementById("current_interport").innerHTML= chooseinterport;
	          //document.getElementById("current_intraport").innerHTML= chooseintraport;
	          document.getElementById("current_interbw").innerHTML= chooseinterbw;
	          document.getElementById("current_time").innerHTML= timelength+'个月';
	          if(choosesafe == '1'){
	          document.getElementById("current_sdrj").innerHTML= "使用";
	          }else{
	          document.getElementById("current_sdrj").innerHTML= "不使用";
	          }
	           
	          document.getElementById("current_region").innerHTML= $("#regionname").val();
	          document.getElementById("current_number").innerHTML= $("#number").val();
	          //document.getElementById("calbutton").disabled=false;  
        }
        function insertlist(){
       
          calculate();//计算价格
          
          var choosecpu = $("#cpu").val();
          var choosemem = $("#mem").val();
          //var choosehard = $("#hard").val();
          var choosehard = parseInt($("#hard1").val()) + 
   					parseInt($("#hard2").val()) + 
   					parseInt($("#hard3").val()) + 
   					parseInt($("#hard4").val());
   		  var choosehard1 = parseInt($("#hard1").val());
	      var choosehard2 = parseInt($("#hard2").val());
	   	  var choosehard3 = parseInt($("#hard3").val());
	   	  var choosehard4 = parseInt($("#hard4").val());
          var choosestore = $("#store").val();
          var choosesystem = $('#xt').val();
          //var chooseip = $('#ip').val();
          //var choosefirewall = $('#firewall').val();
         // var chooseintrabw = $('#intrabw').val();
          var chooseimode = $('#imode').val();
          var chooseltinterbw = parseInt($("#ltinterbw").val());
          var chooseydinterbw = parseInt($("#ydinterbw").val());
          var choosedxinterbw = parseInt($("#dxinterbw").val());
           if($('#imode1').val()=='1'){
          	chooseltinterbw = $('#ltinterbw').val();
          	}
          	if($('#imode2').val()=='1'){
          	chooseydinterbw = $('#ydinterbw').val();
         	}
          	if($('#imode3').val()=='1'){
         	choosedxinterbw = $('#dxinterbw').val();
         	}
          var chooseltinterport = "";
          if($('#imode1').val()=='1'&&$("#ltinterport").val() != '多个端口请用半角逗号隔开'){
          chooseltinterport = $('#ltinterport').val().replace(/,/g,"@");
          }
          var chooseydinterport = "";
           if($('#imode2').val()=='1'&&$("#ydinterport").val() != '多个端口请用半角逗号隔开'){
          chooseydinterport = $('#ydinterport').val().replace(/,/g,"@");
          }
          var choosedxinterport = "";
           if($('#imode3').val()=='1'&&$("#dxinterport").val() != '多个端口请用半角逗号隔开'){
          choosedxinterport = $('#dxinterport').val().replace(/,/g,"@");
          }
          //alert(chooseinterport);
          //var chooseintraport = $('#intraport').val().replace(/,/g,"@");
          
          var choosenumber = $('#number').val();
          
          var choosesafe = $('#safesoft').val();
          var timelength = $("#time").val();
          var chooseregion = $("#region").val();
          
          shoplist[shoplistid] = 'server,'+'DIY,'+choosecpu+','+choosemem+','+choosehard+','+choosehard1+','+choosehard2+','+choosehard3+','+
          choosehard4+','+choosestore+','+choosesystem+','+chooseltinterbw+','+chooseydinterbw+','+choosedxinterbw+','+
          chooseimode+','+chooseltinterport+','+chooseydinterport+','+choosedxinterport+','+
          choosesafe+','+choosenumber+','+timelength+','+chooseregion;
          
          createtablelineServer(choosenumber,timelength,choosecpu,choosemem,choosehard);
          var shopliststr = shoplist.join(":")
          $.cookie("shopliststr",shopliststr,{ path: '/' }); 
          shoplistid++;
        }
        
        function createtableline(db){
            var newTr = testTbl.insertRow();
            var newTd0 = newTr.insertCell();
            var newTd1 = newTr.insertCell();
 	       var newTd2 = newTr.insertCell();
 	       ///var newTd3 = newTr.insertCell();
 	      // var newTd4 = newTr.insertCell();
 	      // var newTd5 = newTr.insertCell();
 	      // var newTd6 = newTr.insertCell();
 	  /*     配置： 360MB内存，10GB存储空间，120次每秒，MySQL 5.5 
 地域：华南区-广州
 所属网络：基础网络 */
 			console.log(db);
 	       newTd0.innerHTML = '<font size="2">云数据库'+db.mem1+'M内存'+db.hard1+'G存储空间'+db.dbtype+'数据库'+db.dbversion+'版本'+db.timelength+'个月'+db.regionname+'地区</font>';
 	       
            newTd1.innerHTML = '&nbsp&nbsp<a  href="javascript:void(0);" onclick="orderdetail('+shoplistid+')"><font size="2" color="blue">配置</font></a>';
            newTd2.innerHTML = '&nbsp &nbsp<a href="javascript:void(0);" onclick="clearshop(this,'+shoplistid+')"><font size="2">x</font></a>';
         }
        
        function createtablelineServer(num,timelength,cpu,mem,hard){
           var newTr = testTbl.insertRow();
           var newTd0 = newTr.insertCell();
           var newTd1 = newTr.insertCell();
	       var newTd2 = newTr.insertCell();
	       ///var newTd3 = newTr.insertCell();
	      // var newTd4 = newTr.insertCell();
	      // var newTd5 = newTr.insertCell();
	      // var newTd6 = newTr.insertCell();
	       newTd0.innerHTML = '<font size="2">云服务器'+cpu+'核'+mem+'G'+hard+'G'+num+'台'+timelength+'个月</font>';
	       
           newTd1.innerHTML = '&nbsp&nbsp<a  href="javascript:void(0);" onclick="orderdetail('+shoplistid+')"><font size="2" color="blue">配置</font></a>';
           newTd2.innerHTML = '&nbsp &nbsp<a href="javascript:void(0);" onclick="clearshop(this,'+shoplistid+')"><font size="2">x</font></a>';
        }
        function clearshop(r,id){
           DelRowNew(r);
        
           shoplist[id] = '';
           var shopliststr = shoplist.join(":")
          $.cookie("shopliststr",shopliststr,{ path: '/' }); 
        }
        
        function DelRowNew(r){
	        var i=r.parentNode.parentNode.rowIndex;
	        document.getElementById('testTbl').deleteRow(i);
        }
        function orderdetail(listid){
            
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
			virusnames="使用"
			}else{
			virusnames="不使用"
			}
			//区域转换
			var zonenames="";
			if(configure[21] == '00001'){
			zonenames="济南"
			}else{
			zonenames="绵阳"
			}
            var shopstr = '类型：'+configure[0]+'，型号：'+configure[1]+'，CPU：'+configure[2]+'核，内存：'+
            configure[3]+'G，数据盘：'+configure[4]+'G，其中数据盘1：'+configure[5]+'G，数据盘2：'+configure[6]+'G，'//数据盘3：'+
//    				configure[7]+'G，数据盘4：'+configure[8]+'G，' +
                    +'系统盘：'+configure[9]+'G，操作系统：'+
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
            
//          debugger;
          //$.cookie("shopliststr",null); 
          
           var shopliststr = shoplist.join(":");
          document.getElementById("shopliststr").value=shopliststr;
          document.forms[0].action='<%=basePath%>/orderconfirm.do';
          document.forms[0].submit();
          }
          
        }
        
        function choosecpu(value){
        
           $('#cpu').val(value);
           if(value=='2'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('2')\"><a href=\"javascript:void(0)\" >2G </a></li><li onclick=\"choosemem('4')\"><a href=\"javascript:void(0)\" >4G </a></li><li onclick=\"choosemem('8')\"><a href=\"javascript:void(0)\" >8G</a></li><li onclick=\"choosemem('12')\"><a href=\"javascript:void(0)\" >12G</a></li><li onclick=\"choosemem('16')\"><a href=\"javascript:void(0)\" >16G</a></li>");
             $('#mem').val('2');
           }else if(value=='4'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('4')\"><a href=\"javascript:void(0)\" >4G </a></li><li onclick=\"choosemem('8')\"><a href=\"javascript:void(0)\" >8G </a></li><li onclick=\"choosemem('12')\"><a href=\"javascript:void(0)\" >12G </a></li><li onclick=\"choosemem('16')\"><a href=\"javascript:void(0)\" >16G</a></li><li onclick=\"choosemem('24')\"><a href=\"javascript:void(0)\" >24G </a></li><li onclick=\"choosemem('32')\"><a href=\"javascript:void(0)\" >32G</a></li>");
             $('#mem').val('4');
           }else if(value=='8'){
          
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('8')\"><a href=\"javascript:void(0)\" >8G</a></li><li onclick=\"choosemem('16')\"><a href=\"javascript:void(0)\" >16G </a></li><li onclick=\"choosemem('24')\"><a href=\"javascript:void(0)\" >24G </a></li><li onclick=\"choosemem('32')\"><a href=\"javascript:void(0)\" >32G</a></li><li onclick=\"choosemem('64')\"><a href=\"javascript:void(0)\" >64G</a></li>");
             $('#mem').val('8');
           }else if(value=='16'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('32')\"><a href=\"javascript:void(0)\" >32G</a></li><li onclick=\"choosemem('64')\"><a href=\"javascript:void(0)\" >64G</a></li>");
             $('#mem').val('32');
           }else if(value=='32'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('64')\"><a href=\"javascript:void(0)\" >64G</a></li>");
             $('#mem').val('64');
           }else if(value=='1'){
             $("#memchoose").html("<li class=\"on\" onclick=\"choosemem('2')\"><a href=\"javascript:void(0)\" >2G </a></li><li onclick=\"choosemem('4')\"><a href=\"javascript:void(0)\" >4G</a></li>");
             $('#mem').val('2');
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
           $('#mem').val(value);
        }
        function choosehard(value){$('#hard').val(value);}
        function chooseimode1(){
        var obj1 =  $('.product-form-cell').eq(10).find('.item-01').children('li');
        if(obj1.hasClass('on'))
      	 {
      	 	$('#imode1').val('0');
      	 	$('#ltinterport').val('');
      	 	$('#ltinterbw').val('');
      	 	
      	 }else{
      	 
			 $('#imode1').val('1');
		}
          }
        function chooseimode2(){
        var obj2 =  $('.product-form-cell').eq(11).find('.item-01').children('li');
        if(obj2.hasClass('on'))
      	 {
      	 	$('#imode2').val('0');
      	 	$('#ydinterport').val('');
      	 	$('#ydinterbw').val('');
      	 }else{
      	 
			 $('#imode2').val('1');
		}
          }
       function chooseimode3(){
        var obj3 =  $('.product-form-cell').eq(12).find('.item-01').children('li');
        if(obj3.hasClass('on'))
      	 {
      	 	$('#imode3').val('0');
      	 	$('#dxinterport').val('');
      	 	$('#dxinterbw').val('');
      	 }else{
      	 
			 $('#imode3').val('1');
		}
          }   
       /* function chooseimode(){
         
      	   
        }*/
        
        function choosestore(value){$('#store').val(value);}
        
        
        function chooseregion(value,name){
	        $('#region').val(value);
	        //alert(name);
	        $('#regionname').val(name);
        }
 
 
</script>
