

import UIKit

/*
 既然像 String 这样的 Swift 的类型和 Foundation 的对应的类是可以无缝转换的，那么我们在使用和选择的时候，有没有什么需要特别注意的呢？
 简单来说，没有特别需要注意的，但是尽可能的话还是使用原生的 String 类型。
 
 原因有三。
 
 首先虽然 String 和 NSString 有着良好的互相转换的特性，但是现在 Cocoa 所有的 API 都接受和返回 String 类型。我们没有必要也不必给自己凭空添加麻烦去把框架中返回的字符串做一遍转换，既然 Cocoa 鼓励使用 String，并且为我们提供了足够的操作 String 的方法，那为什么不直接使用呢？
 
 其次，因为在 Swift 中 String 是 struct，相比起 NSObject 的 NSString 类来说，更切合字符串的 "不变" 这一特性。通过配合常量赋值 (let) ，这种不变性在多线程编程时就非常重要了，它从原理上将程序员从内存访问和操作顺序的担忧中解放出来。另外，在不触及 NSString 特有操作和动态特性的时候，使用 String 的方法，在性能上也会有所提升。

 最后，因为 String 实现了 Collection 这样的协议，因此有些 Swift 的语法特性只有 String 才能使用，而 NSString 是没有的。一个典型就是 for...in 的枚举
 */
let levels = "ABCJFFA"
for i in levels {
    print(i)
}

/*
 “不过也有例外的情况。有一些 NSString 的方法在 String 中并没有实现，一个很有用的就是在 iOS 8 中新加的 contains。我们想使用这个 API 来简单地确定某个字符串包括一个子字符串时，只能先将其转为 NSString
 */

if (levels as NSString).contains("BC") {
    print("包含字符串")
}


/*
“Swift 的 String 没有 contains 是一件很奇怪的事情，理论上应该不存在实现的难度，希望只是 Apple 一时忘了这个新加的 API 吧。当然你也可以自行用扩展的方式在自己的代码库为 String 添加这个方法。当然，还有一些其他的像 length 和 characterAtIndex: 这样的 API 也没有 String 的版本，这主要是因为 String 和 NSString 在处理编码上的差异导致的。
 
 Swift 3 中 Apple 已经为 String 添加了 contains 方法。现在我们可以直接写 levels.contains("BC") 这样的代码了。
 */

/*
 使用 String 唯一一个比较麻烦的地方在于它和 Range 的配合。在 NSString 中，我们在匹配字符串的时候通常使用 NSRange 来表征结果或者作为输入。而在使用 String 的对应的 API 时，NSRange 也会被映射成它在 Swift 中且对应 String 的特殊版本：Range<String.Index>。
 */
