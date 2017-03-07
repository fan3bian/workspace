//对象 属性 方法
//对象作用：收编方法
var CheckObject = {
	checkName = function(){
		//
	},
	checkEmail = function(){

	},
	checkPassword = function(){

	}
}
//先创建对象，再添加方法
var CheckObject = function(){};
CheckObject.checkName = function(){

}
CheckObject.checkEmail =function(){

}
CheckObject.checkPassword =function(){

}
//便于复制，放在函数对象中
var CheckObject =function(){
	return{
		checkName: function(){
			
		},
		checkEmail:function(){

		},
		checkPassword:function(){

		}
	}
}

var a = CheckObject();
a.checkEmail();
//a对象与CheckObject对象没任何关系

/*
	使用类
*/
var CheckObject = function(){
	this.checkName =function(){

	}
	this.checkEmail =function(){

	}
	this.checkPassword=function(){

	}
}

var a = new CheckObject(){
	a.checkEmail();
}
//通过new心创建的对象有自己的一套方法，消耗比较大
//因为方法绑定在对象上
/*
	使用原型
*/
var CheckObject = function(){};
CheckObject.prototype.checkEmail=function(){}
CheckObject.prototype.checkName=function(){}
CheckObject.prototype.checkPassword=function(){}
//方法绑定在类的原型上，原型方法(类方法)
/*
	原型第二种写法
*/
var CheckObject =function(){};
CheckObject.prototype={
	checkName:function(){

	},
	checkEmail:function(){

	},
	checkPassword:function(){

	}
}
//混用会覆盖掉，尤其第二种
var a =new CheckObject();
a.checkName();
a.checkEmail();
a.checkPassword();
/*
	简化对象调用的方式
*/
var CheckObject =function(){};
CheckObject.prototype={
	checkName:function(){
		return this;
	},
	checkEmail:function(){
		return this;
	},
	checkPassword:function(){
		return this;
	}
}

var a =new CheckObject();
a.checkName().checkEmail().checkPassword();
//prototype.js
/*
	扩展Function原型
*/
Function.prototype.addMethod=function(name,fn){
	this[name]=fn;
}
var methods =new Function();
methods.addMethod('checkName',function(){});
methods.addMethod('checkEmail',function(){});
methods.addMethod('checkPassword',function(){});
/*
	链式添加(连缀)
*/
Function.prototype.addMethod=function(name,fn){
	this[name]=fn;//添加连缀
}
var methods =new Function();
methods.addMethod('checkName',function(){
	return this;//调用连缀
}).addMethod('checkEmail',function(){
	return this;
}).addMethod('checkPassword',function(){
	return this;
});
//函数式调用
methods.checkEmail().checkName().checkPassword();
//类式调用
var m =new methods();
m.checkName()

