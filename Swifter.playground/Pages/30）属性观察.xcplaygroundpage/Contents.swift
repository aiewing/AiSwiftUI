



/*
 属性观察 (Property Observers) 是 Swift 中一个很特殊的特性，利用属性观察我们可以在当前类型内监视对于属性的设定，并作出一些响应。Swift 中为我们提供了两个属性观察的方法，它们分别是 willSet 和 didSet。
 
 初始化方法对属性的设定，以及在 willSet 和 didSet 中对属性的再次设定都不会再次触发属性观察的调用，一般来说这会是你所需要的行为，可以放心使用能够。
 */

/*
 我们知道，在 Swift 中所声明的属性包括存储属性和计算属性两种。其中存储属性将会在内存中实际分配地址对属性进行存储，而计算属性则不包括背后的存储，只是提供 set 和 get 两种方法。在同一个类型中，属性观察和计算属性是不能同时共存的。也就是说，想在一个属性定义中同时出现 set 和 willSet 或 didSet 是一件办不到的事情。计算属性中我们可以通过改写 set 中的内容来达到和 willSet 及 didSet 同样的属性观察的目的。如果我们无法改动这个类，又想要通过属性观察做一些事情的话，可能就需要子类化这个类，并且重写它的属性了。重写的属性并不知道父类属性的具体实现情况，而只从父类属性中继承名字和类型，因此在子类的重载属性中我们是可以对父类的属性任意地添加属性观察的，而不用在意父类中到底是存储属性还是计算属性
 */


class A {
    var number :Int {
        get {
            print("get")
            return 1
        }

        set {print("set")}
    }
}

class B: A {
    override var number: Int {
        willSet {print("willSet \(newValue)")}
        didSet {print("didSet \(oldValue)")}
    }
}

let b = B()
b.number = 0

/*
 输出
 get
 willSet 0
 set
 didSet 1
 
 set 和对应的属性观察的调用都在我们的预想之中。这里要注意的是 get 首先被调用了一次。这是因为我们实现了 didSet，didSet 中会用到 oldValue，而这个值需要在整个 set 动作之前进行获取并存储待用，否则将无法确保正确性。如果我们不实现 didSet 的话，这次 get 操作也将不存在。
 */
