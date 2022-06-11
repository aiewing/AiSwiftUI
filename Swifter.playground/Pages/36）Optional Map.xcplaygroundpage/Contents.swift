




/*
 现在假设我们有个需求，要将某个 Int? 乘 2。一个合理的策略是如果这个 Int? 有值的话，就取出值进行乘 2 的操作，如果是 nil 的话就直接将 nil 赋给结果。依照这个策略，我们可以写出如下代码
 */
let num: Int? = 3

var result: Int?
if let realNum = num {
    result = realNum * 2
} else {
    result = nil
}

/*
 其实我们有更优雅简洁的方式，那就是使用 Optional 的 map。对的，不仅在 Array 或者说 CollectionType 里可以用 map，如果我们仔细看过 Optional 的声明的话，会发现它也有一个 map 方法
 
 public enum Optional<T> :
     _Reflectable, NilLiteralConvertible {

     //...

     /// If `self == nil`, returns `nil`.  Otherwise, returns `f(self!)`.
     public func map<U>(@noescape f: (T) -> U) -> U?

     //...
 }
 */

let resultNum = num.map {
    $0 * 2
}
print(resultNum)

let nilNum: Int? = nil
let resultNilNum = nilNum.map {
    $0 * 2
}
print(resultNilNum)


/*
 这个方法能让我们很方便地对一个 Optional 值做变化和操作，而不必进行手动的解包工作。输入会被自动用类似 Optinal Binding 的方式进行判断，如果有值，则进入 f 的闭包进行变换，并返回一个 U?；如果输入就是 nil 的话，则直接返回值为 nil 的 U?”
 */
