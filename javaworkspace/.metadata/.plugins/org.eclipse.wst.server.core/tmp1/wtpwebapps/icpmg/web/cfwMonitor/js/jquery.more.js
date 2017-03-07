(function( $ ){          
    var target = null;
    var template = null;
    var lock = false;
    var variables = {
        'last'      :    0        
    };
    var settings = {
    	'displayname'     :    '',
    	'typeid'        :    'displayname',
        'amount'      :   '5',       
        'onclicktype' :   'all',
        'address'     :   '${pageContext.request.contextPath}/cfwOverView/querycfwList.do',
        'format'      :   'json',
        'template'    :   '.single_item',
        'trigger'     :   '.get_more',
        'scroll'      :   'false',
        'offset'      :   '100',
        'spinner_code':   ''
    };
    
    var methods = {
        init  :   function(options){
            return this.each(function(){
             // alert(JSON.stringify(options));
                if(options){
                    $.extend(settings, options);
                }
                template = $(this).children(settings.template).wrap('<div/>').parent();
                template.css('display','none');
                $(this).append('<div class="more_loader_spinner">'+settings.spinner_code+'</div>');
                $(this).children(settings.template).remove();
                target = $(this);
                if(settings.scroll == 'false'){                    
                    $(this).find(settings.trigger).bind('click.more',methods.get_data);
                    $(this).more('get_data');
                }                
                else{
                    if($(this).height() <= $(this).attr('scrollHeight')){
                        target.more('get_data',settings.amount*2);
                    }
                    $(this).bind('scroll.more',methods.check_scroll);
                }
            })
        },
        check_scroll : function(){
            if((target.scrollTop()+target.height()+parseInt(settings.offset)) >= target.attr('scrollHeight') && lock == false){
                target.more('get_data');
            }
        },
        debug :   function(){
            var debug_string = '';
            $.each(variables, function(k,v){
                debug_string += k+' : '+v+'\n';
            });
        },
        remove        : function(){            
            target.children(settings.trigger).unbind('.more');
            target.unbind('.more');
            target.children(settings.trigger).remove();
        },
        add_elements  : function(data){
        	if(data){
        		 for(var i=0;i<data.length;i++){
        			 var aa = data[i];
        			 $("#incfwoverview_1").append("<div  class='incfwoverview_list'><div class='incfwoverview_list_one' title="+aa.displayname+">" + aa.displayname+ "</div><div class='incfwoverview_list_two'>" + changecolor(aa.curstat)+
                         "</div><div class='incfwoverview_list_three' style='color:blue;cursor: pointer;' onclick='JumpIncfwPage(this)'>详情</div>" +
                         "<input type=hidden value="+aa.neid+"></input>" +
                         "<input name=\"protype\" type=hidden value="+aa.protype+"></input>" +
                         "<input name=\"neid\" type=hidden value="+aa.neid+"></input>" +
                         "</div>");
        		 }
        	}
        	
           var root = target;    
         //   alert(root.attr('id'))
            var counter = 0;
            if(data){
                $(data).each(function(){
                    counter++;
                    var t = template  ;                 
                    $.each(this, function(key, value){                    
                        if(t.find('.'+key)) t.find('.'+key).html(value);
                    });
                    //t.attr('id', 'more_element_'+ (variables.last++))
                    if(settings.scroll == 'true'){
                    //    root.append(t.html())
                    root.children('.more_loader_spinner').before(t.html());
                    }else{
                          root.children(settings.trigger).before(t.html());
                    }
                    root.children(settings.template+':last').attr('id', 'more_element_'+ ((variables.last++)+1));
                });
            }            
            else  methods.remove();
            target.children('.more_loader_spinner').css('display','none');
            if(counter < settings.amount) methods.remove();     

        },
        get_data      : function(){   
           // alert('getting data')
            var ile;
            lock = true;
            target.children(".more_loader_spinner").css('display','block');
            $(settings.trigger).css('display','none');
            if(typeof(arguments[0]) == 'number') ile=arguments[0];
            else {
                ile = settings.amount;              
            }
            
            var type = $("#incfwoverview_searchtype").val();
            var value = $("#incfwoverview_searchvalue").val();
            var name = $("#incfwoverview_searchname").val();
            var onclicktypes = $("#cfwonclicktype").val();
             if(type=='1'){
             	variables.last=5;
             	$("#incfwoverview_searchtype").val("0");
             }
             var last = variables.last;
             $.post(settings.address, {
            	value:value,
            	 typeid:name,
            	 last : last,
            	 onclicktype:onclicktypes,
                amount : ile                
            }, function(data){            
                $(settings.trigger).css('display','block');
                methods.add_elements(data);
                lock = false;
            }, settings.format);
            
        }
    };
    $.fn.more = function(method){
        if(methods[method]) 
            return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        else if(typeof method == 'object' || !method) 
            return methods.init.apply(this, arguments);
        else $.error('Method ' + method +' does not exist!');

    };
})(jQuery);

function changecolor(value){
	switch(value)
	{

		case 'Stopped':
			return "<span style='color:red;'>故障</span>";
		case 'Running':
			return "<span >正常</span>";
		default:
			return "<span style='color:red;'>其他</span>";
	}
}