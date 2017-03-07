
(function($){

	$.fn.select = function(options){

		// 默认参数
	    var defaults = {
	        titName:'temp-select', //内容类名
	        mainName:'tempDown',   //下拉框类名
	        active:'on',           //高亮类名
	        effect:'fade',         //展示效果 fade || slide || fold
	        paramIndex:0,          // 默认显示 
	        speed:300,             // 速度
	        left:0,                // 下拉偏移 
	        top:30,                // 下拉偏移 
	        addDot:false,          //是否添加点
	        endFun:null,           //回调函数
	        clickStop:true         // 链接跳转  _blank  方法：data-target='_blank'
	    };
	    return this.each(function(index){
	        
	        var obj = $.extend({},defaults,options);
	        var _this = $(this);
	        var offLeft = obj.left;
	        var offTop = obj.top;
	        var endFun = obj.endFun;
	        var effect = obj.effect;
	        var speed = obj.speed;
	        var pIn = parseInt(obj.paramIndex);
	        var mainName = obj.mainName;
	        var active = obj.active;
	        var clickStop = obj.clickStop;
	        var width = _this.width();
	        
	        //20150720guoqiaozhi添加设置宽度的入口start
	        if(obj.width){
	        	width = obj.width;
	        }
	        //20150720guoqiaozhi添加设置宽度的入口end
	        
	        var body = $('body');

	        // 是否已经创建
	        if( _this.next().hasClass('spreadCell') ){ return true };

	        // 下拉元素是否创建
	        if(!body.children().hasClass(mainName)){ body.append('<div class="spreadDown '+mainName+'"></div>') };

	        // 添加节点元素
	        //20150205fuyd去掉px后的";"
	        _this.hide().after('<div class="spreadCell '+obj.titName+'" style="width:'+width+'px"><div class="up"></div></div>');

	        var main = body.children('.'+obj.mainName);
	        var wrap = _this.next();
	        var opt = _this.children('option');
	        var toggleTarget = _this.attr('data-target') == undefined?'_self':_this.attr('data-target');

	        // 初始化
	        _this.val(opt.parent().find(':selected').val());
	        wrap.children('.up').text(opt.parent().find(':selected').text());
	        main.hide();
	        

	        if(obj.addDot == true){ wrap.append('<div class="dot"></div>') };

	        // 隐藏方式
	        var effHide = function(){
	            switch(effect){
	                case 'fade':main.hide(); break;
	                case 'fold':main.fadeOut(speed); break;
	                case 'slide':main.slideUp(speed); break;       
	            };
	        }

	        // 触发函数
	        var doPlay = function(e){

	            e.preventDefault();
	            e.stopPropagation();

	            var then = $(this);
	            var thenUp = then.children('.up');
	            var str = '';
	            var left = then.offset().left;
	            var top = then.offset().top;

	            opt = _this.children('option');

	            if(then.hasClass(active)){

	                effHide();
	                then.removeClass(active);

	            }else{

	                $('.spreadCell').removeClass(active);
	                $('.spreadDown').hide();

	                then.addClass(active);

	                //获取下拉内容
	                for(var i = 0,len = opt.length;i<len;i++){
	                    str +='<a data-path="'+opt.eq(i).val()+'">'+opt.eq(i).text()+'</a>';
	                };
	                
	                //20150203guoqiaozhi限定下拉列表高度
	                var h = 28*opt.length;
	                var overflow = '';
	                if(h > 350){
	                	overflow = 'auto';
	                	h =350;
	                }
	                //20150203guoqiaozhi限定下拉列表高度
	                
	                // 重置下拉内容
	                main.hide().empty().html(str).css({
	                    left:left+offLeft+'px',
	                    top:top+offTop+'px',
	                    width:width+'px',
	                    height:h+'px',//20150203guoqiaozhi限定下拉列表高度
	                    overflow:overflow,
	                    position:'absolute'
	                });

	                // 显示方式
	                switch(effect){
	                    case 'fade':main.show(); break;
	                    case 'fold':main.fadeIn(speed); break;
	                    case 'slide':main.slideDown(speed); break;       
	                };

	                // 下拉绑定事件
	                main.off('click','a').on('click','a',function(e){

	                    var that = $(this).parent();
	                    var text = $(this).text();
	                    var param = $(this).index();
	                    var dataPath = $(this).attr('data-path');

	                    if(!clickStop){
	                        $(this).attr({'href':dataPath,target:toggleTarget});
	                    }else{
	                        e.preventDefault();
	                    }
	                    thenUp.text(text);
	                    // _this.val(dataPath);
	                    _this.children().eq(param).attr('selected',true).siblings().attr('selected',false);
	                    that.hide();

	                    if ( $.isFunction( endFun ) ){ endFun(param,text,dataPath,_this) };

	                });

	                // 改变窗口 重置偏移
	                $(window).resize(function(){
	                    var winLeft = then.offset().left;
	                    var winTop = then.offset().top;
	                    main.css({left:winLeft+offLeft+'px',top:winTop+offTop+'px'});
	                });

	                $(document).click(function(){

	                    effHide();
	                    wrap.removeClass(active);
	                    
	                });

	            } 

	        };

	        wrap.click(doPlay);

	    })
	}

})(jQuery);



$(function(){
	vLogin();
	vEffect();
});

function vLogin(){
	var input = $('.login-cell .line input');

	input.each(function(){
		
		var span = $(this).siblings('p').children("span");

		$(this).on({
			'focus':function(){
			/*	debugger;*/
				span.hide();
			},
			'blur':function(){
				if( /^\s*$/.test( $(this).val() ) ){
					span.show();
				}else{
					span.hide();
				}
			}
		}).trigger('blur');
	});
}

function vEffect(){
	//20150205fuyd
	/*$('.register select').each(function(){
		if( !$(this).parents().hasClass('register-link') ){
			$(this).select({
				endFun:function(param,text,dataPath,_this){*/
					/*console.log(param)
					console.log(text)
					console.log(dataPath)
					console.log(_this)*/
			/*	}
			});
		}
	});*/
	$('input.text').on({
		'focus':function(){
			$(this).addClass('focusActive');
		},
		'blur':function(){
			$(this).removeClass("focusActive");
		}
	});
	$('textarea').on({
		'focus':function(){
			$(this).addClass('focusActive');
		},
		'blur':function(){
			$(this).removeClass("focusActive");
		}
	});

	/*20150203guoqiaozhi*/
	/*$('.str-select select').select({
		endFun:function(param,text,dataPath,_this){
			console.log(param)
			console.log(text)
			console.log(dataPath)
			console.log(_this)
		}
	});*/
	$('.str-select-system select').select({
		endFun:function(param,text,dataPath,_this){
			/*console.log(param)
			console.log(text)
			console.log(dataPath)
			console.log(_this)*/
		}
	});

	$('.std-select select').select({
		endFun:function(param,text,dataPath,_this){
			/*console.log(param)
			console.log(text)
			console.log(dataPath)
			console.log(_this)*/
		}
	});

	$('.rep-select select').select({
		endFun:function(param,text,dataPath,_this){
			/*console.log(param)
			console.log(text)
			console.log(dataPath)
			console.log(_this)*/
		}
	});
	$('.wram-select select').select({
		endFun:function(param,text,dataPath,_this){
			/*console.log(param)
			console.log(text)
			console.log(dataPath)
			console.log(_this)*/
		}
	});
	$('.register .file-cell').each(function(){
		var mark = $(this).siblings('.file-mark');
		$(this).find('input[type="file"]').change(function(){
			mark.text( $(this).val() )
		})
	})

}

