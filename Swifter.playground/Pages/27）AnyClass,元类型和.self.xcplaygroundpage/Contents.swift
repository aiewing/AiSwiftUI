


/*
 在 Swift 中能够表示 “任意” 这个概念的除了 Any 和 AnyObject 以外，还有一个 AnyClass。AnyClass 在 Swift 中被一个 typealias 所定义
 */

typealias AnyClass = AnyObject.Type

/*
 通过 AnyObject.Type 这种方式所得到是一个元类型 (Meta)。在声明时我们总是在类型的名称后面加上 .Type，比如 A.Type 代表的是 A 这个类型的类型。也就是说，我们可以声明一个元类型来存储 A 这个类型本身，而在从 A 中取出其类型时，我们需要使用到 .self
 */

class A {

}

let typeA: A.Type = A.self
print(typeA)

/*
 其实在 Swift 中，.self 可以用在类型后面取得类型本身，也可以用在某个实例后面取得这个实例本身。前一种方法可以用来获得一个表示该类型的值，这在某些时候会很有用；而后者因为拿到的实例本身，所以暂时似乎没有太多需要这么使用的案例。
 */

/*
 .Type 表示的是某个类型的元类型，而在 Swift 中，除了 class，struct 和 enum 这三个类型外，我们还可以定义 protocol。对于 protocol 来说，有时候我们也会想取得协议的元类型。这时我们可以在某个 protocol 的名字后面使用 .Protocol 来获取，使用的方法和 .Type 是类似的。
 */

protocol MyPro {
    
}
print(MyPro.self)
