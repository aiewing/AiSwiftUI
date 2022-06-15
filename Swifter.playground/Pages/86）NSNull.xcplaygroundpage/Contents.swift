



/*
 NSNull 出场最多的时候就是在 JSON 解析了。
 
 在 Objective-C 中，因为 NSDictionay 和 NSArray 只能存储对象，对于像 JSON 中可能存在的 null 值，NSDictionay 和 NSArray 中就只能用 NSNull 对象来表示。Objective-C 中的 nil 实在是太方便了，我们向 nil 发送任何消息时都将返回默认值，因此很多时候我们过于依赖这个特性，而不再去进行检查就直接使用对象。大部分时候这么做没有问题，但是在处理 JSON 时，NSNull 却无法使用像 nil 那样的对所有方法都响应的特性。而又因为 Objective-C 是没有强制的类型检查的，我们可以任意向一个对象发送任何消息，这就导致如果 JSON 对象中存在 null 时 (不论这是有意为之还是服务器方面出现了某种问题) 的话，对其映射为的 NSNull 直接发送消息时，app 将发生崩溃。
 
 在 Objective-C 中，我们一般通过严密的判断来解决这个问题：即在每次发送消息的时候都进行类型检查，以确保将要接收消息的对象不是 NSNull 的对象。另一种方法是添加 NSNull 的 category，让它响应各种常见的方法 (比如 integerValue 等)，并返回默认值。两种方式都不是非常完美，前一种过于麻烦，后一种难免有疏漏。
 
 而在 Swift 中，这个问题被语言的特性彻底解决了。因为 Swift 所强调的就是类型安全，无论怎么说都需要一层转换。因此除非我们故意犯二不去将 AnyObject 转换为我们需要的类型，否则我们绝对不会错误地向一个 NSNull 发送消息。NSNull 会默默地被通过 Optional Binding 被转换为 nil，从而避免被执行
 */

import UIKit

// 假设 jsonValue 是从一个 JSON 中取出的 NSNull
let jsonValue: AnyObject = NSNull()

if let string = jsonValue as? String {
    print(string.hasPrefix("a"))
} else {
    print("不能解析")
}

// 输出：
// 不能解析
