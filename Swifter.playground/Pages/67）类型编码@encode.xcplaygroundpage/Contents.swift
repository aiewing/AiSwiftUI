

/*
 Objective-C 中有一些很冷僻但是如果知道的话在特定情况下会很有用的关键字，比如说通过类型获取对应编码的 @encode 就是其中之一。
 
 在 Objective-C 中 @encode 使用起来很简单，通过传入一个类型，我们就可以获取代表这个类型的编码 C 字符串
 
 char *typeChar1 = @encode(int32_t);
 char *typeChar2 = @encode(NSArray);
 // typeChar1 = "i", typeChar2 = "{NSArray=#}"

 我们可以对任意的类型进行这样的操作。这个关键字最常用的地方是在 Objective-C 运行时的消息发送机制中，在传递参数时，由于类型信息的缺失，需要类型编码进行辅助以保证类型信息也能够被传递。在实际的应用开发中，其实使用案例比较少：某些 API 中 Apple 建议使用 NSValue 的 valueWithBytes:objCType: 来获取值 (比如 CIAffineClamp 的文档里) ，这时的 objCType 就需要类型的编码值；另外就是在类型信息丢失时我们可能需要用到这个特性，我们稍后会举一个这方面的例子。
 
 Swift 使用了自己的 Metatype 来处理类型，并且在运行时保留了这些类型的信息，所以 Swift 并没有必要保留这个关键字。我们现在不能获取任意类型的类型编码了，但是在 Cocoa 中我们还是可以通过 NSValue 的 objcType 属性来获取对应值的类型指针
 
 class NSValue : NSObject, NSCopying, NSSecureCoding, NSCoding {
     //...
     var objCType: UnsafePointer<Int8> { get }

     //...
 }

 比如我们如果想要获取某个 Swift 类型的 “等效的” 类型编码的话，我们需要现将它转换为 NSNumber (NSNumber 是 NSValue 的子类)，然后获取类型
 */

import UIKit

let int: Int = 0
let float: Float = 0.0
let double: Double = 0.0

let intNumber: NSNumber = int as NSNumber
let floatNumber: NSNumber = float as NSNumber
let doubleNumber: NSNumber = double as NSNumber

print(String(validatingUTF8: intNumber.objCType))
print(String(validatingUTF8: floatNumber.objCType))
print(String(validatingUTF8: doubleNumber.objCType))
/*
 Optional("q")
 Optional("f")
 Optional("d")
 */


/*
 对于像其他一些可以转换为 NSValue 的类型，我们也可以通过同样的方式获取类型编码，一般来说这些类型会是某些 struct，因为 NSValue 设计的初衷就是被作为那些不能直接放入 NSArray 的值的容器来使用的
 */
let p = NSValue(cgPoint: CGPoint(x: 3, y: 3))
print(String(validatingUTF8: p.objCType))
// Optional("{CGPoint=dd}")
let t = NSValue(cgAffineTransform: .identity)
print(String(validatingUTF8: t.objCType))
// Optional("{CGAffineTransform=dddddd}")


/*
 举例来说，我们如果想要在 NSUserDefaults 中存储一些不同类型的数字，然后读取时需要准确地还原为之前的类型的话，最容易想到的应该是使用类簇来获取这些数字转为 NSNumber 后真正的类型，然后存储。但是 NSNumber 的类簇子类都是私有的，我们如果想要藉此判定的话，就不得不使用私有 API，这是不可接受的。变通的方法就是在存储时使用 objCType 获取类型，然后将数字本身和类型的字符串一起存储。在读取时就可以通过匹配类型字符串和类型的编码，确定数字本来所属的类型，从而直接得到像 Int 或者 Double 这样的类型明确的量。
 */
