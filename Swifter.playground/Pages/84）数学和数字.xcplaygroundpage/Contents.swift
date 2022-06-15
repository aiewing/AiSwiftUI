


/*
 Darwin 里的 math.h 定义了很多和数学相关的内容，它在 Swift 中也被进行了 module 映射，因此在 Swift 中我们是可以直接使用的。有了这个保证，我们就不需要担心在进行数学计算的时候会和标准有什么差距。比如，我们可以轻易地使用圆周率来计算周长，也可以使用各种三角函数来完成需要的屏幕位置计算等等
 */

import UIKit
import Darwin

func circlePerimeter(radius: Double) -> Double {
    return 2 * M_PI * radius
}

func yPosition(dy: Double, angle: Double) -> Double {
   return dy * tan(angle)
}

/*
 Swift 除了导入了 math.h 的内容以外，也在标准库中对极限情况的数字做了一些约定，比如我们可以使用 Int.max 和 Int.min 来取得对应平台的 Int 的最大和最小值。另外在 Double 中，我们还有两个很特殊的值，infinity 和 NaN。
 
 infinity 代表无穷，它是类似 1.0 / 0.0 这样的数学表达式的结果，代表数学意义上的无限大。在这里我们强调了数学意义，是因为受限于计算机系统，其实是没有真正意义的无穷大的，毕竟这是我们讨论的平台。一个 64 位的系统中，Swift 的 Double 能代表的最大的数字大约是 1.797693134862315e+308，而超过这个数字的 Double 虽然在数学意义上并不是无穷大，但是也会在判断的时候被认为是无穷
 */

1.797693134862315e+308 < Double.infinity  // true
1.797693134862316e+308 < Double.infinity  // false


/*
 另一个有趣的东西是 NaN，它是 “Not a Number” 的简写，可以用来表示某些未被定义的或者出现了错误的运算，比如下面的操作都会产生 NaN
 
 let a = 0.0 / 0.0
 let b = sqrt(-1.0)
 let c = 0.0 * Double.infinity
 
 与 NaN 再进行的运算结果也都将是 NaN。Swift 的 Double 中也为我们提供了直接获取一个 NaN 的方法，我们可以通过使用 Double.NaN 来直接获取一个 NaN。在某些边界条件下，我们可能会希望判断一个数值是不是 NaN。和其他数字 (包括无穷大) 相比，NaN 在这点上非常特殊。你不能将 NaN 用来做相等判断或者大小比较，因为它本身就不是数字，因此这类比较就没有意义了。比如对于一个理论上的恒等式 num == num，在 NaN 的情况下就有所不同
 */

let num = Double.nan
if num == num {
    print("Num is \(num)")
} else {
    print("NaN")
}
// 输出  NaN

/*
 用判定自身是否与自己相等的方式就可以判定一个量是不是 NaN 了。当然，一个更加容易读懂和简洁的方式使用 Double 的 isNaN 来判断：
 */

if num.isNaN {
    print("NaN")
}
// 输出  NaN
