var Book = function(id, name, price) {
		//私有属性
		var num = 1;
		//私有方法
		function checkId() {

		}
		//特权方法
		this.getName = function() {};
		this.getPrice = function() {};
		this.setName = function() {};
		this.setPrice = function() {};
		//对象共有属性
		this.id = id;
		this.copy = function() {};
		//构造器
		this.setName(name);
		this.setPrice(price);
	}
	/**/
Book.isChinese = true;
//类的静态共有属性(类静态共有方法)
Book.resetTime = function() {
	console.log('new Tiem');
};
Book.prototype = {
	//共有属性
	isJSBook: false,
	//公有方法
	display: function() {}
}
var b = new Book(11, 'javaScript', 50);
console.log(b.num); //undefined
console.log(b.isJSBook); //false
console.log(b.id); //11
console.log(b.isChinese); //undefined
//类的私有属性num和静态共有属性isChinese在b中是访问不到的
//类的共有属性可以通过类来访问
console.log(Book.isChinese); //true
Book.resetTime(); //new Tiem
/*
	闭包实现
	在一个函数内部创建另外一个函数
*/
var Book = (function() {
	//静态私有变量
	var bookNum = 0;
	//静态私有方法
	function checkBook(name) {

	}
	//返回构造函数
	return function(newId, newName, newPrice)() {
		//私有变量
		var name, price;
		//私有方法
		function checkID(id) {

		}
		//特权方法
		this.getName = function() {};
		this.getPrice = function() {};
		this.setName = function() {};
		this.setPrice = function() {};
		//公有属性
		this.id = newId;
		this.copy = function() {};
		bookNum++;
		if (bookNum > 100) {
			throw new Error('We sell 100 books only.')
		}
		//构造器
		this.setName(name);
		this.setPrice(price);
	}
}
})();

Book.prototype ={
	// 静态共有属性
	isJSBook =false,
	//静态共有方法
	display=function(){}
}
