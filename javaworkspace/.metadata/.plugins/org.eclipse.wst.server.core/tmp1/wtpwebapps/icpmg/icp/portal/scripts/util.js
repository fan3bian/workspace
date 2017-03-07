$(function(){
	 getLoginStatus(function (data) {
       
        if(data.success) {
            $('.nologin').addClass('logined').removeClass('nologin').find('.user-name').text(data.msg);
            
        }
    });
	totop();
	allslide();
	scrollWidth();
	tableColor();
	vFocus();
	vDatepick();
	// vSelect();
	vBank();
	vOrder();
	vSubnav();
	//实时监控用户的输入 问题有可能是页面没有完全加载
	//当页面加载状态改变的时候执行这个方法
	document.onreadystatechange = function() {
		////当页面加载状态为完全结束时进入 
            if (document.readyState == "complete") {
            	//产品锚点
                vHash();
            }
	}
	//顶部导航固定
    $(window).scroll(function() {
        var top_bg=$('.top-bg'),
            top_bg_fix=$('.top-bg.top-fixed'),
            winLeft=$(document).scrollLeft(),
            widWidth=$(window).width();
        $(document).scrollTop() > 90 ? top_bg.addClass('top-fixed') : top_bg.removeClass('top-fixed');
        
        if(widWidth<=1200){
            top_bg_fix.css('left',-winLeft);
        }else{
            top_bg_fix.removeAttr('style');
        }
    });
})


$(window).on({
	'scroll':function(){
		yelloword();
	}
})
function getLoginStatus (callback) {
var that = this;
    $.ajax({
        url: that.getRootPath()+'/userMgr/LoginTransfer.do',
        cache: false,
        success: function (data) {
        	var r = jQuery.parseJSON(data);
            callback && callback(r);
        },
        error: function (e) {
            callback && callback(e);
        }
    })
}

//点击控制台跳转
function toHomeJsp(){
	var spanText = document.getElementById("logoutDiv").innerText;
		if( spanText == "" || spanText == "undefined" || spanText == undefined){//未登录，直接跳转到登录首页
			window.location.href = "/icpmg/login.jsp";
			}else{//否则跳转到控制台首页
				window.location.href = "/icpmg/web/Frames/authBase.jsp";
			}
				
}
			
	
 //js获取项目根路径，如： http://localhost:8083/uimcardprj
function getRootPath(){
    
        //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
        var curWwwPath = window.document.location.href;
        //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
        var pathName = window.document.location.pathname;
        var pos = curWwwPath.indexOf(pathName);
        //获取主机地址，如： http://localhost:8083
        var localhostPaht = curWwwPath.substring(0, pos);
        //获取带"/"的项目名，如：/uimcardprj
        var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
        return (localhostPaht + projectName+"/");
    }	
function totop(){
	var pop = $('.scrolltop').find('li');
	var _a = $('.header').outerHeight()+$('.nav').outerHeight();
	var _b = $('.banner').outerHeight()+_a;
	var _c = $('.servicer-box').outerHeight()+_b;
	var _d = $('.case-box').outerHeight()+_c;
	var arry = [_a,_b,_c]
	pop.each(function(e){
		$(this).click(function(){
			$('html,body').animate({scrollTop:arry[e]},500);
		})
	})
}
function yelloword(){
	var pop = $('.scrolltop').find('li');
	var _a = $('.header').outerHeight()+$('.nav').outerHeight();
	var _b = $('.banner').outerHeight()+_a;
	var _c = $('.servicer-box').outerHeight()+_b;
	var _d = $('.case-box').outerHeight()+_c;
	var nowt = $('html,body').scrollTop();
	if(nowt<_a||nowt>_d){
		pop.removeClass('on')
	}else if(nowt>=_a&&nowt<_b){
		pop.eq(0).addClass('on').siblings('').removeClass('on');
	}else if(nowt>=_b&&nowt<_c){
		pop.eq(1).addClass('on').siblings('').removeClass('on');
	}else if(nowt>=_c&&nowt<_d){
		pop.eq(2).addClass('on').siblings('').removeClass('on');
	}
}

// 轮播
function allslide(){
	$('.banner').slide({titCell: ".hd a",mainCell: ".bd ul",trigger: "click", effect: "leftLoop",autoPlay:"true"});
	$('.slide-box',$('.servicer-box')).slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"left",scroll:3,vis:3,pnLoop:false});
}

// 滚动条box
function scrollWidth(){
	var _wrap =$('.servicer-box');
	var slides = _wrap.children('.slide-box');
	var cont = _wrap.find('.scrollcont');
	var num = cont.children('ul').children('li').length;
	var _w = 225*num+30*(num-1);
	cont.width(_w)
	if( $.fn.myScroll != undefined ){
		$('.zScroll').myScroll({effect:'x'});
	}
	cont.children('ul').children('li').each(function(e){
		$(this).click(function(){
			$(this).addClass('on').siblings().removeClass('on');
			slides.eq(e).addClass('active').siblings('.slide-box').removeClass('active');
		})
	})
}

function tableColor(){
	$('.accounts-table tbody tr:odd').addClass('odd');
	$('.accounts-table tbody tr').each(function() {
		$(this).find('td:first').css('color','#fe9500')
	});
	$('.suggest-table tbody tr:odd').addClass('odd');

	
}

//输入款焦点文字
function vFocus(){
	$('input:text').each(function() {
		var _this = $(this)
		var val = _this.val();
		_this.focusin(function(event) {
			if(_this.val() == val){
				_this.val('');
			}
		}).focusout(function(event) {
			if(_this.val() == ''){
				_this.val(val);
			}
		});
	});
}

//日期选择器
function vDatepick(){
	if($('.dateStart').length >0 || $( ".report-time" ).length >0){
		$.datepicker.regional['zh-CN'] = {
	        closeText: '关闭',
	        prevText: '&#x3c;',
	        nextText: '&#x3e;',
	        currentText: '今天',
	        monthNames: ['1','2','3','4','5','6',
	        '7','8','9','10','11','12'],
	        monthNamesShort: ['一','二','三','四','五','六',
	        '七','八','九','十','十一','十二'],
	        dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
	        dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
	        dayNamesMin: ['日','一','二','三','四','五','六'],
	        weekHeader: '周',
	        dateFormat: 'yy-mm-dd',
	        firstDay: 0,
	        isRTL: false,
	        showMonthAfterYear: true,
	        yearSuffix: '.'};
	    $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
		// $( ".calendar" ).datepicker({
		// 		inline: true,
		// 		beforeShowDay: function(date) {
		// 			var now = new Date();
		// 			if (date.getTime()+24*3600000 < now.getTime()) {
		// 				return [true, 'disable'];
		// 			} else {
		// 				return [true];
		// 			}
		// 		}
		// 	});
		$( ".dateStart" ).datepicker({
			 showOtherMonths: true
		});
		$( ".dateEnd" ).datepicker();
		$( ".report-time" ).datepicker();
	}
}
//下拉框
// function vSelect(){
// 	$('.select-show .infor').each(function() {
// 		var _this = $(this);
// 		_this.click(function(event) {
// 			_this.find('ul').stop().slideDown();
// 		});
// 		_this.find('ul li').click(function(event) {
// 			event.stopPropagation();
// 			_this.find('p').html($(this).html());
//             $(this).parent().stop().slideUp()
// 		});
// 	});
// }

//充值银行选择
function vBank(){
	$('.pay-way .way-select').click(function(event) {
		var index = $('.pay-way .way-select').index($(this));
		$('.pay-bank-wrap .pay-bank').hide().eq(index).show();
	});
}

//订单详情
function vOrder(){
	//详情
	$(document).on('click','.accounts-table a.xq',function(){
		//ajax加载数据
		$.ajax({
            url: '/path/to/file',
            type: 'default GET (Other values: POST)',
            dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
            data: {param1: 'value1'},
            success:function(data){
            	/*$('.popup .xq .con').html(data);
		        $('.popup').show();
		        $('.popup .xq').show();
		        var height = $('.popup .xq').outerHeight();
		        $('.popup .xq').css('margin-top',-(height/2));*/
            }
        })
        $('.popup').show();
        $('.popup .xq').show();
        var height = $('.popup .xq').outerHeight();
        $('.popup .xq').css('margin-top',-(height/2));
	});
	//明细
	$(document).on('click','.accounts-table a.mx',function(){
		//ajax加载数据
		$.ajax({
            url: '/path/to/file',
            type: 'default GET (Other values: POST)',
            dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
            data: {param1: 'value1'},
            success:function(data){
            	/*$('.popup .mx .con').html(data);
		        $('.popup').show();
		        $('.popup .mx').show();
		        var height = $('.popup .mx').outerHeight();
		        $('.popup .mx').css('margin-top',-(height/2));*/
            }
        })
        $('.popup').show();
        $('.popup .mx').show();
        var height = $('.popup .mx').outerHeight();
        $('.popup .mx').css('margin-top',-(height/2));
	});

    //挂起
	$(document).on('click','.accounts-table a.gq',function(){
		//ajax加载数据
		$.ajax({
            url: '/path/to/file',
            type: 'default GET (Other values: POST)',
            dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
            data: {param1: 'value1'},
            success:function(data){
            	/*$('.popup .gq .con').html(data);
		        $('.popup').show();
		        $('.popup .gq').show();
		        var height = $('.popup .gq').outerHeight();
		        $('.popup .gq').css('margin-top',-(height/2));*/
            }
        })
        $('.popup').show();
        $('.popup .gq').show();
        var height = $('.popup .gq').outerHeight();
        $('.popup .gq').css('margin-top',-(height/2));
	});
    //挂起
	$(document).on('click','.accounts-table a.td',function(){
		//ajax加载数据
		$.ajax({
            url: '/path/to/file',
            type: 'default GET (Other values: POST)',
            dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
            data: {param1: 'value1'},
            success:function(data){
            	/*$('.popup .td .con').html(data);
		        $('.popup').show();
		        $('.popup .td').show();
		        var height = $('.popup .td').outerHeight();
		        $('.popup .td').css('margin-top',-(height/2));*/
            }
        })
        $('.popup').show();
        $('.popup .td').show();
        var height = $('.popup .td').outerHeight();
        $('.popup .td').css('margin-top',-(height/2));
	});
	//变更
	$(document).on('click','.accounts-table a.bg',function(){
		//ajax加载数据
		$.ajax({
            url: '/path/to/file',
            type: 'default GET (Other values: POST)',
            dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
            data: {param1: 'value1'},
            success:function(data){
            	/*$('.popup .bg .con').html(data);
		        $('.popup').show();
		        $('.popup .bg').show();
		        var height = $('.popup .bg').outerHeight();
		        $('.popup .bg').css('margin-top',-(height/2));*/
            }
        })
        $('.popup').show();
        $('.popup .bg').show();
        var height = $('.popup .bg').outerHeight();
        $('.popup .bg').css('margin-top',-(height/2));
	});
	/*五个可合为一个用ajax加载*/



	//配置
    $(document).on('click','.table2 td a',function(event){
    	event.preventDefault();
        $('.mx .con').hide();
	        //ajax加载数据
			$.ajax({
	            url: '/path/to/file',
	            type: 'default GET (Other values: POST)',
	            dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
	            data: {param1: 'value1'},
	            success:function(data){
	            	// $('.mx .pz').html(data);
	            }
	        })
        $('.mx .pz').show();
    });
    //变更
    $(document).on('click','.table2 td a',function(event){
    	event.preventDefault();
        $('.bg .con').hide();
	        //ajax加载数据
			$.ajax({
	            url: '/path/to/file',
	            type: 'default GET (Other values: POST)',
	            dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
	            data: {param1: 'value1'},
	            success:function(data){
	            	// $('.mx .pz').html(data);
	            }
	        })
        $('.bg .pz').show();
    });
	$(document).on('click','.popup a.close',function(){
        $('.popup').hide();
        $('.popup .box').hide();
        $('.mx .pz').hide();
        $('.mx .con').show();
        $('.bg .pz').hide();
        $('.bg .con').show();
    });
    $(document).on('click','.box p a.cancel',function(){
        $('.popup').hide();
        $('.popup .box').hide();
    });
    $('.popup .box table').each(function() {
    	$(this).find('tbody tr:odd').addClass('odd');
    });


    
}


/*下拉侧导航*/
function vSubnav(){
	$('.sub-menu ul > li').click(function(){
		$(this).children('a').stop().toggleClass('open');
		$(this).find('ol').stop().slideToggle();
	});
}

/*产品锚点*/
function vHash(){
	if($('.hash-ul').length>0){
		var pop = $('.hash-ul li');
		var height = $('.hash-ul').offset().top;
		var left = $('.hash-ul').offset().left;
		var arry = new Array(); 
		//flg
		var clickflag = 0;
		for(var i=0;i<$('.product-content').length;i++){        
 			arry[i]=$('.product-content')[i].offsetTop-108;
		}
		$(window).scroll(function(){
			var top = $(window).scrollTop();
			/*if(top<_a||top>_d){
				pop.removeClass('on')
				
			}else*/ 
			if(clickflag==0)
			{
			for(var j=0;j<arry.length-1;j++)
			{
				if(top>=arry[j]&&top<arry[j+1])
				{
					pop.eq(j).addClass('on').siblings('').removeClass('on');
					break;
				}
			}
			}
			/*if(top>=_a&&top<_b){
				pop.eq(0).addClass('on').siblings('').removeClass('on');
			}else if(top>=_b&&top<_c){
				pop.eq(1).addClass('on').siblings('').removeClass('on');
			}else if(top>=_c&&top<_d){
				pop.eq(2).addClass('on').siblings('').removeClass('on');
			}*/
			
			 if(top > height){
				$('.hash-ul').css({
					"position": 'fixed',
					"top": 68,
					"z-index":9,
					"left": left
				});
			}else{
				$('.hash-ul').css({
					"position": 'relative',
					"z-index":9,
					"top": 0,
					"left": 0
				});
			}
		});
		pop.each(function(e){
			$(this).click(function(){
				$('html,body').animate({scrollTop:arry[e]},500);
				//设置flg及延迟 添加颜色 
				$(this) .addClass('on').siblings('').removeClass('on');
                clickflag=1;
                setTimeout(function() { clickflag=0;}, 500);

			})
		})
	}
		
	// pop.click(function(event) {
	// 	pop.removeClass('on');
	// 	$(this).addClass('on')
	// });

}



