

/*
 KVO (Key-Value Observing) 是 Cocoa 中公认的最强大的特性之一，但是同时它也以烂到家的 API 和极其难用著称。和属性观察不同，KVO 的目的并不是为当前类的属性提供一个钩子方法，而是为了其他不同实例对当前的某个属性 (严格来说是 keypath) 进行监听时使用的。其他实例可以充当一个订阅者的角色，当被监听的属性发生变化时，订阅者将得到通知。

 这是一个很强大的属性，通过 KVO 我们可以实现很多松耦合的结构，使代码更加灵活和强大：像通过监听 model 的值来自动更新 UI 的绑定这样的工作，基本都是基于 KVO 来完成的。

 在 Swift 中我们也是可以使用 KVO 的，而且在 Swift 4 中，结合 KeyPath，Apple 为我们提供了非常漂亮的一套新的 API。不过 KVO 仅限于在 NSObject 的子类中，这是可以理解的，因为 KVO 是基于 KVC (Key-Value Coding) 以及动态派发技术实现的，而这些东西都是 Objective-C 运行时的概念。另外由于 Swift 为了效率，默认禁用了动态派发，因此想用 Swift 来实现 KVO，我们还需要做额外的工作，那就是将想要观测的对象标记为 dynamic 和 @objc。


 */

import UIKit
import Foundation

class MyClass: NSObject {
    @objc dynamic var date = Date()
}

class AiClass: NSObject {

    var myObject: MyClass!

    override init() {
        super.init()
        myObject = MyClass()
        print("初始化 MyClass，当前日期: \(myObject.date)")
        myObject.addObserver(self,
                             forKeyPath: "date",
                             options: .new,
                             context: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.myObject.date = Date()
        }
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let change = change {
            if let newDate = change[.newKey] as? Date {
                print("MyClass 日期发生变化 \(newDate)")
            }
        }
    }
}

//let obj = AiClass()
// 初始化 MyClass，当前日期: 2022-06-13 16:26:48 +0000
// MyClass 日期发生变化 2022-06-13 16:26:51 +0000


/*
 新的值是从字典中取出的。虽然我们能够确定 (其实是 Cocoa 向我们保证) 这个字典中会有相应的键值，但是在实际使用的时候我们最好还是进行一下判断或者 Optional Binding 后再加以使用，毕竟世事难料。“接下来，因为没有类型保证，我们从字典中取到的是一个 Any 值，想要使用前，我们还需要将它用 as 转换为特定的类型，这无疑有增加了人为错误的可能性。

 有没有可能改进一下呢？好消息是，Swift 4 中 Apple 引入了新的 KeyPath 的表达方式，现在，对于类型 Foo 中的变量 bar: Bar，对应的 KeyPath 可以写为 \Foo.bar。在这种表达方式下，KeyPath 将通过泛型的方式带有类型信息，比如上的 KeyPath 的类型为 KeyPath<Foo, Bar>。借助这个信息，Apple 在 NSObject 上添加了一个基于 block 的 KVO API，上面的例子可以重新写为
 */

class AnotherClass: NSObject {
    var myObject: MyClass!
    var observation: NSKeyValueObservation?
    override init() {
        super.init()
        myObject = MyClass()
        print("初始化 AnotherClass，当前日期: \(myObject.date)")

        observation = myObject.observe(\MyClass.date, options: [.new]) { (_, change) in
            if let newDate = change.newValue {
                print("AnotherClass 日期发生变化 \(newDate)")
            }
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.myObject.date = Date()
        }
    }
}

AnotherClass()
// 初始化 AnotherClass，当前日期: 2022-06-13 16:29:50 +0000
// AnotherClass 日期发生变化 2022-06-13 16:29:54 +0000

/*
 相较于原来 Objective-C 方式的处理，使用 Swift 4 KeyPath 的好处显而易见。首先，设定观察和处理观察的代码被放在了一起，让代码维护难度降低很多；其次在处理时我们得到的是类型安全的结果，而不是从字典中取值；最后，我们不再需要使用 context 来区分是哪一个观察量发生了变化，而且使用observation 来持有观察者可以让我们从麻烦的内存管理中解放出来，观察者的生命周期将随着 AnotherClass 的释放而结束。对比一下在 Class 中，我们还需要在实例完成任务时找好时机停止观察，否则将造成内存泄漏。

 */

/*
 不过在 Swift 中使用 KVO 还是有有两个显而易见的问题。

 第一，显然 Swift 的 KVO 需要依赖的东西比原来多。在 Objective-C 中我们几乎可以没有限制地对所有满足 KVC 的属性进行监听，而现在我们需要属性有 dynamic 和 @objc 进行修饰。大多数情况下，我们想要观察的类包含这两个修饰 (除非这个类的开发者有意为之，否则一般也不会有人愿意多花功夫在属性前加上它们，因为这毕竟要损失一部分性能)，并且有时候我们很可能也无法修改想要观察的类的源码。遇到这样的情况的话，一个可能可行的方案是继承这个类并且将需要观察的属性使用 dynamic 和 @objc 进行重写。比如刚才我们的 MyClass 中如果 date 没有相应标注的话，我们可能就需要一个新的 MyChildClass 了

 class MyClass: NSObject {
     var date = Date()
 }

 class MyChildClass: MyClass {
     @objc dynamic override var date: Date {
         get { return super.date }
         set { super.date = newValue }
     }
 }

 对于这种重载，我们没有必要改变什么逻辑，所以在子类中简单地用 super 去调用父类里相关的属性就可以了

 另一个大问题是对于那些非 NSObject 的 Swift 类型怎么办。因为 Swift 类型并没有通过 KVC 进行实现，所以更不用谈什么对属性进行 KVO 了。对于 Swift 类型，语言中现在暂时还没有原生的类似 KVO 的观察机制。我们可能只能通过属性观察来实现一套自己的类似替代了。另外一个可能的思路是将 Swift 类型进行引用封装，然后利用 KeyPath 也可以用在 Swift 类型上的显示来引入观察的机制。
 */


