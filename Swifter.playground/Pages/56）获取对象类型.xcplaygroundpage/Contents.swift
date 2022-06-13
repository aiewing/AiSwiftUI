



/*
 在 Swift 中，我们会发现不管是纯 Swift 的 class 还是 NSObject 的子类，都没有像原来那样的 class() 方法来获取类型了。对于 NSObject 的子类，因为其实类的信息的存储方式并没有发生什么大的变化，因此我们可以求助于 Objective-C 的运行时，来获取类并按照原来的方式转换
 */

import UIKit
import Foundation

let date = NSDate()
let name = object_getClass(date)
print(name)
// Optional(__NSTaggedDate)


/*
 其中 object_getClass 是一个定义在 ObjectiveC 的 runtime 中的方法，它可以接受任意的 AnyObject! 并返回它的类型 AnyClass! (注意这里的叹号，它表明我们甚至可以输入 nil，并期待其返回一个 nil)。在 Swift 中其实为了获取一个 NSObject 或其子类的对象的实际类型，对这个调用其实有一个好看一些的写法，那就是 type(of:)。
 */

print(type(of: NSDate()))
// __NSTaggedDate

print(type(of: "Hello"))
// String

/*
 可以看到对于 Swift 的原生类型，这种方式也是可行的。(值得指出的是，其实这里的真正的类型名字还带有 module 前缀，也就是 Swift.String。直接 print 只是调用了 CustomStringConvertible 中的相关方法而已，你可以使用 debugPrint 来进行确认。关于更多地关于 print 和 debugPrint 的细节，可以参考 print 和 debugPrint 一节的内容。)
 */
debugPrint(type(of: "Hello"))
// Swift.String
