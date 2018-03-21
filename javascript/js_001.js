var log = console.log.bind(console);

/// like the global variable
var App = function() {
	var o = {
		name: "treee",
		age: 26,
	}
	return o
}()
// 输出一个对象的属性
log(App.name)

// 方法
var _show = function(content) {
	log(arguments)
	log(content)
}
_show("haha", 1, 2)

// 变量作用域与解构赋值
var person = {
	name: '小明',
	age: 20,
	gender: 'male',
	address: {city: 'beijing'}
}
var {name, age, g, } = person
log(name, age, g)

