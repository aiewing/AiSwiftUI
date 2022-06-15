



/*
 Swift 中没有宏定义了。
 
 宏定义确实是一个让人又爱又恨的特性，合理利用的话，可以让我们写出很多简洁漂亮的代码，但是同时，不可否认的是宏定义无法受益于 IDE 工具，难以重构和维护，很可能隐藏很多 bug，这对于开发其实并不是一件好事。
 
 Swift 中将宏定义彻底从语言中拿掉了，并且 Apple 给了我们一些替代的建议：

 使用合适作用范围的 let 或者 get 属性来替代原来的宏定义值，例如很多 Darwin 中的 C 的 define 值就是这么做的：

 var M_PI: Double { get } /* pi */

 对于宏定义的方法，类似地在同样作用域写为 Swift 方法。一个最典型的例子是 NSLocalizedString 的转变：

 // objc
 #define NSLocalizedString(key, comment) \
 [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
 */

import UIKit
import Foundation
// Swift
func NSLocalizedString(_ key: String,
    tableName: String? = default,
    bundle: NSBundle = default,
    value: String = default,
    comment: String) -> String {
        print(tableName)
        print(bundle)
        print(value)
    }

NSLocalizedString("", "123")


/*
 随着 #define 的消失，像 #ifdef 这样通过宏定义是否存在来进行条件判断并决定某些代码是否参与编译的方式也消失了。但是我们仍然可以使用 #if 并配合编译的配置来完成条件编译，具体的方法可以参看条件编译一节的内容。
 
 define 在编译时实际做的事情类似查找替换，因此往往可以用来做一些很强大的事情，比如只替换掉某部分内容。
 
 虽然这只是一个没什么实际用处的例子，但是这展现了我们完全改变代码表现结构的可能性。在自动代码生成或者统一配置修改时有的情况下会很好用。而现在暂时在 Swift 中无法对应这样的用法，所以在 Swift 中可能短期内我们可能很难看到类似 Kiwi 这样的严重依赖宏定义来改变语法结构的有趣的项目了。
 */
