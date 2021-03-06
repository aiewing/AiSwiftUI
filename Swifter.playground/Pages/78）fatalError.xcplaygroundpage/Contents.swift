


/*
 细心的读者可能会发现，在我们调试一些纯 Swift 类型出现类似数组越界这样的情况时，我们在控制台得到的报错信息会和传统调试 NSObject 子类时不太一样，比如在使用 NSArray 时：

 let array: NSArray = [1,2,3]
 array[100]
 // 输出:
 // *** Terminating app due to uncaught exception 'NSRangeException',
 // reason: '*** -[__NSArrayI objectAtIndex:]:
 // index 100 beyond bounds [0 .. 2]

 而如果我们使用 Swift 类型的话：

 let array = [1,2,3]
 array[100]
 // 输出:
 // fatal error: Array index out of range


 在调试时我们可以使用断言来排除类似这样的问题，但是断言只会在 Debug 环境中有效，而在 Release 编译中所有的断言都将被禁用。在遇到确实因为输入的错误无法使程序继续运行的时候，我们一般考虑以产生致命错误 (fatalError) 的方式来终止程序。

 fatalError 的使用非常简单，它的 API 和断言的比较类似

 @noreturn func fatalError(@autoclosure message: () -> String = default,
                                           file: StaticString = default,
                                           line: UInt = default)


 关于语法，唯一要需要解释的是 @noreturn，这表示调用这个方法的话可以不再需要返回值，因为程序整个都将终止。这可以帮助编译器进行一些检查，比如在某些需要返回值的 switch 语句中，我们只希望被 switch 的内容在某些范围内，那么我们在可以在不属于这些范围的 default 块里直接写 fatalError 而不再需要指定返回值：
 */


enum MyEnum {
    case Value1, Value2, Value3
}

func check(someValue: MyEnum) -> String {
    switch someValue {
    case .Value1:
        return "OK"
    case .Value2:
        return "Maybe OK"
    default:
        // 这个分支没有返回 String，也能编译通过
        fatalError("Should not show!")
    }
}

//check(someValue: .Value3)

/*
 在我们实际自己编码的时候，经常会有不想让别人调用某个方法，但又不得不将其暴露出来的时候。一个最常见并且合理的需求就是“抽象类型或者抽象函数”。在很多语言中都有这样的特性：父类定义了某个方法，但是自己并不给出具体实现，而是要求继承它的子类去实现这个方法，而在 Objective-C 和 Swift 中都没有直接的这样的抽象函数语法支持，虽然在 Cocoa 中对于这类需求我们有时候会转为依赖协议和委托的设计模式来变通地实现，但是其实 Apple 自己在 Cocoa 中也有很多类似抽象函数的设计。比如 UIActivity 的子类必须要实现一大堆指定的方法，而正因为缺少抽象函数机制，这些方法都必须在文档中写明。

 在面对这种情况时，为了确保子类实现这些方法，而父类中的方法不被错误地调用，我们就可以利用 fatalError 来在父类中强制抛出错误，以保证使用这些代码的开发者留意到他们必须在自己的子类中实现相关方法：
 */

class MyClass {
    func methodMustBeImplementedInSubclass() {
        fatalError("这个方法必须在子类中被重写")
    }
}

class YourClass: MyClass {
    override func methodMustBeImplementedInSubclass() {
        print("YourClass 实现了该方法")
    }
}

class TheirClass: MyClass {
    func someOtherMethod() {

    }
}

YourClass().methodMustBeImplementedInSubclass()
// YourClass 实现了该方法

TheirClass().methodMustBeImplementedInSubclass()
// 这个方法必须在子类中被重写


/*
 不过一个好消息是 Apple 不仅意识到了抽象函数这个特性的缺失，而且在 Swift 2 开始提出了面向协议编程的概念 (Protocol-Oriented Programming) 的概念。通过使用协议，我们可以将需要实现的方法定义在协议中，遵守协议的类型必须实现这个方法。相比起“模拟的抽象函数”的方式，面向协议编程能够提供编译时的保证，而不需要将检查推迟到运行的时候。

 不仅仅是对于类似抽象函数的使用中可以选择 fatalError，对于其他一切我们不希望别人随意调用，但是又不得不去实现的方法，我们都应该使用 fatalError 来避免任何可能的误会。比如父类标明了某个 init 方法是 required 的，但是你的子类永远不会使用这个方法来初始化时，就可以采用类似的方式， 被广泛使用 (以及被广泛讨厌的) init(coder: NSCoder) 就是一个例子。在子类中，我们往往会写：

 required init(coder: NSCoder) {
   fatalError("NSCoding not supported")
 }

 来避免编译错误。
 */
