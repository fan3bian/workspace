//扩展easyui表单的验证  
$.extend($.fn.validatebox.defaults.rules,{
	// 验证汉字
	CHS : {
		validator : function(value) {
			return /^[\u0391-\uFFE5]+$/.test(value);
		},
		message : '请输入汉字！'
	},
	// 匹配中文、数字、字母、下划线
	nameInput :{
		validator : function(value) {
			var reg = /^[\w\u4e00-\u9fa5]+$/gi;
			return reg.test(value);
		},
		message : '仅支持中英文，数字，下划线！'
	},
	// 两次输入字符
	equalTo : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '两次输入不一致!'
	},
	//空格验证
	isBlank: {
          validator: function (value, param) { return $.trim(value) != '' },
          message: '不能为空，全空格也不行'
     },
   //空格验证
 	isBlankorchoose: {
           validator: function (value, param) { return $.trim(value) != ''&&value!='请选择' },
           message: '不能为空，全空格也不行'
      },
	// 移动手机号码验证
	Mobile : {
		// value值为文本框中的值
		validator : function(value) {
			var reg = /^1[3|4|5|8|7|9]\d{9}$/;
			return reg.test(value);
		},
		message : '请输入正确的手机号码！'
	},
	tel : {
		// 电话号码验证
		validator : function(value, param) {
			return /^(\d{3}-|\d{4}-)?(\d{8}|\d{7})?(-\d{1,6})?$/
					.test(value);
		},
		message : '电话号码不正确'
	},
	mobileAndTel : {
		validator : function(value, param) {
			return /(^([0\+]\d{2,3})\d{3,4}\-\d{3,8}$)|(^([0\+]\d{2,3})\d{3,4}\d{3,8}$)|(^([0\+]\d{2,3}){0,1}13\d{9}$)|(^\d{3,4}\d{3,8}$)|(^\d{3,4}\-\d{3,8}$)/
					.test(value);
		},
		message : '请正确输入电话号码'
	},
	// 国内邮编验证
	zipCode : {
		validator : function(value) {
			var reg = /^[1-9]\d{5}$/;
			return reg.test(value);
		},
		message : '邮编必须是非0开始的6位数字！'
	},
	// 数字
	number : {
		validator : function(value) {
			var reg = /^[0-9]*$/;
			return reg.test(value);
		},
		message : '请输入数字！'
	},
	// 登录名
	loginName : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5\w]+$/.test(value);
		},
		message : '登录名称只允许汉字、英文字母、数字及下划线。'
	},
	english : {
		// 验证英语
		validator : function(value) {
			return /^[A-Za-z]+$/i.test(value);
		},
		message : '请输入英文'
	},
	ip : {
		// 验证IP地址
		validator : function(value) {
			/*return /\d+\.\d+\.\d+\.\d+/.test(value);*/
			var reg = /^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/;  
            return reg.test(value); 
		},
		message : 'IP地址格式不正确!'
	},
	port : {
		// 验证端口
		validator : function(value) {
			/*return /\d+\.\d+\.\d+\.\d+/.test(value);*/
			var reg = /^(\d)+$/g;  
            return reg.test(value)&&parseInt(value)<=65535&&parseInt(value)>=0; 
		},
		message : '端口格式不正确!'
	},
	QQ : {
		validator : function(value, param) {
			return /^[1-9]\d{5,10}$/.test(value);
		},
		message : 'QQ号码不正确'
	},
	money : {
		// 金额验证
		validator : function(value, param) {
			return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(value);
		},
		message : '请输入正确的金额'
	},
	mone : {
		validator : function(value, param) {
			return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(value);
		},
		message : '请输入整数或小数'
	},
	integer : {
		validator : function(value, param) {
			return /^[+]?[1-9]\d*$/.test(value);
		},
		message : '请输入最小为1的整数'
	},
	integ : {
		validator : function(value, param) {
			return /^[+]?[0-9]\d*$/.test(value);
		},
		message : '请输入整数'
	},
	range : {
		validator : function(value, param) {
			if (/^[1-9]\d*$/.test(value)) {
				return value >= param[0] && value <= param[1];
			} else {
				return false;
			}
		},
		message : '输入的数字在{0}到{1}之间'
	},
	minLength : {
		validator : function(value, param) {
			return value.length >= param[0];
		},
		message : '至少输入{0}个字'
	},
	maxLength : {
		validator : function(value, param) {
			return value.length <= param[0];
		},
		message : '最多{0}个字'
	},
	pwdrange : {
		validator : function(value, param) {
			return value.length >= param[0] && value.length <= param[1];
		},
		message : '至少输入{0}个字符,最多{1}个字符'
	},
	passCheck : {
		// 大写、小写字母、数字和标点符号至少包含2种验证密码
		validator : function(value, param) {
			/*return /\d+\.\d+\.\d+\.\d+/.test(value);*/
		var a = value.match(/([a-z])+/);
		var b = value.match(/([A-Z])+/);
		var c = value.match(/([0-9])+/);
		var d = value.match(/([^a-zA-Z0-9])+/);
		var match = (a && b) || (a && c) || (a && d) || (b && c) || (b && d)
				|| (d && c);
            return match; 
		},
		message : '大写、小写字母、数字和标点符号至少包含2种!'
	},
	 selectValueRequired: {  
		//下拉框必选验证
        validator: function(value,param){            
             if (value == "" || value.indexOf('请选择') >= 0) {  
                return false; 
             }else { 
                return true; 
             }   
        },  
        message: '该下拉框为必选项'  
    },
	// select即选择框的验证
	selectValid : {
		validator : function(value, param) {
			if (value == param[0]) {
				return false;
			} else {
				return true;
			}
		},
		message : '请选择'
	},
	idCode : {
		validator : function(value, param) {
			return /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value);
		},
		message : '请输入正确的身份证号'
	},
	englishOrNum : {
		// 只能输入英文和数字
		validator : function(value) {
			return /^[a-zA-Z0-9]+$/.test(value);
		},
		message : '只能输入英文字母、数字'
	},
	xiaoshu : {
		validator : function(value) {
			return /^(([1-9]+)|([0-9]+\.[0-9]{1,2}))$/.test(value);
		},
		message : '最多保留两位小数！'
	},
	ddPrice : {
		validator : function(value, param) {
			if (/^[1-9]\d*$/.test(value)) {
				return value >= param[0] && value <= param[1];
			} else {
				return false;
			}
		},
		message : '请输入1到100之间正整数'
	},
	// 验证年龄
	age : {
		validator : function(value) {
			return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
		},
		message : '年龄必须是0到120之间的整数'
	},
	// 验证货币
	currency : {
		validator : function(value) {
			return /^\d+(\.\d+)?$/i.test(value);
		},
		message : '货币格式不正确'
	},
	jretailUpperLimit : {
		validator : function(value, param) {
			if (/^[0-9]+([.]{1}[0-9]{1,2})?$/.test(value)) {
				return parseFloat(value) > parseFloat(param[0])
						&& parseFloat(value) <= parseFloat(param[1]);
			} else {
				return false;
			}
		},
		message : '请输入0到100之间的最多俩位小数的数字'
	},
	rateCheck : {
		validator : function(value, param) {
			if (/^[0-9]+([.]{1}[0-9]{1,2})?$/.test(value)) {
				return parseFloat(value) > parseFloat(param[0])
						&& parseFloat(value) <= parseFloat(param[1]);
			} else {
				return false;
			}
		},
		message : '请输入0到1000之间的最多俩位小数的数字'
	},
	// 日期、时间验证大小，结束日期应该大于开始日期
	compareDate : {
		validator : function(value, param) {
		
		var s = $("input[name="+param[0]+"]").val();
		//因为日期是统一格式的所以可以直接比较字符串 否则需要Date.parse(_date)转换
		
		return value>=s;
		},
		message : '结束日期应该大于开始日期！'
	},
	// 创建桶名校验  
	bucketName : {
		validator : function(value) {
			var reg = /^[a-zA-Z][a-zA-Z0-9-]*$/;
            return reg.test(value) && value.length >= 4 && value.length <= 63;
		},
		message : '名称由字母开头，4 ~ 63 个字符长 ，可包含 字母、数字、中划线。'
	}
});