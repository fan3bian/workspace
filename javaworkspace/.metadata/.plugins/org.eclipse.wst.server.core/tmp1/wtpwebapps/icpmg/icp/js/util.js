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
	rollStrip2();
	addRow();
	closeRow();
});
$(window).load(function(){
	SelCpu();
	buySum();
})

$(window).on({
	'load':function(){
		scrollWidth();
	},
	'scroll':function(){
		yelloword();
	}
})
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
		var _a = $('.product-recommend').offset().top-50;
		var _b = $('.product-base').offset().top-50;
		var _c = $('.product-advantage').offset().top-50;
		var _d = $('.product-manual').offset().top-50;
		var arry = [_a,_b,_c,_d]
		$(window).scroll(function(){
			var top = $(window).scrollTop();
			/*if(top<_a||top>_d){
				pop.removeClass('on')
			}else*/ if(top>=_a&&top<_b){
				pop.eq(0).addClass('on').siblings('').removeClass('on');
			}else if(top>=_b&&top<_c){
				pop.eq(1).addClass('on').siblings('').removeClass('on');
			}else if(top>=_c&&top<_d){
				pop.eq(2).addClass('on').siblings('').removeClass('on');
			}/*else if(top>=_d){
				pop.eq(3).addClass('on').siblings('').removeClass('on');
			}*/
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
	var obj_3=$('.product-form-cell').eq(3).find('.item-01').children('li');
	obj.click(function(){
		$(this).addClass('on').siblings('li').removeClass('on');
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
	    //$('.product-form-cell').eq(1).hide();  
	})
	obj_2.click(function(){
		$(this).addClass('on').siblings('li').removeClass('on');
	})
    obj_3.click(function(){
		$(this).addClass('on').siblings('li').removeClass('on');
		$(this).find('img').hide().parent('li').siblings('li').find('img').show();
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
        if(num<=229){
        	vals=Math.round(num/229*50);
        	if(vals<2){
        		strip.css('width',num+'px')
			    chunk.css('right','-12px')	
        	}
        	if(vals>=2){
        		strip.css('width',num+'px')
		    	chunk.css('right','0px')
        	}
        	if(vals==50){
        		strip.css('width',229+'px')
			    chunk.css('right','0px')	
        	}
        }
        if(num<=368 && num>229){
        	vals=Math.round(num/368*100);
        	if(vals==100){
        		strip.css('width',368+'px')
			    chunk.css('right','0px')	
        	}else{
        		strip.css('width',num+'px')
		        chunk.css('right','0px')
        	}
  
        }
        if(num>368 && num<=508){
     		vals=Math.round(num/508*200);
        	if(vals>=199){
        		vals=200;
        		strip.css('width',508+'px')
			    chunk.css('right','0px')	
        	}else{
        		strip.css('width',num+'px')
		        chunk.css('right','0px')
        	}
        }
        $('.product-form-cell .num input').val(vals);
	}

	var clickObj=$('.product-form-cell .uc-slider-1');
	//点击事件
	clickObj.click(function(e){
		var winLeft=$(this).offset().left;
		var mouLeft=e.pageX-winLeft;
		count(mouLeft);
	})
	$('.product-form-cell .num input').keyup(function(){
		var val=$(this).val();
		if(val<=50){
			left=(val/50*width1);
			strip.css('width',left+'px')
			if(val==0){
				chunk.css('right','-12px')
			}else{
			    chunk.css('right','0px')
			}			
		} else if (val>50 && val<=100){
			left = (val-50)/(100-50)*width2+width1;
			strip.css('width',left+'px')
		} else if(val>100 && val<=200){
			left = (val-100)/(200-100)*width3+width2+width1;
			strip.css('width',left+'px')	
		}
	})

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
	   if(index<=8){
	   	 $(this).addClass('hover').siblings('.block').removeClass('hover');
	   	 removeObj.removeClass('hover-2');
	   	 num=(index+1)*left;
	     objLeft.css('left',num);
	   }
	   if(index>8){
	   	$(this).addClass('hover-2').siblings('.block').removeClass('hover-2');
	   	removeObj.removeClass('hover');
	   	 num=((index)-8)*hover2+left*9;
	   	 objLeft.css('left',num);
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
function closeRow(){
	 $('.container-cell .product-details .product-form-cell .close').click(function(){
		$(this).parents('.product-from-row').remove();
	})
}