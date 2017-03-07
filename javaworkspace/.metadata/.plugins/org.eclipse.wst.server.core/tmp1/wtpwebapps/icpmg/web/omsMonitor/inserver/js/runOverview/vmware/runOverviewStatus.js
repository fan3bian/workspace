(function($){
	
//	var neid = "于颜华-采集机";
	var neid = inserver_neid ;
	var inserver_status_action = context_path + "/inserver_runoverview/getInserverRunStatus.do";
	var inserver_alarmnum_action = context_path + "/inserver_runoverview/getInserverRunAlarm.do";
	
/********************************************************************************************
 *跳转至详情 
 */
	
	$('#inserver-more').click(function(){
		pass_neid = neid;
		$('#centerTab').panel({
			href:'/icpmg/web/omsMonitor/inserver/jsp/inserverDetails.jsp',
			queryParams:{
				neid:pass_neid
			 }
			});	
	});

/********************************************************************************************
/*
 *  加载健康状态、计费状态、设备名称、IP地址
 */
	
	function setStatusMessage(healthStatus,feeStatus,nename,ipaddr)
	{
		if(healthStatus == "1")
		{
			$("#inserver-health").css(
				{
					background:"url(" + context_path + "/web/omsMonitor/inserver/img/runOverview/health.png)"
				}
			);
			$('#inserver-health-title').empty();
			$('#inserver-health-title').append('运行中');
			$('#inserver-health').prop('title','设备：' + neid + ' 正常运行中');
		}else
		{
			$('#inserver-health-title').empty();
			$('#inserver-health-title').append('已停止');
			$('#inserver-health').prop('title','设备：' + neid + ' 已停止');
		}
		
		if(nename == undefined )
			{
				nename = '未知';
			}
		if(ipaddr == undefined)
			{
				ipaddr = '未知';
			}
		
		$("#inserver-nename").empty();
		$("#inserver-nename").append("虚拟机名称 : &nbsp;&nbsp;&nbsp" + neid);
		$("#inserver-ipaddr").empty();
		$("#inserver-ipaddr").append("虚拟机IP地址 : " + ipaddr);
	}	
	
	function setStatusTime(day,hour,minute,buytime,testtime,usetime,useendtime)
	{
		if(buytime == undefined)
		{
			buytime = '未知';
		}
		if(testtime == undefined)
		{
			testtime = '未知';
			$("#inserver-running-time").empty();
		}else
		{
			$("#inserver-day").empty();
			$("#inserver-day").append(day);
			$("#inserver-hour").empty();
			$("#inserver-hour").append(hour);
			$("#inserver-min").empty();
			$("#inserver-min").append(minute);
		}
		if(usetime == undefined)
		{
			usetime = '未知';
		}
		if(useendtime == undefined)
		{
			useendtime = '未知';
		}
		
		
		$('#inserver-buy-time').empty();
		$('#inserver-buy-time').append("创建时间:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + buytime);
		
		$('#inserver-test-time').empty();
		$('#inserver-test-time').append("试运行时间:&nbsp;&nbsp;" + testtime);
		
		$('#inserver-use-time').empty();
		$('#inserver-use-time').append("入网时间:&nbsp;&nbsp;" + usetime);
		
		$('#inserver-useend-time').empty();
		$('#inserver-useend-time').append("退网时间:&nbsp;&nbsp;"+ useendtime);
	}
	
	//健康hover
	$('#inserver-health').hover
	(
		      function () 
		      {
		          $(this).css(
		        	{
		        	    'filter':'alpha(opacity=60)',  
		            	'-moz-opacity':'0.6',
		            	'-khtml-opacity': '0.6',  
		            	'opacity': '0.6',
						'cursor':'pointer'
		        	}
		          );
		      },
		      function () 
		      {
		    	  $(this).css(
				        	{
				        	    'filter':'alpha(opacity=100)',  
				            	'-moz-opacity':'1',
				            	'-khtml-opacity': '1',  
				            	'opacity': '1',
				            	'cursor':'pointer'
				        	}
		    	  );
		      }
	);
	
/***************************************************************************************************
/**
 * 加载告警数量、正常运行时间
 */	
	
	//获取状态信息及时间信息
	$.ajax
		({
		 	type : 'post',
			async:true, 
			data:{neid:neid},
			url:inserver_status_action,
			dataType:'json',
			success:
				function(ret)
				{
					setStatusMessage(ret.opstat,ret.feestat,ret.nename,ret.ipaddr);
					setStatusTime(ret.day,ret.hour,ret.minute,
							ret.buytime,ret.testtime,ret.usetime,ret.useendtime);
				}
		});
	
	//获取对应设备的告警数量
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{neid:neid},
		url:inserver_alarmnum_action,
		dataType:'json',
		success:
			function(ret)
			{
				$("#inserver-alarm-num").empty();
				$("#inserver-alarm-num").append('&nbsp;' + ret + '&nbsp;');
			}
	});
	
/***************************************************************************************************/	
/**
 * 悬浮导航
 */
	function b()
	{
		h = $(window).height();
		t = $("#centerTab").scrollTop();
		if(t > h){
			$('#inserver-gotop').show();
		}else{
			$('#inserver-gotop').hide();
		}
	}
	
	
	h = $(window).height();
	t = $("#centerTab").scrollTop();
	if(t > h)
	{
		$('#inserver-gotop').show();
	}else
	{
		$('#inserver-gotop').hide();
	}
	
	b();

	
	$('#inserver-gotop').click(function(){
		$("#centerTab").scrollTop(0);	
	});
	
	$('#inserver-go-usage').click(function(){
		$("#centerTab").animate({
			scrollTop: 120 ,
		 	}, 80
		);
	});
	$('#inserver-go-disk').click(function(){
//		$("#centerTab").scrollTop(430);	
		$("#centerTab").animate({
			scrollTop: 430 ,
		 	}, 80
		);
	});
	$('#inserver-go-computeindex').click(function(){
//		$("#centerTab").scrollTop(1280);
		if( $('#inserver-single-device-zone').prop('title') == 'hideDiskDetail')
		{
			$("#centerTab").animate({
				scrollTop: 1350 ,
			 	}, 80
			);	
		}else
		{
			$("#centerTab").animate({
				scrollTop: 1770 ,
			 	}, 80
			);
		}
		
	});
	
	$("#centerTab").scroll(function(e){
		b();		
	});
	
	
})(jQuery);