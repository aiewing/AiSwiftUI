


/*
 Objective-C 一个一直以来令人诟病的地方就是没有命名空间，在应用开发时，所有的代码和引用的静态库最终都会被编译到同一个域和二进制中。这样的后果是一旦我们有重复的类名的话，就会导致编译时的冲突和失败。为了避免这种事情的发生，Objective-C 的类型一般都会加上两到三个字母的前缀，比如 Apple 保留的 NS 和 UI 前缀，各个系统框架的前缀 SK (StoreKit)，CG (CoreGraphic) 等。Objective-C 社区的大部分开发者也遵守了这个约定，一般都会将自己名字缩写作为前缀，把类库命名为 AFNetworking 或者 MBProgressHUD 这样。这种做法可以解决部分问题，至少我们在直接引用不同人的库时冲突的概率大大降低了，但是前缀并不意味着不会冲突，有时候我们确实还是会遇到即使使用前缀也仍然相同的情况。另外一种情况是可能你想使用的两个不同的库，分别在它们里面引用了另一个相同的很流行的第三方库，而又没有更改名字。在你分别使用这两个库中的一个时是没有问题的，但是一旦你将这两个库同时加到你的项目中的话，这个大家共用的第三方库就会和自己发生冲突了。
 
 在 Swift 中，由于可以使用命名空间了，即使是名字相同的类型，只要是来自不同的命名空间的话，都是可以和平共处的。和 C# 这样的显式在文件中指定命名空间的做法不同，Swift 的命名空间是基于 module 而不是在代码中显式地指明，每个 module 代表了 Swift 中的一个命名空间。也就是说，同一个 target 里的类型名称还是不能相同的。在我们进行 app 开发时，默认添加到 app 的主 target 的内容都是处于同一个命名空间中的，我们可以通过创建 Cocoa (Touch) Framework 的 target 的方法来新建一个 module，这样我们就可以在两个不同的 target 中添加同样名字的类型了
 */

// MyFramework.swift
// 这个文件存在于 MyFramework.framework 中
//public class MyClass {
//    public class func hello() {
//        print("hello from framework")
//    }
//}

// MyApp.swift
// 这个文件存在于 app 的主 target 中
//class MyClass {
//    class func hello() {
//        print("hello from app")
//    }
//}

// 在使用时，如果出现可能冲突的时候，我们需要在类型名称前面加上 module 的名字 (也就是 target 的名字)：
// MyClass.hello()
// MyFramework.MyClass.hello()


/*
 另一种策略是使用类型嵌套的方法来指定访问的范围。常见做法是将名字重复的类型定义到不同的 struct 中，以此避免冲突。这样在不使用多个 module 的情况下也能取得隔离同样名字的类型的效果
 */

struct MyClassContainer1 {
    class MyClass {
        class func hello() {
            print("hello from MyClassContainer1")
        }
    }
}

struct MyClassContainer2 {
    class MyClass {
        class func hello() {
            print("hello from MyClassContainer2")
        }
    }
}

MyClassContainer1.MyClass.hello()
MyClassContainer2.MyClass.hello()

/*
 其实不管哪种方式都和传统意义上的命名空间有所不同，把它叫做命名空间，更多的是一种概念上的宣传。不过在实际使用中只要遵守这套规则的话，还是能避免很多不必要的麻烦的，至少唾手可得的是我们不再需要给类名加上各种奇怪的前缀了。
 */
