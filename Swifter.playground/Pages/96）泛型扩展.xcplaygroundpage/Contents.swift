

/*
 Swift 对于泛型的支持使得我们可以避免为类似的功能多次书写重复的代码，这是一种很好的简化。而对于泛型类型，我们也可以使用 extension 为泛型类型添加新的方法。
 
 与为普通的类型添加扩展不同的是，泛型类型在类型定义时就引入了类型标志，我们可以直接使用。例如 Swift 的 Array 类型的定义是：
 
 public struct Array<Element> : RandomAccessCollection, MutableCollection {
     //...
 }

 在这个定义中，已经声明了 Element 为泛型类型。在为类似这样的泛型类型写扩展的时候，我们不需要在 extension 关键字后的声明中重复地去写 <Element> 这样的泛型类型名字 (其实编译器也不允许我们这么做)，在扩展中可以使用和原来所定义一样的符号即可指代类型本体声明的泛型。比如我们想在扩展中实现一个 random 方法来随机地取出 Array 中的一个元素：

 */

import UIKit

extension Array {
    var random: Element? {
        return self.count != 0 ? self[Int(arc4random_uniform(UInt32(self.count)))] : nil
    }
}

let languages = ["Swift","ObjC","C++","Java"]
print(languages.random!)

let ranks = [1,2,3,4]
print(ranks.random!)

/*
 在扩展中是不能添加整个类型可用的新泛型符号的，但是对于某个特定的方法来说，我们可以添加 T 以外的其他泛型符号。比如在刚才的扩展中加上
 */

extension Array {
    func appendRandomDescription<U: CustomStringConvertible>(_ input: U) -> String {
        if let element = self.random {
            return "\(element) " + input.description
        } else {
            return "empty array"
        }
    }
}

print(languages.appendRandomDescription(ranks.random!))


/*
 简单说就是我们不能通过扩展来重新定义当前已有的泛型符号，但是可以对其进行使用；
 在扩展中也不能为这个类型添加泛型符号；
 但只要名字不冲突，我们是可以在新声明的方法中定义和使用新的泛型符号的。
 */
