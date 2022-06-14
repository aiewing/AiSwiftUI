


/*
 arc4random 是一个非常优秀的随机数算法，并且在 Swift 中也可以使用。它会返回给我们一个任意整数，我们想要在某个范围里的数的话，可以做模运算 (%) 取余数就行了。但是有个陷阱..

 这是错误代码

 let diceFaceCount = 6
 let randomRoll = Int(arc4random()) % diceFaceCount + 1
 print(randomRoll)

 其实 Swift 的 Int 是和 CPU 架构有关的：在 32 位的 CPU 上 （也就是 iPhone 5 和前任们），实际上它是 Int32，而在 64 位 CPU (iPhone 5s 及以后的机型) 上是Int64。arc4random 所返回的值不论在什么平台上都是一个 UInt32，于是在 32 位的平台上就有一半几率在进行 Int 转换时越界，时不时的崩溃也就不足为奇了。

 这种情况下，一种相对安全的做法是使用一个 arc4random 的改良版本：

 func arc4random_uniform(_: UInt32) -> UInt32

 这个改良版本接受一个 UInt32 的数字 n 作为输入，将结果归一化到 0 到 n - 1 之间。只要我们的输入不超过 Int 的范围，就可以避免危险的转换：

 let diceFaceCount: UInt32 = 6
 let randomRoll = Int(arc4random_uniform(diceFaceCount)) + 1
 print(randomRoll)

 最佳实践当然是为创建一个 Range 的随机数的方法，这样我们就能在之后很容易地复用，甚至设计类似与 Randomable 这样的协议了：
 */

import UIKit

func random(in range: Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return Int(arc4random_uniform(count)) + range.startIndex
}

for _ in 0...10 {
    let range = Range<Int>(1...6)
    print(random(in: range))
}
