


/*
 Log 输出是程序开发中很重要的组成部分，虽然它并不是直接的业务代码，但是却可以忠实地反映我们的程序是如何工作的，以及记录程序运行的过程中发生了什么。
 
 在 Swift 中，最简单的输出方法就是使用 print，在我们关心的地方输出字符串和值。但是这并不够，试想一下当程序变得非常复杂的时候，我们可能会输出很多内容，而想在其中寻找到我们希望的输出其实并不容易。我们往往需要更好更精确的输出，这包括输出这个 log 的文件，调用的行号以及所处的方法名字等等。
 
 在 Swift 中，编译器为我们准备了几个很有用的编译符号，用来处理类似这样的需求，它们分别是：

 符号       类型    描述
 #file     String 包含这个符号的文件的路径
 #line     Int    符号出现处的行号
 #column   Int    符号出现处的列
 #function String 包含这个符号的方法名字

 因此，我们可以通过使用这些符号来写一个好一些的 Log 输出方法
 
 */
import UIKit

func printLog<T>(_ message: T,
                    file: String = #file,
                  method: String = #function,
                    line: Int = #line)
{
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
}

printLog("")


/*
 另外，对于 log 输出更多地其实是用在程序开发和调试的过程中的，过多的输出有可能对运行的性能造成影响。在 Release 版本中关闭掉向控制台的输出也是软件开发中一种常见的做法。如果我们在开发中就注意使用了统一的 log 输出的话，这就变得非常简单了。使用条件编译的方法，我们可以添加条件，并设置合适的编译配置，使 printLog 的内容在 Release 时被去掉，从而成为一个空方法：
 */

func printDebugLog<T>(_ message: T,
                    file: String = #file,
                  method: String = #function,
                    line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

/*
 新版本的 LLVM 编译器在遇到这个空方法时，甚至会直接将这个方法整个去掉，完全不去调用它，从而实现零成本。
 */
