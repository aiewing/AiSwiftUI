
/*
 相对于普通的 Optional 值，在 Swift 中我们还有一种特殊的 Optional，在对它的成员或者方法进行访问时，编译器会帮助我们自动进行解包，这就是 ImplicitlyUnwrappedOptional。在声明的时候，我们可以通过在类型后加上一个感叹号 (!) 这个语法糖来告诉编译器我们需要一个可以隐式解包的 Optional 值
 
 为什么一向以安全著称的 Swift 中会存在隐式解包并可以写出让人误认为能直接访问的这种危险写法呢？
 
 一切都是历史的错。因为 Objective-C 中 Cocoa 的所有类型变量都可以指向 nil 的，有一部分 Cocoa 的 API 中在参数或者返回时即使被声明为具体的类型，但是还是有可能在某些特定情况下是 nil，而同时也有另一部分 API 永远不会接收或者返回 nil。在 Objective-C 时，这两种情况并没有被加以区别，因为 Objective-C 里向 nil 发送消息并不会有什么不良影响。在将 Cocoa API 从 Objective-C 转为 Swift 的 module 声明的自动化工具里，是无法判定是否存在 nil 的可能的，因此也无法决定哪些类型应该是实际的类型，而哪些类型应该声明为 Optional。
 

 在这种自动化转换中，最简单粗暴的应对方式是全部转为 Optional，然后让使用者通过 Optional Binding 来判断并使用。虽然这是最安全的方式，但对使用者来说是一件非常麻烦的事情，我猜不会有人喜欢每次用个 API 就在 Optional 和普通类型之间转来转去。
 
 这时候，隐式解包的 Optional 就作为一个妥协方案出现了。使用隐式解包 Optional 的最大好处是对于那些我们能确认的 API 来说，我们可直接进行属性访问和方法调用，会很方便。但是需要牢记在心的是，隐式解包不意味着 “这个变量不会是 nil，你可以放心使用” 这种暗示，只能说 Swift 通过这个特性给了我们一种简便但是危险的使用方式罢了。

 另外，其实在 Apple 的不断修改 (我相信这是一件消耗大量人月的手工工作) 下，在 Swift 的正式版本中，已经没有太多的隐式解包的 API 了。最近 Objective-C 中又加入了像是 nonnull 和 nullable 这样的修饰符，这样一来，那些真正有可能为 nil 的返回可以被明确定义为普通的 Optional 值，而那些不会是 Optional 的值，也根据情况转换为了确定的类型。现在比较常见的隐式解包的 Optional 就只有使用 Interface Builder 时建立的 IBOutlet 了：
 
 @IBOutlet weak var button: UIButton!

 如果没有连接 IB 的话，对 button 的直接访问会导致应用崩溃，这种情况和错误在调试应用时是很容易被发现的问题。在我们的代码的其他部分，还是少用这样的隐式解包的 Optional 为好，很多时候多写一个 Optional Binding 就可以规避掉不少应用崩溃的风险。
 */
