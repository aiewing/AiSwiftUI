


/*

 */

import UIKit

let workingQueue = DispatchQueue(label: "my_queue")

workingQueue.async {
    print("努力工作")
    Thread.sleep(forTimeInterval: 2)

    DispatchQueue.main.async {
        print("结束工作，更新UI")
    }
}

/*
 “在日常的开发工作中，我们经常会遇到这样的需求：在 xx 秒后执行某个方法。比如切换界面 2 秒后开始播一段动画，或者提示框出现 3 秒后自动消失等等。以前在 Objective-C 中，我们可以使用一个 NSObject 的实例方法，-performSelector:withObject:afterDelay: 来指定在若干时间后执行某个 selector。

 在 Swift 2 之前，如果你新建一个 Swift 的项目，并且试图使用这个方法 (或者这个方法的其他一切变形) 的话，会发现这个方法并不存在。在 Swift 2 中虽然这一系列 performSelector 的方法被加回了标准库，但是由于 Swift 中创建一个 selector 并不是一件安全的事情 (你需要通过字符串来创建，这在之后代码改动时会很危险)，所以最好尽可能的话避免使用这个方法。

 另外，原来的 performSelector: 这套东西在 ARC 下并不是安全的。ARC 为了确保参数在方法运行期间的存在，在无法准确确定参数内存情况的时候，会将输入参数在方法开始时先进行 retain，然后在最后 release。而对于 performSelector: 这个方法我们并没有机会为被调用的方法指定参数，于是被调用的 selector 的输入有可能会是指向未知的垃圾内存地址，然后...HOHO，要命的是这种崩溃还不能每次重现，想调试？见鬼去吧.

 但是如果不论如何，我们都还想继续做延时调用的话应该怎么办呢？最容易想到的是使用 Timer 来创建一个若干秒后调用一次的计时器。但是这么做我们需要创建新的对象，和一个本来并不相干的 Timer 类扯上关系，同时也会用到 Objective-C 的运行时特性去查找方法等等，总觉着有点笨重。其实 GCD 里有一个很好用的延时调用我们可以加以利用写出很漂亮的方法来，那就是 asyncAfter。
 */

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
    print("2秒后输出")
}

/*
 在 iOS 8 中 GCD 得到了惊人的进化，现在我们可以通过将一个闭包封装到 DispatchWorkItem 对象中，然后对其发送 cancel，来取消一个正在等待执行的 block。取消一个任务这样的特性，这在以前是 NSOperation 的专利，但是现在我们使用 GCD 也能达到同样的目的了。这里我们不使用这个方式，而是通过捕获一个 cancel 标识变量来实现 delay call 的取消，整个封装也许有点长，但我还是推荐一读。大家也可以把它当作练习材料检验一下自己的 Swift 基础语法的掌握和理解的情况
 */

import Foundation

typealias Task = (_ cancel: Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping () -> ()) -> Task? {
    func dispatchLater(block: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: block)
    }

    var closure: (() -> Void)? = task
    var result: Task?

    let delayedClosure: Task = { cancal in
        if let internalClosure = closure {
            if !cancal {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }

    result = delayedClosure

    dispatchLater {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }

    return result
}

func cancel(_ task: Task?) {
    task?(true)
}

print("--开始--")
let task = delay(2) {
    print("2秒后输入")
}

cancel(task)
