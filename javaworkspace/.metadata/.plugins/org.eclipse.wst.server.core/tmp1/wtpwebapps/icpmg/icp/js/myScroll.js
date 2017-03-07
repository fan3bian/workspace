/* 
    name:myScroll
    new alter 2013.12.18
    writer:zhao 
*/

(function($){
    $.fn.myScroll = function(options){
    $.fn.myScroll.parame = {
        effect:'y',                 // 横轴x 默认竖轴y
        wheel: 15 ,                 //滚轮速度
        pageCell: false ,           //上下标示 是否显示
        mainCell:'.cont' ,          //滚动区域
        rollCell:'.roll',           //滚动条类名
        topCell:'.rollTop',         //上标类名
        bottomCell:'.rollBottom',   //下标类名
        scroll:0,                   //距离顶部|左边 
        bar:false,                  //当滚动区域小于视图时 滚动条是否显示
        endFun:function(){}         // 触底回调函数
    };

    return this.each(function(index){
        var obj = $.extend({},$.fn.myScroll.parame,options);
        var _this  = $(this);
        var roll = $(obj.rollCell,_this);
        var cont = $(obj.mainCell,_this);
        var _myTop = $(obj.topCell,_this);
        var _myBottom = $(obj.bottomCell,_this);
        var bar = roll.children();
        var scroll = obj.scroll;
        var effect = obj.effect;
        var i = obj.wheel;
        var dragger = false;
        var xWidth,yHeight,pX,pY,dis;
        var w = 0;
        //20150205fuyd 添加参数true
        var wrapWidth = cont.outerWidth(true) - _this.width();
        var wrapHeight = cont.outerHeight(true) - _this.height();
        var maxWidth = roll.width() - bar.width();
        var maxHeight = roll.height() - bar.height();
        var maxWheel = effect == 'x'?parseInt(wrapWidth):parseInt(wrapHeight);
        var rollToggle = effect == 'x'?wrapWidth:wrapHeight;

        _this.css({overflow:'hidden',position:'relative'});
        cont.css({position:'relative',top:'0px',left:'0px'});
        bar.css({position:'absolute',top:'0px',left:'0px'});

        // 当滚动区域小于视图时 滚动条是否显示
        if(obj.bar == true){
            if(rollToggle < 0){roll.hide();}else{roll.show();}
        }
        
        bar.bind('mousedown',function(e){
            e.preventDefault();
            pX = _this.offset().left+267;//加位移距离
            pY = _this.offset().top;
            xWidth = e.pageX - $(this).offset().left;
            yHeight = e.pageY - $(this).offset().top;
            dragger = true;
        });

        $(document).bind('mousemove',function(e){
            if(!dragger){return false};
            var to = effect == 'x'?e.pageX-xWidth-pX:e.pageY - yHeight-pY;
            switch(effect){
                case 'x':
                    dis = to< 0?0:(to>maxWidth?maxWidth:to);
                    cont.css({left:'-'+parseInt((wrapWidth/maxWidth)*dis) +'px'});
                    bar.css({left:dis});
                    if(dis == maxWidth){obj.endFun()};
                break;
                default:
                    dis = to< 0?0:(to>maxHeight?maxHeight:to);
                    cont.css({top:'-'+parseInt((wrapHeight/maxHeight)*dis) +'px'});
                    bar.css({top:dis});
                    if(dis == maxHeight){obj.endFun()};
            }
            return false;
        });

        $(document).bind('mouseup',function(){dragger = false});

        // 当滚动区域小于视图时 
        switch(effect){
            case 'x':
                if(wrapWidth<=0){
                    bar.unbind('mousedown');
                    _this.unbind('mousewheel');
                }else{
                    var defaultX = scroll<wrapWidth?scroll:wrapWidth;
                    cont.animate({left:'-'+defaultX +'px'});
                    bar.animate({left:parseInt((defaultX/wrapWidth)*maxWidth) +'px'});
                }  
            break;
            default:
                if(wrapHeight<=0){
                    bar.unbind('mousedown');
                    _this.unbind('mousewheel');
                } else{
                    var defaultY = scroll<wrapHeight?scroll:wrapHeight;
                    cont.animate({top:'-'+defaultY +'px'});
                      bar.animate({top:parseInt((defaultY/wrapHeight)*maxHeight) +'px'});
                }  
        }

        // 滚轮函数
        var scrollFun = function(evt){
            var delta = getWheel(evt);
            var contWidth = parseInt(cont.css('left'));
            var contHeight = parseInt(cont.css('top'));
            var contChange = effect == 'x'?contWidth:contHeight;
            var contStr = contChange == 0?'0':contChange.toString().slice(1);
            var w = parseInt(contStr);
            preventDefault(evt);
            if(delta== undefined){
                var delta = $(evt.target);
                if(delta.hasClass(obj.topCell.slice(1))){delta = 1} else if(delta.hasClass(obj.bottomCell.slice(1))){delta = -1}
            }
            if(delta<0 &&  maxWheel > w){ w = w+i > maxWheel?maxWheel:w+i};
            if(delta>0 && 0 < w){ w = 0 > w-i?0:w-i};

            switch(effect){
                case 'x':
                    bar.css({left:(w/maxWheel)*parseInt(maxWidth) +'px'});
                    cont.css({left:'-'+ w +'px'});
                break;
                default:
                    bar.css({top:(w/maxWheel)*parseInt(maxHeight) +'px'});
                    cont.css({top:'-'+ w +'px'});
            }
            if(w == maxWheel){obj.endFun()}; 
            return false;
        }
        // 滚轮事件
        addEvent(_this[index],'mousewheel',scrollFun);
        _myTop.bind('click',scrollFun);
        _myBottom.bind('click',scrollFun);
        
        // 滚轮取值
        function getWheel(evt){
            var e = evt || window.evt;
            if(e.wheelDelta){
                return (e.wheelDelta)/120
            }else if(e.detail){
                return -(evt.detail)/3
            }
        }

        // 添加事件
        function addEvent(obj,type,fn){
            if(type == 'mousewheel' && document.mozHidden !== undefined){type='DOMMouseScroll'}
            if(obj.addEventListener){
                obj.addEventListener(type,fn,false)
            }else if(obj.attachEvent){
                obj.attachEvent('on'+type,fn)
            }
        }

        // 停止默认
        function preventDefault(e) { 
            var e = e || window.event;
            if(e.preventDefault) { 
            　　e.preventDefault(); //阻止默认浏览器动作(W3C) 
            } else { 
            　　window.event.returnValue = false; //IE中阻止函数器默认动作的方式
            } 
            return false; 
        } 

        // 上下箭头是否显示
        if(obj.pageCell == false){
            _myTop.hide();
            _myBottom.hide();
        }

        // each end
    })}
})(jQuery);