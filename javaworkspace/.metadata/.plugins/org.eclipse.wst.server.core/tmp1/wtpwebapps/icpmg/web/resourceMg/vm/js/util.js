$(function(){

	allslide();
	
	tableColor();
	vFocus();
	vDatepick();
	// vSelect();
	vBank();
	vOrder();
	vSubnav();

});

$(window).load(function() {
	vHash();
	totop();
	yelloword();
	rollStrip();
	rollStrip_1();
	rollStrip2();
	addRow();
	// 增加磁盘 关闭磁盘操作
	addDisk_1();
	removeDisk();
	closeRow();
	hiddenApi();
});
$(window).load(function(){
	SelCpu();
	buySum();
});

$(window).on({
	'load':function(){
		scrollWidth();
	},
	'scroll':function(){
		yelloword();
	}
});
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
	var nowt = $(window).scrollTop();
	

	if(nowt<_a||nowt>_d){
		//pop.removeClass('on')
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
	var obj=$('.accounts-table');
	if(obj.hasClass('blue')){
		$('.accounts-table tbody tr').each(function() {
		$(this).find('td:first').css('color','#00caff');
	});
	}else{
		$('.accounts-table tbody tr').each(function() {
		$(this).find('td:first').css('color','#fe9500');
		});
	}
	$('.accounts-table tbody tr:odd').addClass('odd');  
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
		var pop = $('.cf li');
		var height = $('.hash-ul').offset().top;
		console.log(height)
		var left = $('.hash-ul').offset().left;
		var _a = $('.product-recommend').offset().top-50;
		var _b = $('.product-base').offset().top-50;
		var _c = $('.product-advantage').offset().top-50;
		var _d = $('.product-manual').offset().top-500;


		var arry = [_a,_b,_c,_d]
		$(window).scroll(function(){
			var top = $(window).scrollTop();
		    if(top>=_d){
		    	pop.eq(3).addClass('on').siblings('').removeClass('on');;
		    }
			else if(top>=_a&&top<_b){
				pop.eq(0).addClass('on').siblings('').removeClass('on');
			}else if(top>=_b&&top<_c){
				pop.eq(1).addClass('on').siblings('').removeClass('on');
			}else if(top>=_c&&top<_d){
				pop.eq(2).addClass('on').siblings('').removeClass('on');
			}
			if(top > height){
				$('.hash-ul').css({
					position: 'fixed',
					display:'block',
					top: '0',
					left: left
				});
			}else{
				$('.hash-ul').css({
					position: 'relative',
					top: '0',
					left: '0'
				});
			}
		});
		pop.each(function(e){
			$(this).click(function(){
				$('html,body').animate({scrollTop:arry[e]},500);
			})
		})
	}
		
	// pop.click(function(event) {
	// 	pop.removeClass('on');
	// 	$(this).addClass('on')
	// });

}
//加载选择CPU
function SelCpu(){
	var obj=$('.product-form-cell').eq(0).find('.item-01').children('li');
	var obj_2=$('.product-form-cell').eq(1).find('.item-01').children('li');
	var obj_3=$('.product-form-cell').eq(2).find('.item-01').children('li');
	//var obj_4=$('.product-form-cell').eq(3).find('.item-01').children('li');
	var obj_5=$('.product-form-cell').eq(10).find('.item-01').children('li');
	var obj_6=$('.product-form-cell').eq(11).find('.item-01').children('li');
	var obj_7=$('.product-form-cell').eq(12).find('.item-01').children('li');
	var obj_8=$('.product-form-cell').eq(13).find('.item-01').children('li');
	obj.click(function(){
		//$(this).addClass('on').siblings('li').removeClass('on');
	})
	obj_2.click(function(){
		$(this).addClass('on').siblings('li').removeClass('on');
	})
    obj_3.click(function(){
		$(this).addClass('on').siblings('li').removeClass('on');
	})
	//obj_4.click(function(){
	//	$(this).addClass('on').siblings('li').removeClass('on');
	//})
	 //在此处添加了if-else语句
	obj_5.click(function(){
		//alert();
			if($(this).hasClass('on'))
		{
			$(this).removeClass('on');
		}else
		{
			$(this).addClass('on');
		}
	})
	obj_6.click(function(){
		//alert();
			if($(this).hasClass('on'))
		{
			$(this).removeClass('on');
		}else
		{
			$(this).addClass('on');
		}
	})
	obj_7.click(function(){
		//alert();
			if($(this).hasClass('on'))
		{
			$(this).removeClass('on');
		}else
		{
			$(this).addClass('on');
		}
	})
	obj_8.click(function(){
		//alert();
			if($(this).hasClass('on'))
		{
			
			$(this).removeClass('on');
		}else
		{   
			$(this).addClass('on');
		}
	})
}
//购买数据
function buySum(){
	var addObj=$('.form-add');
	var subOjb=$('.form-sub');

	addObj.click(function(){
	  var  val=	$(this).parent('.product-form-add').find('input').val();
	  val++;
	  $(this).parent('.product-form-add').find('input').val(val)
	})
	subOjb.click(function(){
		 var  val=	$(this).parent('.product-form-add').find('input').val();
		 if(val!=0){
		 	 val--;
	        $(this).parent('.product-form-add').find('input').val(val);
		 }
	})
}

//滚动条代码
function rollStrip(){
	var vals=null;//最后的百分比
	var strip=$('.product-form-cell .uc-slider .strip');//动画动像
	var chunk=$('.product-form-cell .uc-slider .strip .chunk');
	var leftValue=12;
	var width1 = 229;
    var width2 = 139;
	var width3 = 139;
	//计算百分比
	function count(num){
		var conWidth=$('.product-form-cell .uc-slider .range').width();
		var leftObj=$('.uc-slider .bg-01 .block');
		var bai=parseInt(num/588*100);
		if (num<=0)
		   num = 0;
        if(num<=229){
        	vals=Math.round(num/229*50);
        	if(vals<2){
        		strip.css('width',num+'px')
			    chunk.css('right','-12px')	
        	}
        	if(vals>=2){
        		strip.css('width',num+'px')
		    	chunk.css('right','-17px')
        	}
        	if(vals==50){
        		strip.css('width',229+'px')
			    chunk.css('right','-17px')	
        	}
        }
        if(num<=368 && num>229){
        	vals=Math.round(num/368*100);
        	if(vals==100){
        		strip.css('width',368+'px')
			    chunk.css('right','-17px')	
        	}else{
        		strip.css('width',num+'px')
		        chunk.css('right','-17px')
        	}
  
        }
        if(num>368 && num<=508){
     		vals=Math.round(num/508*200);
        	if(vals>=199){
        		vals=200;
        		strip.css('width',508+'px')
			    chunk.css('right','-17px')	
        	}else{
        		strip.css('width',num+'px')
		        chunk.css('right','-17px')
        	}
        }
        $('.product-form-cell .num input').val(vals);
         $('#interbw').val(vals);
	}

	var clickObj=$('.product-form-cell .uc-slider-1');
	//点击事件
	clickObj.click(function(e){
		var winLeft=$(this).offset().left;
		var mouLeft=e.pageX-winLeft;
		count(mouLeft);
		$('.product-form-cell .uc-slider .strip .val').fadeIn(500);
		$('.product-form-cell .uc-slider .strip .val').text($('.product-form-cell .num input').val()+"mbps");
	})
	$('.product-form-cell .num input').keyup(function(){
		var val=$(this).val();
		$('.product-form-cell .uc-slider .strip .val').fadeIn(500);
		$('.product-form-cell .uc-slider .strip .val').text($('.product-form-cell .num input').val()+"mbps");
		if(val<=50){
			left=(val/50*width1);
			strip.css('width',left+'px')
			if(val==0){
				chunk.css('right','-12px')
			}else{
			    chunk.css('right','-17px')
			}			
		} else if (val>50 && val<=100){
			left = (val-50)/(100-50)*width2+width1;
			strip.css('width',left+'px')
		} else if(val>100 && val<=200){
			left = (val-100)/(200-100)*width3+width2+width1;
			strip.css('width',left+'px')	
		}
		$('#interbw').val(val);
	})

}

//第二条滚动条代码
function rollStrip_1(){

	var vals=null;//最后的百分比
	/*var leftValue=12;*/
	$('#hard1').val(0);
	$('#hard2').val(0);
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
	memObj.click(function(e){
		var winLeft=$(this).offset().left;
		var mouLeft=e.pageX-winLeft;
		count(mouLeft,5);
	});
	
		$('#hard1').keyup(function(){
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
	$('#hard3').keyup(function(){
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
			strip3.css('width',left+'px');
			if(val==0){
				chunk3.css('right','-12px');
			}else{
			    chunk3.css('right','-17px');
			}			
		} else if(val>600 && val<=2000){
			left = (val-600)/(2000-600)*width2+width1;
			strip3.css('width',left+'px');
		}
	});
	$('#hard4').keyup(function(){
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
			strip4.css('width',left+'px');
			if(val==0){
				chunk4.css('right','-12px');
			}else{
			    chunk4.css('right','-17px');
			}			
		} else if(val>600 && val<=2000){
			left = (val-600)/(2000-600)*width2+width1;
			strip4.css('width',left+'px');
		}
	});
	
	$('#dbmem').keyup(function(){
		var val=$(this).val();
		//alert(val);
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
		if(val<=1000){
			left=(val/1000*width1);
			console.log(left);
			strip5.css('width',left+'px');
			if(val==0){
				chunk5.css('right','-12px');
			}else{
			    chunk5.css('right','-17px');
			}			
		} else if(val>1000 && val<=2000){
			left = (val-1000)/(2000-1000)*width2+width1;
			strip5.css('width',left+'px');
		}
	});
}


function rollStrip2(){
	//滚动条代码2
	var objLeft=$('.product-form-cell .range .chunk-2');
	var index=null;
	var num=0;
	var left=$('.product-form-cell .range .mm').innerWidth();
	var hover2=70;
	var removeObj=$('.uc-slider .range .block')

	$('#uc-duration .range .block').click(function(){
	 index=$(this).index();
	 var text=$(this).find('t').text();
	 $('.product-form-cell .range .chunk-2 .val').fadeIn('500');
	
		   if(index<=8){
		$('.product-form-cell .range .chunk-2 .val').eq(index).text(text+"个月");
		   	
		   	 for(var i=0;i<index;i++){
		   		$('#uc-duration .range .block').eq(i).addClass('hover-3');
		   		$('#uc-duration .range .block ').eq(i).find('i').addClass('on');
		     }
		   var len=9;
		   for(var i=0;i<8-index;i++){
		   	 	len--;
		   	 	$('#uc-duration .range .block ').eq(len).removeClass('hover');
		   	 	$('#uc-duration .range .block ').eq(len).removeClass('hover-3');
		   }
		   
	     }
	   if(index<=8){
	   	 $(this).removeClass('hover-3');
	   	 $(this).addClass('hover').siblings('.block').removeClass('hover');
	   	 $(this).find('.chunk-2').show().parent('.block').siblings().find('.chunk-2').hide();
	   	 $(this).find('i').addClass('on').parent('.block').siblings().find('i').removeClass('on');
	   	 removeObj.removeClass('hover-2');
	   	 num=(index+1)*left;
	     //objLeft.css('left',num);
	   	 $('#time').val(index+1);
	   }
	   if(index>8){
		   
	   	 $('.product-form-cell .range .chunk-2 .val').eq(index).text(text);
	   	$(this).addClass('hover-2');
	   	$(this).find('.chunk-2').show().parent('.block').siblings().find('.chunk-2').hide();
	   	$(this).find('i').addClass('on').parent('.block').siblings().find('i').removeClass('on');

	   	if($(this).index()==10){
	   		$('.product-form-cell .range .yy').eq(0).addClass('hover-2');
	   	
	   	}
	    if($(this).index()==11){
	   		$('.product-form-cell .range .yy').eq(0).addClass('hover-2');
	   		$('.product-form-cell .range .yy').eq(1).addClass('hover-2');
	   	}

	   	 num=((index)-8)*hover2+left*9;
	   	 //objLeft.css('left',num);
	   	 var lens=12;
	   	 for(var i=0;i<12-(index+1);i++){
	   	 	 lens--;
	   	 	$('#uc-duration .range .block ').eq(lens).removeClass('hover-2'); 
	   	 }
	   	 for(var i=0;i<9;i++){
	   	 	$('#uc-duration .range .block').eq(i).addClass('hover-3');
		   	$('#uc-duration .range .block ').eq(i).find('i').addClass('on');
	   	 }
	   	 $('#time').val((index-8)*12);
	   }
	   
	})
	
}

function addRow(){
	var addObj=$('#showDiv').clone();
	$('.container-cell .product-details .product-form-cell .add').click(function(){
		$('#addRow').after(addObj.html());
		$('#addRow').show();
	})
}

diskNum = 1;			//初始化磁盘块全局变量
diskflag2 = true;		
diskflag3 = false;
diskflag4 = false;
flag = true;
function addDisk_1(){
	$('.container-cell .product-details .product-from-row .product-form-cell .addDisk').click(function(e){
		/*
				$('.container-cell .product-details .product-from-row .product-form-cell .addDisk').removeAttr('click');
				$(this).attr("class","unclick");
				console.log($('.container-cell .product-details .product-from-row .product-form-cell[id^="disk"]').length);
		 */
		
		if(diskNum > 0){
			if(diskflag2 && flag){
				$('#disk2').show();
				diskflag2 = false;
				flag = false;
			}
			if(diskflag3 && flag){
				$('#disk3').show();
				diskflag3 = false;
				flag = false;
			}
			if(diskflag4 && flag){
				$('#disk4').show();
				diskflag4 = false;
				flag = false;
			}
			diskNum = diskNum-1;
			flag = true;
			if (diskNum == 0 ){
				$(this).hide();
				$(this).parent().next().hide();
			}
		}
	});
}
function removeDisk(){
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
	});
	$('.container-cell .product-details .product-form-cell .close1_3').click(function(){
		$('#disk3').hide();
		diskflag3 = true;
		diskNum = diskNum + 1;
		
		$('#hard3').val(0);
		var strip3=$('#disk3 .uc-slider1 .strip');//动画动像
		var chunk3=$('#disk3 .uc-slider1 .strip .chunk');
		strip3.css('width','0px');
        chunk3.css('right','-17px');
	});
	$('.container-cell .product-details .product-form-cell .close1_4').click(function(){
		$('#disk4').hide();
		diskflag4 = true;
		diskNum = diskNum + 1;
		$('#hard4').val(0);
		var strip4=$('#disk4 .uc-slider1 .strip');//动画动像
		var chunk4=$('#disk4 .uc-slider1 .strip .chunk');
		strip4.css('width','0px');
        chunk4.css('right','-17px');
	});
}

function closeRow(){
	 $('.container-cell .product-details .product-form-cell .close').click(function(){
		$(this).parents('.product-from-row').remove();
	})
}

function hiddenApi(){
	$('.api-hidden').click(function(){
		$(this).parents('.container-api-con').fadeOut('1000');
	})
}