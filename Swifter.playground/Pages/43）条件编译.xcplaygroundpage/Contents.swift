



/*
 在 C 系语言中，可以使用 #if 或者 #ifdef 之类的编译条件分支来控制哪些代码需要编译，而哪些代码不需要。Swift 中没有宏定义的概念，因此我们不能使用 #ifdef 的方法来检查某个符号是否经过宏定义。但是为了控制编译流程和内容，Swift 还是为我们提供了几种简单的机制来根据需求定制编译内容的。

 首先是 #if 这一套编译标记还是存在的，使用的语法也和原来没有区别

 #elseif 和 #else 是可选的
 */
//#if <condition>
//
//#elseif <condition>
//
//#else
//
//#endif

/*
 但是这几个表达式里的 condition 并不是任意的。Swift 内建了几种平台和架构的组合，来帮助我们为不同的平台编译不同的代码

 方法        可选参数
 os()       macOS, iOS, tvOS, watchOS, Linux
 arch()     x86_64, arm, arm64, i386
 swift()    >= 某个版本

 */

/*
 如果我们统一我们在 iOS 平台和 Mac 平台的关于颜色的 API 的话，一种可能的方法就是配合 typealias 进行条件编译：
 */

//#if os(macOS)
//    typealias Color = NSColor
//#else
//    typealias Color = UIColor
//#endif

/*
 另一种方式是对自定义的符号进行条件编译，比如我们需要使用同一个 target 完成同一个 app 的收费版和免费版两个版本，并且希望在点击某个按钮时收费版本执行功能，而免费版本弹出提示的话，可以使用类似下面的方法

 在这里我们用 FREE_VERSION 这个编译符号来代表免费版本。为了使之有效，我们需要在项目的编译选项中进行设置，在项目的 Build Settings 中，找到 Swift Compiler - Custom Flags，并在其中的 Other Swift Flags 加上 -D FREE_VERSION 就可以了。
 */
//#if FREE_VERSION
//    // 弹出购买提示
//#else
//    // 实际功能
//#endif
