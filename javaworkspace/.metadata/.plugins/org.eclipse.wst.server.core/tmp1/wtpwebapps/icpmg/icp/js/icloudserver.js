/**
 * Created by sunjiyun on 2015/11/13.
 */

/*
 * InspurCloudServerBase
 */
function InspurCloudServerBase()
{

}
InspurCloudServerBase.prototype={
    /*
     * ������Tab���ID
     */
    MainTabsId:"maintabs",


    /**
     * ��ȡ��ǰ��㴰��
     */
    topWindow:function()
    {

        if (parent != null) {
            return  parent;
        } else {
            return  window;
        }

    },

    /**
     * ���һ���µ�Tabҳ��
     * @param titile tab����
     * @param url   ����url
     * @param isdiv ʹ��div��ʽ
     * @return �������ɵ�jquery����
     */
    addOneTab:function (title, url,isdiv){
        window.parent.$("#content-body").css("display","block");
        window.parent.$("#mainPageDiv").css("display","none");
        var mainTabs = window.parent.$('#'+this.MainTabsId);
        var href=url;
        if(href.indexOf("?")!=-1)
        {
            href=href+"&_x="+Math.random();


        }
        else
        {
            href=href+"?_x="+Math.random();
        }
        //alert(mainTabs);
        var resultTab=null;
        var parentTab=mainTabs.tabs("getSelected");
        if (mainTabs.tabs('exists', title)){//���tab�Ѿ�����,��ѡ�в�ˢ�¸�tab
            mainTabs.tabs('select', title);
            resultTab=this.refreshTab({tabTitle:title,url:href});
        } else {

            if (!isdiv){
                var content = '<iframe scrolling="auto" frameborder="0" class="js-iframe" src="'+""+'" style="width:100%;height:100%;"></iframe>';
                resultTab=mainTabs.tabs('add',{
                    title:title,
                    closable:true,
                    content:content,
                    parent:parentTab,
                    id:"tabPanelId_"+Math.random()*100000000000,
                    cache:false
                    //iconCls:icon||'icon-default'
                });
                resultTab = mainTabs.tabs("getSelected");
                if(resultTab && resultTab.find('iframe').length > 0){
                    var _refresh_ifram = resultTab.find('iframe')[0];
                    var refresh_url = href?href:_refresh_ifram.src;
                    //_refresh_ifram.src = refresh_url;
                    _refresh_ifram.contentWindow.location.href=refresh_url;
                    var mainTabsHeight=window.parent.$(".warp-content").height();
                    mainTabs.css("height",mainTabsHeight-98);
                    window.parent.$(".js-iframe").height(mainTabsHeight-98-20);
                }




            } else {

                resultTab=mainTabs.tabs('add',{
                    title:title,
                    closable:true,
                    href:href,
                    parent:parentTab,
                    id:"tabPanelId_"+Math.random()*100000000000,
                    cache:false
                    //iconCls:icon||'icon-default'
                });

            }


            //alert(resultTab.html());
        }
        return resultTab;
    },

    /**
     * ˢ��tab
     * @cfg
     *example: {tabTitle:'tabTitle',url:'refreshUrl'}
     *���tabTitleΪ�գ���Ĭ��ˢ�µ�ǰѡ�е�tab
     *���urlΪ�գ���Ĭ����ԭ����url����reload
     */
    refreshTab:function (cfg){
        var mainTabs = window.parent.$('#'+this.MainTabsId);
        var refresh_tab = cfg.tabTitle?mainTabs.tabs('getTab',cfg.tabTitle):mainTabs.tabs('getSelected');
        if(refresh_tab && refresh_tab.find('iframe').length > 0){
            var _refresh_ifram = refresh_tab.find('iframe')[0];
            var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;
            //_refresh_ifram.src = refresh_url;
            _refresh_ifram.contentWindow.location.href=refresh_url;

        }
        return refresh_tab;
    },

    /*
     * ��ȡ�򿪸�Tabҳ�ĸ�Tab
     * @return ���ظ�Tabҳ��jquery����
     */
    getParentTab:function ()
    {
        //alert(getCurrentTab().panel('options'));

        var parentTab=this.getCurrentTab().panel('options').parent;
        //alert(parentTab);
        //alert(parentTab.html());
        return parentTab;
    },

    /*
     * ��ȡ��ǰTabҳ
     * @return ���ص�ǰTabҳjquery����
     */
    getCurrentTab:function()
    {
        var mainTabs = window.parent.$('#'+this.MainTabsId);
        //alert(mainTabs);
        var currentTab=mainTabs.tabs("getSelected");
        return currentTab;
    },

    /*
     * ��ȡ��ǰTab������ֵ
     * @return ���ص�ǰTab����ֵ
     */
    getCurrentTabIndex:function ()
    {
        var mainTabs = window.parent.$('#'+this.MainTabsId);
        var currentTab=mainTabs.tabs("getSelected");
        return currentTab;
    },

    /*
     * �رյ�ǰTabҳ
     */
    closeCurrentTab:function ()
    {
        var mainTabs = window.parent.$('#'+this.MainTabsId);
        var currentTab=mainTabs.tabs("getSelected");
        var index =mainTabs.tabs('getTabIndex',currentTab);
        mainTabs.tabs('close',index);
    },

    /*
     * ������Tabҳ�еĺ���
     * @param func  ִ�еĺ����ַ���
     */
    trigerParentTabFunc:function (func)
    {
        this.getParentTabWindow().eval(func);
    },

    /*
     * ��ȡ��Tabҳ�е�Window����
     * @return ���ظ�Tabҳ��window����
     */
    getParentTabWindow:function ()
    {
        var result=null;
        if($(this.getParentTab()).find("iframe"))
        {
            result=$(this.getParentTab()).find("iframe")[0].contentWindow
        }
        return result;
    },

    /*
     * ��ȡ��ǰTabҳ�е�Window����
     * @return ���ظ�Tabҳ��window����
     */
    getCurrentTabWindow:function ()
    {
        var result=null;
        if($(this.getCurrentTab()).find("iframe"))
        {
            result=$(this.getCurrentTab()).find("iframe")[0].contentWindow;
        }
        return result;
    },


    /*
     * ˢ�¸�Tab����
     * @param tabҳ����
     */
    refreshParentTab:function()
    {

        this.getParentTabWindow().$("form").submit();


    },

    /*
     * ������֤������Ϣ ��䵽����errorField ����Ԫ����
     */
    processFieldError:function(jsonobj)
    {
        var errors=jsonobj.errors;
        //alert(errors.length);
        for(var i=0;i<errors.length;i++)
        {
            var field=errors[i].field;
            var msg=errors[i].msg;
            //alert(field+"--"+msg);
            $("[errorField"+"="+field+"]").html(msg);
        }
    },

    showDialog:function(cfg){
        return window.art.dialog(cfg);
    }


};
/*
 * ����ȫ��uiBase����
 */
uiBase=new InspurCloudServerBase();



/*
 * ajax ����ͳһ����
 */

//��ʼ
$(document).ajaxStart(function(){
    //alert("ajaxStart");
});

$(document).ajaxSend(function(e,xhr,opt){
    //alert("ajaxSend");
});




$(document).ajaxSuccess(function(evt, request, settings){
    //alert("ajaxSuccess");
});

$(document).ajaxStop(function(){
    //alert("ajaxStop");
});

$(document).ajaxComplete(function(event, xhr, settings) {
    /* ���¼� */
    //alert("ajaxComplete");
    var contenttype = xhr.getResponseHeader('Content-Type');
    if ((contenttype && contenttype.indexOf('json') >= 0) && xhr.readyState == "4") {
        //var flag = String(settings.url).indexOf("loadMenu") == -1 ? false : true;
        //alert(xhr.responseText);
        var jsonObj=eval("("+xhr.responseText+")");
        /*
         * �ֶ���֤ͳһ����
         */
        if(jsonObj.type=="fieldError")
        {
            uiBase.processFieldError(jsonObj);
        }
        if(jsonObj.type=="result"&&jsonObj.result=="1")
        {
            //art.dialog({title: '��ʾ',icon: 'succeed',lock: true,content: '����ɹ���2�����Զ��رա���',time:2});
        }
        if(jsonObj.type=="versionException"&&jsonObj.result=="2")
        {
            art.dialog({title: '��ʾ',icon:'warning',lock: true,content: jsonObj.msg});
        }
    }
});

$(document).ajaxError(function (event, XMLHttpRequest, ajaxOptions, thrownError) {
    // thrownError ֻ�е��쳣����ʱ�Żᱻ���� this;
    //alert("ajaxError");
});




/*
 * ȫ���滻
 */
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
    if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")),
            replaceWith);
    } else {
        return this.replace(reallyDo, replaceWith);
    }
};

/*
 * ȫTrim
 */
String.prototype.Trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
};

/*
 * ��Trm
 */
String.prototype.LTrim = function() {
    return this.replace(/(^\s*)/g, "");
};

/*
 * ��Trm
 */
String.prototype.RTrim = function() {
    return this.replace(/(\s*$)/g, "");
};

addLog = function(type){
    //׷�ӵ�����־
    $.post(
        //basePath+"/softphone/logSave/"+type+"?_x="+Math.random(),
        //function(data){
        //    if(data.type=="result"&&data.result=="1")
        //    {
        //        //alert("����ɹ�");
        //    }
        //}

    );

};

addCallLog = function(type,id){
//	ajax({async:false})
    var resultFlag;
    $.ajax({
        async:false,
        url:basePath+"/softphone/logCallSave/"+type+"/"+id+"?_x="+Math.random(),
        method:"post",
        dataType:"json",
        success:function (data){
            if(data.type=="result"&&data.result=="1")
            {
                //console.log("call log success");
                resultFlag =  data.data;
            }else{

                resultFlag =  false;
            }
        }


    });

    //alert(resultFlag);
    return resultFlag;
};

Date.prototype.format =function(format){
    var o = {
        "M+" : this.getMonth()+1, //month
        "d+" : this.getDate(), //day
        "h+" : this.getHours(), //hour
        "m+" : this.getMinutes(), //minute
        "s+" : this.getSeconds(), //second
        "q+" : Math.floor((this.getMonth()+3)/3), //quarter
        "S" : this.getMilliseconds() //millisecond
    };
    if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
        (this.getFullYear()+"").substr(4- RegExp.$1.length));
    for(var k in o)if(new RegExp("("+ k +")").test(format))
        format = format.replace(RegExp.$1,
            RegExp.$1.length==1? o[k] :
                ("00"+ o[k]).substr((""+ o[k]).length));
    return format;
};

var art = uiBase.topWindow().$;

//���ݱ����־ Ϊtrue tabҳ����ֱ�ӹر�
var data_saved_for_tabPanel=false;