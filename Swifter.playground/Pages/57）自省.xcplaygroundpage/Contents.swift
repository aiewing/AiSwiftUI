



/*
 程序设计和人类哲学所面临的同一个很重大的课题就是解决 "我是谁" 这个问题。在哲学里，这个问题属于自我认知的范畴，而在程序设计时，这个问题涉及到自省 (Introspection)。

 向一个对象发出询问，以确定它是不是属于某个类，这种操作就称为自省。在 Objective-C 中因为 id 这样的可以指向任意对象的指针的存在 (其实严格来说 Objective-C 的指针的类型都是可以任意指向和转换的，它们只不过是帮助编译器理解你的代码而已)，我们经常需要向一个对象询问它是不是属于某个类。

 [obj1 isKindOfClass:[ClassA class]];
 [obj2 isMemberOfClass:[ClassB class]];

 -isKindOfClass: 判断 obj1 是否是 ClassA 或者其子类的实例对象；
 而 isMemberOfClass: 则对 obj2 做出判断，当且仅当 obj2 的类型为 ClassB 时返回为真。

 这两个方法是 NSObject 的方法，所以我们在 Swift 中如果写的是 NSObject 的子类的话，直接使用这两个方法是没有任何问题的
 */

import UIKit

class ClassA: NSObject {}
class ClassB: ClassA {}

let obj1 = ClassB()
let obj2 = ClassB()

print(obj1.isKind(of: ClassA.self)) // true
print(obj2.isMember(of: ClassA.self)) // flase

/*
 在 Objective-C 中我们几乎所有的类都会是 NSObject 的子类，而在 Swift 的世界中，处于性能考虑，只要有可能，我们应该更倾向于选择那些非 NSObject 子类的 Swift 原生类型。对于那些不是 NSObject 的类，我们应该怎么确定其类型呢？

 首先需要明确的一点是，我们为什么需要在运行时去确定类型。因为有泛型支持，Swift 对类型的推断和记录是完备的。因此在绝大多数情况下，我们使用的 Swift 类型都应该是在编译期间就确定的。如果在你写的代码中经常需要检查和确定 AnyObject 到底是什么类的话，几乎就意味着你的代码设计出了问题 (或者你正在写一些充满各种 "小技巧" 的代码)。
 */

/*
 在 Swift 中对于 AnyObject 使用最多的地方应该就是原来那些返回 id 的 Cocoa API 了。

 为了快速确定类型，Swift 提供了一个简洁的写法：对于一个不确定的类型，我们现在可以使用 is 来进行判断。is 在功能上相当于原来的 isKindOfClass，可以检查一个对象是否属于某类型或其子类型。is 和原来的区别主要在于亮点，首先它不仅可以用于 class 类型上，也可以对 Swift 的其他像是 struct 或 enum 类型进行判断。使用起来是这个样子的
 */

let obj: AnyObject = ClassB()
print(obj is ClassA) // true
print(obj is ClassB) // true


/*
 编译器将对这种检查进行必要性的判断：如果编译器能够唯一确定类型，那么 is 的判断就没有必要，编译器将会抛出一个警告，来提示你并没有转换的必要。
 */

let string = "Hello"
print(string is String) // true
