(function($) {

	$.fn.select = function(options) {

		// 默认参数
		var defaults = {
			titName : 'temp-select', // 内容类名
			mainName : 'tempDown', // 下拉框类名
			active : 'on', // 高亮类名
			effect : 'fade', // 展示效果 fade || slide || fold
			paramIndex : 0, // 默认显示
			speed : 300, // 速度
			left : 0, // 下拉偏移
			top : 30, // 下拉偏移
			addDot : false, // 是否添加点
			endFun : null, // 回调函数
			clickStop : true
		// 链接跳转 _blank 方法：data-target='_blank'
		};
		return this.each(function(index) {

			var obj = $.extend({}, defaults, options);
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
			var body = $('body');

			// 是否已经创建
			if (_this.next().hasClass('spreadCell')) {
				return true
			}
			;

			// 下拉元素是否创建
			if (!body.children().hasClass(mainName)) {
				body.append('<div class="spreadDown ' + mainName + '"></div>')
			}
			;

			// 添加节点元素
			_this.hide().after(
					'<div class="spreadCell ' + obj.titName + '" style="width:'
							+ width + 'px"><div class="up"></div></div>');

			var main = body.children('.' + obj.mainName);
			var wrap = _this.next();
			var opt = _this.children('option');
			var toggleTarget = _this.attr('data-target') == undefined ? '_self'
					: _this.attr('data-target');

			// 初始化
			_this.val(opt.eq(pIn).val());
			wrap.children('.up').text(opt.eq(pIn).text());
			main.hide();

			if (obj.addDot == true) {
				wrap.append('<div class="dot"></div>')
			}
			;

			// 隐藏方式
			var effHide = function() {
				switch (effect) {
				case 'fade':
					main.hide();
					break;
				case 'fold':
					main.fadeOut(speed);
					break;
				case 'slide':
					main.slideUp(speed);
					break;
				}
				;
			}

			// 触发函数
			var doPlay = function(e) {

				e.preventDefault();
				e.stopPropagation();

				var then = $(this);
				var thenUp = then.children('.up');
				var str = '';
				var left = then.offset().left;
				var top = then.offset().top;

				opt = _this.children('option');

				if (then.hasClass(active)) {

					effHide();
					then.removeClass(active);

				} else {

					$('.spreadCell').removeClass(active);
					$('.spreadDown').hide();

					then.addClass(active);

					// 获取下拉内容
					for ( var i = 0, len = opt.length; i < len; i++) {
						str += '<a data-path="' + opt.eq(i).val() + '">'
								+ opt.eq(i).text() + '</a>';
					}
					;

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
					switch (effect) {
					case 'fade':
						main.show();
						break;
					case 'fold':
						main.fadeIn(speed);
						break;
					case 'slide':
						main.slideDown(speed);
						break;
					}
					;

					// 下拉绑定事件
					main.off('click', 'a').on(
							'click',
							'a',
							function(e) {

								var that = $(this).parent();
								var text = $(this).text();
								var param = $(this).index();
								var dataPath = $(this).attr('data-path');

								if (!clickStop) {
									$(this).attr({
										'href' : dataPath,
										target : toggleTarget
									});
								} else {
									e.preventDefault();
								}
								thenUp.text(text);
								// _this.val(dataPath);
								_this.children().eq(param).attr('selected',
										true).siblings()
										.attr('selected', false);
								that.hide();

								if ($.isFunction(endFun)) {
									endFun(param, text, dataPath, _this)
								}
								;
							});

					// 改变窗口 重置偏移
					$(window).resize(function() {
						var winLeft = then.offset().left;
						var winTop = then.offset().top;
						main.css({
							left : winLeft + offLeft + 'px',
							top : winTop + offTop + 'px'
						});
					});

					$(document).click(function() {

						effHide();
						wrap.removeClass(active);

					});

				}

			};

			wrap.click(doPlay);

		});
	}

})(jQuery);

$(function() {
	vEffectone();
});

function vEffectone() {
	$('.register select').each(function() {
		if (!$(this).parents().hasClass('register-link')) {
			$(this).select({
				endFun:function(param,text,dataPath,_this){
					/*console.log(param)
					console.log(text)
					console.log(dataPath)
					console.log(_this)*/
					
					$('#pemail').removeClass('errorActive');
					// $('#pemail').addClass('focusActive');
					$("#" + $('#pemail').attr('id') + "_span").remove();
				}
			}
					
					
			);
		}
	});

	$('.register .text')
			.on(
					{
						'focus' : function() {
							$(this).removeClass('errorActive');
							$(this).addClass('focusActive');
							$("#" + $(this).attr('id') + "_span").remove();
							// $(this).parent().remove($($(this).attr('id')+'_span'));
							// if($($(this).attr('id')+'_span')){
							// $($(this).attr('id')+'_span').remove();
							// }
						},
						'blur' : function() {
							$(this).removeClass("focusActive");
							var flag = isValid($(this).attr('id'), $(this)
									.val(), '');
							if (flag != 0) {
								if ($(this).hasClass('errorActive')) {
									return;
								}
								$(this).addClass('errorActive');
								$(this)
										.parent()
										.append(
												'<span id="'
														+ $(this).attr('id')
														+ '_span" class="validatorfailure"><img src="'+path+'/icp/images/icon/error.png"/> '
														+ getAlertMsg(flag)
														+ '</span>');
							}

						}
					});

	$('.register .file-cell').each(function() {
		var mark = $(this).siblings('.file-mark');
		$(this).find('input[type="file"]').change(function() {
			mark.text($(this).val());
		});
	});

}
function isValid(id, value) {
	switch (id) {
	case 'email':

		return emailCheck(value);
	case 'passwd':

		return passCheck(value);
	case 'repasswd':

		return repassCheck(value);
	case 'alias':
		return aliCheck(value);
	case 'mobile':
		return mobiCheck(value);
	case 'uname':
		return unaCheck(value);
	case 'pemail':
		return pemCheck(value);
	//case 'pwdpp':
	//	return pwdppCheck(value);
	case 'pwdppanswer':
		return pwdanCheck(value);
	case 'inputCode':
		return codCheck(value);
	default:
		return 0;
	}
}

function getAlertMsg(flag) {
	switch (flag) {
	case 1:
		return "不能为空";
	case 2:
		return "不是有效的电子邮箱地址";
	case 3:
		return "该邮箱被注册，请使用该账号直接<a class='aherf' target='_blank' href='"+path+"/icp/login.jsp'>登录</a>";
	case 4:
		return "账户未通过审核";
	case 5:
		return "尚未完成注册，<a class='aherf' target='_blank' href='"+path+"/uu/regContinue.do?email="+$('#email').val()+"' >继续？</a>";
	case 6:
		return "账户还未审核";
	case 7:
		return "大写、小写字母、数字和标点符号至少包含2种";
	case 8:
		return "两次输入密码不一致";
	case 9:
		return "必须纯数字";
	case 10:
		return "手机号码格式不正确";
	case 11:
		return "字母开头2-20个字母、数字、下划线";
	case 12:
		return "只能使用汉字或英文字母,长度大于2";
	case 13:
		return "该父账户不是有效的";
	case 14:
		return "注册账户不能是自身的父账户";
	case 15:
		return "验证码错误";
	case 16:
		return "该手机号码已被注册";
	case 17:
		return "长度必须在6-20之间";
	case 18:
		return "不能为空字符串";
	case 19:
		return "密保问题不能为空";
	case 20:
		return "别名不唯一";
	case 21:
		return "账户已注销";
	default:
		return "未知错误";
	}

}

function emailCheck(value) {
	var search_str = /^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/;
	if ($.trim(value) == '') {
		return 1;
	} else if (!search_str.test(value)) {
		return 2;
	} else if (1 == 1) {
		var flag = -1;
		$.ajax({
			url : path + "/uu/validateEmail.do",
			cache : false,
			async : false,
			data : "type=email&value=" + value + "&cher=status",
			success : function(b) {
			
				var r = $.parseJSON(b);
				if (r.success) {
					switch (r.msg) {
					case "-1":
						flag = 0;
						break;
					case "0":
						flag = 4;
						break;
					case "1":
						flag = 5;
						break;
					case "2":
						flag = 6;
						break;
					case "3":
						flag = 3;
						break;
					case "4":
						flag = 21;
						break;
					default:
						flag = -1;
					}
				}
			}
		});

		return flag;
	}
	return 0;
}
function passCheck(value) {
	if ($.trim(value) == '') {
		return 1;
	} else if ($.trim(value).length < 6 || $.trim(value).length > 20) {
		return 17;
	} else {
		var a = value.match(/([a-z])+/);
		var b = value.match(/([A-Z])+/);
		var c = value.match(/([0-9])+/);
		var d = value.match(/([^a-zA-Z0-9])+/);

		var match = (a && b) || (a && c) || (a && d) || (b && c) || (b && d)
				|| (d && c);
		if (!match) {
			return 7;
		}
	}
	return 0;
}
function repassCheck(value) {
	if ($.trim(value) == '') {
		return 1;
	} else if ($('#passwd').val() != value) {
		return 8;
	}
	return 0;
}
function mobiCheck(value) {
	if ($.trim(value) == '') {
		return 1;
	} else if (!/^[0-9]*$/.test(value)) {
		return 9;
	} else if (!/^1[3|5|7|8|][0-9]{9}$/.test(value)) {
		return 10;
	} else if (1 == 1) {
		var flag = -1;
		$.ajax({
			url : path + "/uu/validate.do",
			cache : false,
			async : false,
			data : "type=mobile&value=" + value,
			success : function(b) {
				var r = $.parseJSON(b);
				if (r.success) {
					flag = 16;
				} else {
					flag = 0;
				}
			}
		});

		return flag;
	}
	return 0;
}
function aliCheck(value) {
	if ($.trim(value) == '') {
		return 1;
	} else if (!/^[a-zA-Z][\w]{1,19}$/.test(value)) {
		return 11;
	} else if (1 == 1) {
		var flag = -1;
		$.ajax({
			url : path + "/uu/validate.do",
			cache : false,
			async : false,
			data : "type=alias&value=" + value,
			success : function(b) {
				var r = $.parseJSON(b);
				if (r.success) {
					flag = 20;
				} else {
					flag = 0;
				}
			}
		});

		return flag;
	}
	return 0;

}
function unaCheck(value) {
	if (value == '') {
		return 1;
	} else if (!/^[\u4E00-\u9FA5a-zA-Z]{2,20}$/.test(value)) {
		return 12;
	}
	return 0;
}

function pemCheck(value) {
	if ($.trim(value) == '') {
		return 1;
	} else if (!/^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/.test(value)) {
		return 2;
	} else if (value == $('#email').val()) {
		return 14;
	} else if (1 == 1) {
		var flag = -1;
		$.ajax({
			url : path + "/uu/validateEmail.do",
			cache : false,
			async : false,
			data : "type=email&value=" + value + "&cher=userlevel&ty=usertype="+$('#usertype').val()+" and status=3",
			success : function(b) {
				var r = $.parseJSON(b);
				if (r.success) {
					switch (r.msg) {
					case "-1":
						flag = 13;
						break;
					case "1":
						flag = 0;
						break;
					case "2":
						flag = 13;
						break;
					default:
						flag = -1;
					}
				}
			}
		});

		return flag;
	}
	return 0;
}
function codCheck(value) {
	if ($.trim(value) == '') {
		return 1;
	} else if (1 == 1) {
		var flag = -1;
		$.ajax({
			url : path + "/uu/validatecod.do",
			cache : false,
			async : false,
			data : "value=" + value,
			success : function(b) {
				var r = $.parseJSON(b);
				if (r.success) {
					flag = 0;
				} else {
					flag = 15;
					refresh();
				}
			}
		});

		return flag;

	}
	return 0;
}
function pwdppCheck(value) {
	if (value != '' && $.trim(value) == '') {
		return 18;
	}
	return 0;
}
function pwdanCheck(value) {
	if ($.trim(value) == '') {
		return 1;
	}
	return 0;
}
function check() {
	var isVa = true;
	$('.register .text')
			.each(
					function() {
						if ($(this).hasClass('errorActive')) {
							isVa = false;
						} else if (!$(this).is(":hidden")) {
							var flag = isValid($(this).attr('id'), $(this)
									.val(), '');
							if (flag != 0) {
								$(this).addClass('errorActive');
								$(this)
										.parent()
										.append(
												'<span id="'
														+ $(this).attr('id')
														+ '_span" class="validatorfailure"><img src="'+path+'/icp/images/icon/error.png"/> '
														+ getAlertMsg(flag)
														+ '</span>');
								isVa = false;
							}
						}
					});
	if(isVa)
	{
		$("#userlevel").val($('#userlevelch').val()); 
	}
	return isVa;
}
function showPemailDiv(obj) {
	var pemailObj = document.getElementById("pemaildiv"); // 获取父账户obj
	var biwayObj = document.getElementById("biwaydiv"); // 获取父账户obj
	if (obj.checked) {
		$('#pemail').val('');
		biwayObj.style.display = '';
		pemailObj.style.display = '';
		//userlevelobj.setAttribute("value", "2");
		$('#userlevelch').val('2');
	} else {
		$('#pemail').val('');
		biwayObj.style.display = 'none';
		pemailObj.style.display = 'none';
		//userlevelobj.setAttribute("value", "1");
		$('#userlevelch').val('1');
	}
	$('#pemail').removeClass('errorActive');
	// $('#pemail').addClass('focusActive');
	$("#" + $('#pemail').attr('id') + "_span").remove();
}

