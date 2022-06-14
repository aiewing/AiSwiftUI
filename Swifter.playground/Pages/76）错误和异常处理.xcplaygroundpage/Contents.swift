/*
 在开始这一节的内容之前，我想先阐明两个在很多时候被混淆的概念，那就是异常 (exception) 和错误 (error)。

 在 Objective-C 开发中，异常往往是由程序员的错误导致的 app 无法继续运行，比如我们向一个无法响应某个消息的 NSObject 对象发送了这个消息，会得到 NSInvalidArgumentException 的异常，并告诉我们 "unrecognized selector sent to instance"；比如我们使用一个超过数组元素数量的下标来试图访问 NSArray 的元素时，会得到 NSRangeException。类似由于这样所导致的程序无法运行的问题应该在开发阶段就被全部解决，而不应当出现在实际的产品中。相对来说，由 NSError 代表的错误更多地是指那些“合理的”，在用户使用 app 中可能遇到的情况：比如登陆时用户名密码验证不匹配，或者试图从某个文件中读取数据生成 NSData 对象时发生了问题 (比如文件被意外修改了) 等等。

 但是 NSError 的使用方式其实变相在鼓励开发者忽略错误。想一想在使用一个带有错误指针的 API 时我们做的事情吧。我们会在 API 调用中产生和传递 NSError，并藉此判断调用是否失败。作为某个可能产生错误的方法的使用者，我们用传入 NSErrorPointer 指针的方式来存储错误信息，然后在调用完毕后去读取内容，并确认是否发生了错误。比如在 Objective-C 中，我们会写类似这样的代码：

 NSError *error;
 BOOL success = [data writeToFile: path options: options error: &error];
 if(error) {
     // 发生了错误
 }

 这非常棒，但是有一个问题：在绝大多数情况下，这个方法并不会发生什么错误，而很多工程师也为了省事和简单，会将输入的 error 设为 nil，也就是不关心错误 (因为可能他们从没见过这个 API 返回错误，也不知要如何处理)。于是调用就变成了这样：

 [data writeToFile: path options: options error: nil];


 但是事实上这个 API 调用是会出错的，比如设备的磁盘空间满了的时候，写入将会失败。但是当这个错误出现并让你的 app 陷入难堪境地的时候，你几乎无从下手进行调试 -- 因为系统曾经尝试过通知你出现了错误，但是你却选择视而不见。

 在 Swift 2.0 中，Apple 为这门语言引入了异常机制。现在，这类带有 NSError 指针作为参数的 API 都被改为了可以抛出异常的形式。比如上面的 writeToFile:options:error:，在 Swift 中变成了：

 open func write(toFile path: String, options writeOptionsMask: NSData.WritingOptions) throws

 我们在使用这个 API 的时候，不再像之前那样传入一个 error 指针去等待方法填充，而是变为使用 try catch 语句：

 do {
     try d.write(toFile: "Hello", options: [])
 } catch let error as NSError {
     print ("Error: \(error.domain)")
 }

 如果你不使用 try 的话，是无法调用 write(toFile:options:) 方法的，它会产生一个编译错误，这让我们无法有意无意地忽视掉这些错误。在上面的示例中 catch 将抛出的异常 (这里就是个 NSError) 用 let 进行了类型转换，这其实主要是针对 Cocoa 现有的 API 的，是对历史的一种妥协。对于我们新写的可抛出异常的 API，我们应当抛出一个实现了 Err 协议的类型，enum 就非常合适，举个例子：


 */

import UIKit
import Foundation
import Darwin

enum LoginError: Error {
    case UserNotFound
    case UserPasswordNotMatch
}

func login(user: String, password: String) throws {
    if user.isEmpty {
        throw LoginError.UserNotFound
    }
    if password.isEmpty {
        throw LoginError.UserPasswordNotMatch
    }
    print("Login successfully.")
}

do {
    try login(user: "111", password: "111")
} catch LoginError.UserNotFound {
    print("UserNotFound")
} catch LoginError.UserPasswordNotMatch {
    print("UserPasswordNotMatch")
}


/*
 可以看出，在 Swift 中，我们虽然把这块内容叫做“异常”，但是实质上它更多的还是“错误”而非真正意义上的异常。

 另一个限制是对于非同步的 API 来说，抛出异常是不可用的 -- 异常只是一个同步方法专用的处理机制。Cocoa 框架里对于异步 API 出错时，保留了原来的 Error 机制，比如很常用的 URLSession 中的 dataTask API

 func dataTask(with: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void)”


 对于异步 API，虽然不能使用异常机制，但是因为这类 API 一般涉及到网络或者耗时操作，它所产生错误的可能性要高得多，所以开发者们其实无法忽视这样的错误。但是像上面这样的 API 其实我们在日常开发中往往并不会去直接使用，而会选择进行一些封装，以求更方便地调用和维护。一种现在比较常用的方式就是借助于 enum。作为 Swift 的一个重要特性，枚举 (enum) 类型现在是可以与其他的实例进行绑定的，我们还可以让方法返回枚举类型，然后在枚举中定义成功和错误的状态，并分别将合适的对象与枚举值进行关联
 */

enum Result {
    case Success(String)
    case Error(NSError)
}

func doSomethingParam(isSuccess: Bool) -> Result {
    if isSuccess {
        return .Success("成功了")
    } else {
        let error = NSError(domain: "失败了", code: -1)
        return .Error(error)
    }
}

let result = doSomethingParam(isSuccess: false)
switch result {
case let .Success(ok):
    print(ok)
case let .Error(error):
    print(error.domain)
}

/*
 Swift 2.0 中，我们甚至可以在 enum 中指定泛型，这样就使结果统一化了。

 enum Result<T> {
     case Success(T)
     case Failure(NSError)
 }
 */

/*
 关于 try 和 throws，想再多讲两个小点。

 首先，try 可以接 ! 表示强制执行，这代表你确定知道这次调用不会抛出异常。如果在调用中出现了异常的话，你的程序将会崩溃，这和我们在对 Optional 值用 ! 进行强制解包时的行为是一致的。

 另外，我们也可以在 try 后面加上 ? 来进行尝试性的运行。try? 会返回一个 Optional 值：如果运行成功，没有抛出错误的话，它会包含这条语句的返回值，否则将为 nil。和其他返回 Optional 的方法类似，一个典型的 try? 的应用场景是和 if let 这样的语句搭配使用，不过如果你用了 try? 的话，就意味着你无视了错误的具体类型

 值得一提的是，在一个可以 throw 的方法里，我们永远不应该返回一个 Optional 的值。因为结合 try? 使用的话，这个 Optional 的返回值将被再次包装一层 Optional，使用这种双重 Optional 的值非常容易产生错误，也十分让人迷惑

 含有 throws 的方法会抛出一个异常，也有细心读文档的朋友会发现，在 Swift 2.0 中还有一个类似的关键字：rethrows。其实 rethrows 和 throws 做的事情并没有太多不同，它们都是标记了一个方法应该抛出错误。

 但是 rethrows 一般用在参数中含有可以 throws 的方法的高阶函数中，来表示它既可以接受普通函数，也可以接受一个能 throw 的函数作为参数。也就是像是下面这样的方法，我们可以在外层用 rethrows 进行标注

 func methodThrows(num: Int) throws {
     if num < 0 {
         print("Throwing!")
         throw E.Negative
     }
     print("Executed!")
 }

 func methodRethrows(num: Int, f: Int throws -> ()) rethrows {
     try f(num)
 }

 do {
     try methodRethrows(num: 1, f: methodThrows)
 } catch _ {

 }


 其实在这种情况下，我们简单地把 rethrows 改为 throws，这段代码依然能正确运行。但是 throws 和 rethrows 还有有所区别的。简单理解的话你可以将 rethrows 看做是 throws 的“子类”，rethrows 的方法可以用来重载那些被标为 throws 的方法或者参数，或者用来满足被标为 throws 的协议，但是反过来不行。如果你拿不准要怎么使用的话，就先记住你在要 throws 另一个 throws 时，应该将前者改为 rethrows。这样在不失灵活性的同时保证了代码的可读性和准确性。标准库中很常用的 map，reduce 等函数式特点鲜明的函数都采用了 rethrows 的方式来拓展适用范围。
 */
