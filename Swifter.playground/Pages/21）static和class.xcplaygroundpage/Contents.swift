

/*
 在非 class 的类型上下文中，我们统一使用 static 来描述类型作用域。这包括在 enum 和 struct 中表述类型方法和类型属性时。在这两个值类型中，我们可以在类型范围内声明并使用存储属性，计算属性和方法。

 class 关键字相比起来就明白许多，是专门用在 class 类型的上下文中的，可以用来修饰类方法以及类的计算属性。但是有一个例外，class 中现在是不能出现 class 的存储属性的，
 */

/*
 有一个比较特殊的是 protocol。在 Swift 中 class，struct 和 enum 都是可以实现某个 protocol 的。那么如果我们想在 protocol 里定义一个类型域上的方法或者计算属性的话，应该用哪个关键字呢？答案是使用 static 进行定义。在使用的时候，struct 或 enum 中仍然使用 static，而在 class 里我们既可以使用 class 关键字，也可以用 static
 */

protocol MyProtocol {
    static func foo() -> String
    static func run() -> String
}

struct MyStruct: MyProtocol {
    static func foo() -> String {
        return ""
    }
    static func run() -> String {
        return ""
    }
}

enum MyEnum: MyProtocol {
    static func foo() -> String {
        return ""
    }
    static func run() -> String {
        return ""
    }
}

class MyClass: MyProtocol {
    // 可以使用class
    class func foo() -> String {
        return ""
    }
    // 也可以使用static
    static func run() -> String {
        return ""
    }
}
