

/*
 一般对于递归，解决栈溢出的一个好方法是采用尾递归的写法。顾名思义，尾递归就是让函数里的最后一个动作是一个函数调用的形式，这个调用的返回值将直接被当前函数返回，从而避免在栈上保存状态。这样一来程序就可以更新最后的栈帧，而不是新建一个，来避免栈溢出的发生。在 Swift 2.0 中，编译器现在支持嵌套方法的递归调用了 (Swift 1.x 中如果你尝试递归调用一个嵌套函数的话会出现编译错误)，因此 sum 函数的尾递归版本可以写为
 */

import UIKit

func tailSum(_ n: UInt) -> UInt {
    func sumInternal(_ n: UInt, current: UInt) -> UInt {
        if n == 0 {
            return current
        } else {
            return sumInternal(n - 1, current: current + n)
        }
    }
    return sumInternal(n, current: 0)
}

print(tailSum(4))

/*
 但是如果你在项目中直接尝试运行这段代码的话还是会报错，因为在 Debug 模式下 Swift 编译器并不会对尾递归进行优化。我们可以在 scheme 设置中将 Run 的配置从 Debug 改为 Release，这段代码就能正正确运行了。
 */
