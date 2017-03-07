var icp = $.extend({}, icp);	//全局对象
icp.data = icp.data || {};// 用于存放临时的数据或者对象

icp.ns = function () {
    var o = {}, d;
    for (var i = 0; i < arguments.length; i++) {
        d = arguments[i].split(".");
        o = window[d[0]] = window[d[0]] || {};
        for (var k = 0; k < d.slice(1).length; k++) {
            o = o[d[k + 1]] = o[d[k + 1]] || {};
        }
    }
    return o;
};
icp.formatbtn = function (value, row) {
    var str = '';
    str += icp.formatString('<img class="icon-save" title="查看" onclick="showFun(\'{0}\');"/>', row.id);
    return str;
};
/**
 * 将form表单元素的值序列化成对象
 *
 * @example icp.serializeObject($('#formId'))
 *
 * @requires jQuery
 *
 * @returns object
 */
icp.serializeObject = function (form) {
    var o = {};
    $.each(form.serializeArray(), function (index) {
        if (this['value'] != undefined && this['value'].length > 0) {// 如果表单项的值非空，才进行序列化操作
            if (o[this['name']]) {
                o[this['name']] = o[this['name']] + "," + this['value'];
            } else {
                o[this['name']] = this['value'];
            }
        }
    });
    return o;
};

/**
 * 创建一个模式化的dialog
 * 浏览器会在其打开一个 HTML 文档时创建一个对应的 window 对象
 * 包含多个 frame 或 iframe 标签会为每个框架创建额外的 window 对象
 * @requires jQuery,EasyUI
 *
 */
icp.modalDialog = function (options) {
    var opts = $.extend({
        title: '&nbsp;',
        width: 1024,
        height: 560,
        maximizable: true,
        top: 0,
        draggable: false,
        inline: false,
        modal: true,
        onClose: function () {
            $(this).dialog('destroy');
        }
    }, options);
    opts.modal = true;// 强制此dialog为模式化，无视传递过来的modal参数
    if (options.url) {//获取或设置要显示给用户的消息
        opts.content = '<iframe id="" src="' + options.url + '" allowTransparency="true" scrolling="auto" width="100%" height="98%" frameBorder="0" name=""></iframe>';
    }
    return $('<div/>').dialog(opts);
};

/**
 * 生成UUID
 */
icp.random4 = function () {
    return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
};
icp.UUID = function () {
    return (icp.random4() + icp.random4() + "-" + icp.random4() + "-" + icp.random4() + "-" + icp.random4() + "-" + icp.random4() + icp.random4() + icp.random4());
};
/**
 * 重写combotree的扩展
 */
$.extend($.fn.datagrid.defaults.editor, {
    combotree: {
        init: function (container, options) {
            var combotree = jQuery('<input type="text">').appendTo(container);
            combotree.combotree(options || {});
            return combotree;
        },
        destroy: function (target) {
            jQuery(target).combotree('destroy');
        },
        getValue: function (target) {
            var opts = $(target).combotree('options');
            if (opts.multiple) {
                return $(target).combotree('getValues').join(opts.separator);
            } else {
                return $(target).combotree('getValue');
            }
        },
        setValue: function (target, value) {
            var opts = $(target).combotree('options');
            if (opts.multiple) {
                if (value == '') {
                    $(target).combotree('clear');
                } else {
                    $(target).combotree('setValues', value.split(opts.separator));
                }
            } else {
                $(target).combotree('setValue', value);
            }
        },
        resize: function (target, width) {
            jQuery(target).combotree('resize', width);
        }
    }
});

/**
 * 扩展datagrid的方法 暂时不用
 */
/**
 $.extend($.fn.datagrid.methods, {
	addEditor : function(jq, param){
		if(param instanceof Array){
			$.each(param,function(index,item){
				var e = $(jq).datagrid('getColumnOption',item.field);
				e.editor = item.editor;
			});
		}else{
			var e = $(jq).datagrid('getColumnOption',param.field);
			e.editor = param.editor;
		}
	},
	removeEditor : function(jq, param){
		if(param instanceof Array){
			$.each(param,function(index,item){
				var e = $(jq).datagrid('getColumnOption',item);
				e.editor = {};
			});
		}else{
			var e = $(jq).datagrid('getColumnOption',param);
			e.editor = {};
		}
	}
});
 */

/**
 * 增加formatString功能
 *
 * @example icp.formatString('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 *
 * @returns 格式化后的字符串
 */
icp.formatString = function (str) {
    for (var i = 0; i < arguments.length - 1; i++) {
        str = str.replace("{" + i + "}", arguments[i + 1]);
    }
    return str;
};

/**
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 *
 * @returns list
 */
icp.stringToList = function (value) {
    if (value != undefined && value != '') {
        var values = [];
        var t = value.split(',');
        for (var i = 0; i < t.length; i++) {
            values.push('' + t[i]);
            /* 避免他将ID当成数字 */
        }
        return values;
    } else {
        return [];
    }
};

/**
 * JSON对象转换成String
 *
 * @param o
 * @returns
 */
icp.jsonToString = function (o) {
    var r = [];
    if (typeof o == "string")
        return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
    if (typeof o == "object") {
        if (!o.sort) {
            for (var i in o)
                r.push(i + ":" + icp.jsonToString(o[i]));
            if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
                r.push("toString:" + o.toString.toString());
            }
            r = "{" + r.join() + "}";
        } else {
            for (var i = 0; i < o.length; i++)
                r.push(icp.jsonToString(o[i]));
            r = "[" + r.join() + "]";
        }
        return r;
    }
    return o.toString();
};

icp.cookie = function (key, value, options) {
    if (arguments.length > 1 && (value === null || typeof value !== "object")) {
        options = $.extend({}, options);
        if (value === null) {
            options.expires = -1;
        }
        if (typeof options.expires === 'number') {
            var days = options.expires, t = options.expires = new Date();
            t.setDate(t.getDate() + days);
        }
        return (document.cookie = [encodeURIComponent(key), '=', options.raw ? String(value) : encodeURIComponent(String(value)), options.expires ? '; expires=' + options.expires.toUTCString() : '', options.path ? '; path=' + options.path : '', options.domain ? '; domain=' + options.domain : '', options.secure ? '; secure' : ''].join(''));
    }
    options = value || {};
    var result, decode = options.raw ? function (s) {
        return s;
    } : decodeURIComponent;
    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
};
/**
 * 改变jQuery的AJAX默认属性和方法
 *
 * @requires jQuery
 *
 */
$.ajaxSetup({
    type: 'POST',
    error: function (XMLHttpRequest, textStatus, errorThrown) {
        try {
            parent.$.messager.progress('close');
            parent.$.messager.alert('错误', XMLHttpRequest.responseText);
        } catch (e) {
            alert(XMLHttpRequest.responseText);
        }
    }
});

/**
 * 解决class="iconImg"的img标记，没有src的时候，会出现边框问题
 *
 * @requires jQuery
 */
$(function () {
    $('.iconImg').attr('src', icp.pixel_0);
});


String.prototype.replaceAll = function (s1, s2) {
    return this.replace(new RegExp(s1, "gm"), s2);
};

(function ($) {
    $.extend($.fn.datagrid.methods, {

        /**
         * 增加空行 用于没有数据或者数据不足以填满整个列表
         * @param jq datagrid对象
         * @param options 对于一些fomater的字段 做配置 例如 {lbid :''  } 属性名为 column的id 后面统一为''
         */
        addBlankdRows: function (jq,options) {
           // alert("ac");
          //  options['checkboxId'] = 'lbid';
            var _Grid = $(jq);
            var getPage = _Grid.datagrid('options');
            var pageopt = _Grid.datagrid('getPager').data("pagination").options;
            var _pageSize = pageopt.pageSize;
            var _rows = _Grid.datagrid("getRows").length;
            var total = pageopt.total;

            if (_pageSize >= 10) {
                for (var i = 10; i > _rows; i--) {
                    _Grid.datagrid('appendRow', options);
                }
                _Grid.datagrid('getPager').pagination('refresh', {	// 改变选项，并刷新分页栏-条数信息
                    total: total
                });

            } else {
                _Grid.closest('div.datagrid-wrap').find('div.datagrid-pager').show();
            }
            var rows = data.rows;
            if (rows.length) {
                $.each(rows, function (idx, val) {
                   // alert(options.checkboxid);
                    //if (val[options.checkboxid] == '') {
                    //    $('#acl_grid_div input:checkbox').eq(idx + 1).css("display", "none");
                    //}
                });
            }
        }
    });
})(jQuery);