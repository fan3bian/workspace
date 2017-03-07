$(window).load(function (){
	
	    $('#indexPageNav>ul>li>a').on('click',function(){
	    	 var actionNO = $(this).attr("actionNO") ;
	    	 window.frames["ext_app_iframe"].scroll2Pos(actionNO);
	    	 $(this).css('fontWeight','bold');
	    	 $(this).parent().siblings('li').each(function(){
	    		 $(this).removeClass('on');$(this).find('a').css('fontWeight','normal');
	    	 })
	    	 $(this).parent().addClass('on');
	    });
});   
	    
	    
//    var offsetList = [];
//    var navDom = $('#indexPageNav>ul>li');
//    function _scroll(flag) {
//        var scrollHeight = document.documentElement.scrollTop
//                           || document.body.scrollTop;
//        var viewHeight = document.documentElement.clientHeight;
//        if(flag == 1){
//        	scrollHeight += viewHeight;
//        }else if(flag == 0){
//        	scrollHeight -= viewHeight;
//        }else{
//        	return;
//        }
//        
//        
//        var len = offsetList.length;
//        var idx = 0;
//        if (scrollHeight > offsetList[len - 3].offsetTop) {
//                navDom[len - 2].style.backgroundColor = '#3E98C5';
//                $(navDom[len - 2]).children('a')[0].style.color = '#fff';
//                idx = len-2;
//        }
//        else {
//            for (var i = 0; i < len - 1; i++) {
//                if (Math.abs(scrollHeight - offsetList[i].offsetTop) < 280 && navDom[i]) {
//                    navDom[i].style.backgroundColor = '#3E98C5';
//                    $(navDom[i]).children('a')[0].style.color = '#fff';
//                    idx = i;
//                }
//                else {
//                    navDom[i].style.backgroundColor = 'transparent';
//                    $(navDom[i]).children('a')[0].style.color = '#3E98C5';
//                }
//            }
//        }
//        idx = idx+1;
//        var anchor =  $("a[name=bar"+idx+"]");
//		if (anchor.length<0) return;
//		var $body = $(window.document.documentElement);
//		var ua = navigator.userAgent.toLowerCase();
//		if (ua.indexOf("webkit") > -1) {
//			$body = $(window.document.body);
//		}
//		var pos=anchor.offset();
//		$body.animate({"scrollTop": pos.top},{queue :false,complete: function(){
//			
//			
//		}});
//    }
//   
//    function _resize() {
//        offsetList = [];
//        $('h3').each(function(idx, dom){
//            offsetList[idx] = {
//                name : dom.childNodes[1].name, 
//                offsetTop : dom.childNodes[1].offsetTop
//            };
//        });
//        offsetList.push({
//            name : 'topic',
//            offsetTop : 100000
//        });
//        setTimeout(_scroll, 500);
//    }
//    
//    //$(window).on('scroll', _scroll);
//    
//    var wheel = function(event) {  
//		var delta = 0;  
//		if (!event)
//			event = window.event;  
//		if (event.wheelDelta) {
//			delta = event.wheelDelta / 120;
//		} else if (event.detail) {
//			delta = -event.detail / 3;
//		}
//		if (delta) handle(delta);
//		if (event.preventDefault) event.preventDefault();  
//		event.returnValue = false;  
//	}
//    var handle = function(delta) {
//		var random_num = Math.floor((Math.random() * 100) + 50);
//		if (delta < 0) {
//			/*PicWheelScroll(1);*/
//			_scroll(1);
////			$f=false;
//			 //console.log("鼠标滑轮向下滚动：" + delta + "次！"); // 1  
//			return false;  
//		} else {
////			$f=true;
//			/*PicWheelScroll(0);*/
//			_scroll(0);
//			//console.log("鼠标滑轮向上滚动：" + delta + "次！"); // -1  
//			return false;  
//		}
//	}
//	if (window.addEventListener) window.addEventListener('DOMMouseScroll', wheel, false);
//	document.onmousewheel = wheel;
//	
//    $(window).on('resize', _resize);
//    _resize();
//    });