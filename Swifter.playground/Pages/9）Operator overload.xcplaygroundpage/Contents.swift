


struct Vector2D {
    var x = 0.0
    var y = 0.0
}

func +(left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let a = Vector2D(x: 2, y: 2)
let b = Vector2D(x: 2, y: 3)
let c = a + b
print(c)

precedencegroup DotProductPrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}

infix operator +*: DotProductPrecedence

func +* (left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}

let d = a +* b
print(d)

/*
 Swift的操作符是不能定义在局部域中的，因为至少会希望在能在全局范围使用你的操作符，否则操作符也就失去意义了。另外，来自不同 module 的操作符是有可能冲突的，这对于库开发者来说是需要特别注意的地方。如果库中的操作符冲突的话，使用者是无法像解决类型名冲突那样通过指定库名字来进行调用的。因此在重载或者自定义操作符时，应当尽量将其作为其他某个方法的"简便写法"，而避免在其中实现大量逻辑或者提供独一无二的功能。这样即使出现了冲突，使用者也还可以通过方法名调用的方式使用你的库。运算符的命名也应当尽量明了，避免歧义和可能的误解。因为一个不被公认的操作符是存在冲突风险和理解难度的，所以我们不应该滥用这个特性。在使用重载或者自定义操作符时，请先再三权衡斟酌，你或者你的用户是否真的需要这个操作符。
 */
