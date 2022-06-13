

/*
 原生的 Swift protocol 里没有可选项，所有定义的方法都是必须实现的。如果我们想要像 Objective-C 里那样定义可选的协议方法，就需要将协议本身和可选方法都定义为 Objective-C 的，也即在 protocol 定义之前以及协议方法之前加上 @objc。另外和 Objective-C 中的 @optional 不同，我们使用没有 @ 符号的关键字 optional 来定义可选方法：
 
 @objc protocol OptionalProtocol {
     @objc optional func optionalMethod()
 }
 
 
 
 */

/*
 在 Swift 2.0 中，我们有了另一种选择，那就是使用 protocol extension。我们可以在声明一个 protocol 之后再用 extension 的方式给出部分方法默认的实现。这样这些方法在实际的类中就是可选实现的了。还是举上面的例子，使用协议扩展的话，会是这个样子：
 */
protocol OptionalProtocol {
    func optionalMethod()        // 可选
    func necessaryMethod()       // 必须
}

extension OptionalProtocol {
    func optionalMethod() {
        print("Implemented in extension")
    }
}

class MyClass: OptionalProtocol {
    func necessaryMethod() {
        print("Implemented in Class3")
    }
}
