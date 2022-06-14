


/*
 iOS 开发中有很多使用字符串来指定某个资源的用法，比如通过项目中图片的名字来生成 UIImage 对象：

 let image = UIImage(name: "my_image")
 或者通过 segue 的标识符来调用一个 storyboard 中的 segue：

 performSegueWithIdentifier("my_segue", sender: self)
 在 Cocoa 框架中还有不少类似的用字符串来指定资源的使用方式。这类方法其实是存在隐患的，如果资源的名称发生了改变的话，你必须在代码中作出相应的改变。但是这些操作并没有编译器的保证，虽然现在我们可以在项目中进行全局查找来进行字符串的更新替换，但是这增添了我们的代码维护的压力。在一些极端情况下，如果你在项目中用了像是字符串拼接的方式来获取资源名字的话，就非常容易出现由于代码中的资源名字没有更新而使得运行时出现错误的问题。

 在 Objective-C 时代，我们一般通过宏定义来缓解这个问题。通过将资源名字设置为宏定义，这样就可以在相对集中的地方来管理和修改它们。但是这并没有从本质上解决资源名字改变给我们带来的困扰。在 Swift 中是没有宏定义的，取而代之，我们可以灵活地使用 rawValue 为 String 的 enum 类型来字符串，然后通过为资源类型添加合适的 extension 来让编译器帮助我们在资源名称修改时能在代码中作为对应的改变。
 */

import UIKit

enum ImageName: String {
    case myImage = "my_image"
}

enum SegueName: String {
    case mySegue = "my_segue"
}

extension UIImage {
    convenience init!(imageName: ImageName) {
        self.init(named: imageName.rawValue)
    }
}

extension UIViewController {
    func performSegue(withName segueName: SegueName, sender: Any?) {
        performSegue(withIdentifier: segueName.rawValue, sender: sender)
    }
}

let image = UIImage(imageName: .myImage)
performSegue(withName: .mySegue, sender: self)

/*
 但仅仅这样其实还是没有彻底解决名称变更带来的问题。不过在 Swift 中，根据项目内容来自动化生成像是 ImageName 和 SegueName 这样的类型并不是一件难事。Swift 社区中现在也有一些比较成熟的自动化工具了，R.swift 和 SwiftGen 就是其中的佼佼者。它们通过扫描我们的项目文件，来提取出对应的字符串，然后自动生成对应的 enum 或者 struct 文件。当我们之后添加，删除或者改变资源名称的时候，这些工具可以为我们重新生成对应的代表资源名字的类型，从而让我们可以利用编译器的检查来确保代码中所有对该资源的引用都保持正确。这在需要协作的项目中会是非常可靠和值得提倡的做法。
 */
