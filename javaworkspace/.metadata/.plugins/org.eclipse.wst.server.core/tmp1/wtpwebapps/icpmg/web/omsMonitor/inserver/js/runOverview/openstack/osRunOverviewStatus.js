(function($){
	
//	var nename = '7b363fee-4045-4371-8318-be59bdfd8520';
	var nename = osinserver_nename ;
	var osinserver_status_action = context_path + "/os_inserver_runoverview/getOSInserverRunStatus.do";
	var osinserver_alarmnum_action = context_path + "/os_inserver_runoverview/getOSInserverRunAlarm.do";
	
	
/********************************************************************************************
 *跳转至详情 
 */
	
	$('#osinserver-more').click(function(){
		pass_nename = nename;
		$('#centerTab').panel({
			href:'/icpmg/web/omsMonitor/inserver/jsp/inserverDetails.jsp',
			queryParams:{
				nename:pass_nename
			 }
			});	
	});

/********************************************************************************************	
/*
 *  加载健康状态、计费状态、设备名称、IP地址
 */

	function setStatusMessage(healthStatus,feeStatus,neid,ipaddr)
	{
		if(healthStatus == "1")
		{
			$("#osinserver-health").css(
					{
						background:"url(" + context_path + "/web/omsMonitor/inserver/img/runOverview/health.png)"
					}
			);
			$('#osinserver-health-title').empty();
			$('#osinserver-health-title').append('运行中');
			$('#osinserver-health').prop('title','设备：' + neid + ' 正常运行中');
		}else
		{
			$('#osinserver-health-title').empty();
			$('#osinserver-health-title').append('已停止');
			$('#osinserver-health').prop('title','设备：' + neid + ' 已停止');
		}	

		
		if(nename == undefined )
		{
			nename = '未知';
		}
		if(ipaddr == undefined)
		{
			ipaddr = '未知';
		}	
		
		$("#osinserver-nename").empty();
		$("#osinserver-nename").append("虚拟机名称 : &nbsp;&nbsp;&nbsp" + neid);
		$("#osinserver-ipaddr").empty();
		$("#osinserver-ipaddr").append("虚拟机IP地址 : " + ipaddr);
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
			$("#osinserver-running-time").empty();
		}else
		{
			$("#osinserver-day").empty();
			$("#osinserver-day").append(day);
			$("#osinserver-hour").empty();
			$("#osinserver-hour").append(hour);
			$("#osinserver-min").empty();
			$("#osinserver-min").append(minute);
		}
		if(usetime == undefined)
		{
			usetime = '未知';
		}
		if(useendtime == undefined)
		{
			useendtime = '未知';
		}
		
		$('#osinserver-buy-time').empty();
		$('#osinserver-buy-time').append("创建时间:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + buytime );
		
		$('#osinserver-test-time').empty();
		$('#osinserver-test-time').append("试运行时间:&nbsp;&nbsp;" + testtime);
		
		$('#osinserver-use-time').empty();
		$('#osinserver-use-time').append("入网时间:&nbsp;&nbsp;" + usetime);
		
		$('#osinserver-useend-time').empty();
		$('#osinserver-useend-time').append("退网时间:&nbsp;&nbsp;"+ useendtime);
		
		//健康hover
		$('#osinserver-health').hover
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
	}

/***************************************************************************************************
/**
 * 加载告警数量、正常运行时间
 */	
	
	//获取状态信息及时间信息
	$.ajax
		({
		 	type : 'post',
			async:true, 
			data:{nename:nename},
			url:osinserver_status_action,
			dataType:'json',
			success:
				function(ret)
				{
					setStatusMessage(ret.opstat,ret.feestat,ret.neid,ret.ipaddr);
					setStatusTime(ret.day,ret.hour,ret.minute,
							ret.buytime,ret.testtime,ret.usetime,ret.useendtime);
				}
		});
	
	//获取对应设备的告警数量
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{nename:nename},
		url:osinserver_alarmnum_action,
		dataType:'json',
		success:
			function(ret)
			{
				$("#osinserver-alarm-num").empty();
				$("#osinserver-alarm-num").append('&nbsp;' + ret + '&nbsp;');
			}
	});
/***************************************************************************************************/
/**
 * 悬浮导航
 */
	function theScroll()
	{
		h = $(window).height();
		t = $("#centerTab").scrollTop();
		if(t > h){
			$('#osinserver-gotop').show();
		}else{
			$('#osinserver-gotop').hide();
		}
	}
	
	
	h = $(window).height();
	t = $("#centerTab").scrollTop();
	if(t > h)
	{
		$('#osinserver-gotop').show();
	}else
	{
		$('#osinserver-gotop').hide();
	}
	
	theScroll();

	
	$('#osinserver-gotop').click(function(){
		$("#centerTab").scrollTop(0);	
	});
	
	$('#osinserver-go-usage').click(function(){
		$("#centerTab").animate({
			scrollTop: 120 ,
		 	}, 80
		);
	});
	$('#osinserver-go-computeindex').click(function(){
		$("#centerTab").animate({
			scrollTop: 430 ,
		 	}, 80
		);
	});
	$('#osinserver-go-network').click(function(){
		$("#centerTab").animate({
			scrollTop: 970 ,
		 	}, 80
		);
	});

	
	$("#centerTab").scroll(function(e){
		theScroll();		
	});
		
	
	
})(jQuery);