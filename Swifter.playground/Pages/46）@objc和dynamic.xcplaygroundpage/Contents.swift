



/*
 其实一个项目中的 Objective-C 文件和 Swift 文件是处于两个不同世界中的，为了让它们能相互联通，我们需要添加一些桥梁。
 
 首先通过添加 {product-module-name}-Bridging-Header.h 文件，并在其中填写想要使用的头文件名称，我们就可以很容易地在 Swift 中使用 Objective-C 代码了。Xcode 为了简化这个设定，甚至在 Swift 项目中第一次导入 Objective-C 文件时会主动弹框进行询问是否要自动创建这个文件，可以说是非常方便。
 
 但是如果想要在 Objective-C 中使用 Swift 的类型的时候，事情就复杂一些。如果是来自外部的框架，那么这个框架与 Objective-C 项目肯定不是处在同一个 target 中的，我们需要对外部的 Swift module 进行导入。这个其实和使用 Objective-C 的原来的 Framework 是一样的，对于一个项目来说，外界框架是由 Swift 写的还是 Objective-C 写的，两者并没有太大区别。我们通过使用 2013 年新引入的 @import 来引入 module：
 
 @import MySwiftKit;

 之后就可以正常使用这个 Swift 写的框架了。
 
 如果想要在 Objective-C 里使用的是同一个项目中的 Swift 的源文件的话，可以直接导入自动生成的头文件 {product-module-name}-Swift.h 来完成。比如项目的 target 叫做 MyApp 的话，我们就需要在 Objective-C 文件中写
 
 #import "MyApp-Swift.h
 
 
 
 但这只是故事的开始。Objective-C 和 Swift 在底层使用的是两套完全不同的机制，Cocoa 中的 Objective-C 对象是基于运行时的，它从骨子里遵循了 KVC (Key-Value Coding，通过类似字典的方式存储对象信息) 以及动态派发 (Dynamic Dispatch，在运行调用时再决定实际调用的具体实现)。而 Swift 为了追求性能，如果没有特殊需要的话，是不会在运行时再来决定这些的。也就是说，Swift 类型的成员或者方法在编译时就已经决定，而运行时便不再需要经过一次查找，而可以直接使用。
 
 显而易见，这带来的问题是如果我们要使用 Objective-C 的代码或者特性来调用纯 Swift 的类型时候，我们会因为找不到所需要的这些运行时信息，而导致失败。解决起来也很简单，在 Swift 类型文件中，我们可以将需要暴露给 Objective-C 使用的任何地方 (包括类，属性和方法等) 的声明前面加上 @objc 修饰符。注意这个步骤只需要对那些不是继承自 NSObject 的类型进行，如果你用 Swift 写的 class 是继承自 NSObject 的话，Swift 会默认自动为所有的非 private 的类和成员加上 @objc。这就是说，对一个 NSObject 的子类，你只需要导入相应的头文件就可以在 Objective-C 里使用这个类了。

 @objc 修饰符的另一个作用是为 Objective-C 侧重新声明方法或者变量的名字。虽然绝大部分时候自动转换的方法名已经足够好用 (比如会将 Swift 中类似 init(name: String) 的方法转换成 -initWithName:(NSString *)name 这样)，但是有时候我们还是期望 Objective-C 里使用和 Swift 中不一样的方法名或者类的名字
 
 
 
 即使是 NSObject 的子类，Swift 也不会在被标记为 private 的方法或成员上自动加 @objc，以保证尽量不使用动态派发来提高代码执行效率。如果我们确定使用这些内容的动态特性的话，我们需要手动给它们加上 @objc 修饰。
 
 但是需要注意的是，添加 @objc 修饰符并不意味着这个方法或者属性会变成动态派发，Swift 依然可能会将其优化为静态调用。如果你需要和 Objective-C 里动态调用时相同的运行时特性的话，你需要使用的修饰符是 dynamic。一般情况下在做 app 开发时应该用不上，但是在施展一些像动态替换方法或者运行时再决定实现这样的 "黑魔法" 的时候，我们就需要用到 dynamic 修饰符了。在 KVO 一节中，我们提到了一个关于使用 dynamic 的实例。
 */
import UIKit
import Foundation

protocol MyProtocol {
    func foo()
}

extension MyProtocol {
    func foo() {
        print("MyProtocol-foo")
    }
}

class MyClass: MyProtocol {
    func foo() {
        print("MyClass-foo")
    }
}

class YourClass: MyProtocol {
    func foo() {
        print("YourClass-foo")
    }
}

func run(_ myClass: MyProtocol) {
    myClass.foo()
}

let myClass = MyClass()
run(myClass)
let yourClass = YourClass()
run(yourClass)
