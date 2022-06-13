


/*
 在 C 系语言中，程序的入口都是 main 函数。对于一个 Objective-C 的 iOS app 项目，在新建项目时， Xcode 将帮我们准备好一个 main.m 文件，其中就有这个 main 函数：
 int main(int argc, char * argv[])
 {
     @autoreleasepool {
         return UIApplicationMain(argc, argv, nil,
                    NSStringFromClass([AppDelegate class]));
     }
 }
 
 在这里我们调用了 UIKit 的 UIApplicationMain 方法。这个方法将根据第三个参数初始化一个 UIApplication 或其子类的对象并开始接收事件 (在这个例子中传入 nil，意味使用默认的 UIApplication)。最后一个参数指定了 AppDelegate 类作为应用的委托，它被用来接收类似 didFinishLaunching 或者 didEnterBackground 这样的与应用生命周期相关的委托方法。另外，虽然这个方法标明为返回一个 int，但是其实它并不会真正返回。它会一直存在于内存中，直到用户或者系统将其强制终止。
 
 了解了这些后，我们就可以来看看 Swift 的项目中对应的情况了。新建一个 Swift 的 iOS app 项目后，我们会发现所有文件中都没有一个像 Objective-C 时那样的 main 文件，也不存在 main 函数。唯一和 main 有关系的是在默认的 AppDelegate 类的声明上方有一个 @UIApplicationMain 的标签。
 不说可能您也已经猜到，这个标签做的事情就是将被标注的类作为委托，去创建一个 UIApplication 并启动整个程序。在编译的时候，编译器将寻找这个标记的类，并自动插入像 main 函数这样的模板代码。我们可以试试看把 @UIApplicationMain 去掉会怎么样：

 Undefined symbols _main

 说明找不到 main 函数了。
 
 在一般情况下，我们并不需要对这个标签做任何修改，但是当我们如果想要使用 UIApplication 的子类而不是它本身的话，我们就需要对这部分内容 “做点手脚” 了。
 刚才说到，其实 Swift 的 app 也是需要 main 函数的，只不过默认情况下是 @UIApplicationMain 帮助我们自动生成了而已。和 C 系语言的 main.c 或者 main.m 文件一样，Swift 项目也可以有一个名为 main.swift 特殊的文件。在这个文件中，我们不需要定义作用域，而可以直接书写代码。这个文件中的代码将作为 main 函数来执行。比如我们在删除 @UIApplicationMain 后，在项目中添加一个 main.swift 文件，然后加上这样的代码：
 
 UIApplicationMain(Process.argc, Process.unsafeArgv, nil,
     NSStringFromClass(AppDelegate))

 现在编译运行，就不会再出现错误了。当然，我们还可以通过将第三个参数替换成自己的 UIApplication 子类，这样我们就可以轻易地做一些控制整个应用行为的事情了。比如将 main.swift 的内容换成：
 
 import UIKit

 class MyApplication: UIApplication {
     override func sendEvent(event: UIEvent!) {
         super.sendEvent(event)
         print("Event sent: \(event)");
     }
 }

 UIApplicationMain(Process.argc, Process.unsafeArgv,
     NSStringFromClass(MyApplication), NSStringFromClass(AppDelegate))

 这样每次发送事件 (比如点击按钮) 时，我们都可以监听到这个事件了。”

 */
