

/*
 可能你会有疑问，为什么这里要使用 autoclosure，直接接受 T 作为参数并返回不行么，为何要用 () -> T 这样的形式包装一遍，岂不是画蛇添足？其实这正是 autoclosure 的一个最值得称赞的地方。如果我们直接使用 T，那么就意味着在 ?? 操作符真正取值之前，我们就必须准备好一个默认值传入到这个方法中，一般来说这不会有很大问题，但是如果这个默认值是通过一系列复杂计算得到的话，可能会成为浪费 -- 因为其实如果 optional 不是 nil 的话，我们实际上是完全没有用到这个默认值，而会直接返回 optional 解包后的值的。这样的开销是完全可以避免的，方法就是将默认值的计算推迟到 optional 判定为 nil 之后。
 
 就这样，我们可以巧妙地绕过条件判断和强制转换，以很优雅的写法处理对 Optional 及默认值的取值了。最后要提一句的是，@autoclosure 并不支持带有输入参数的写法，也就是说只有形如 () -> T 的参数才能使用这个特性进行简化。另外因为调用者往往很容易忽视 @autoclosure 这个特性，所以在写接受 @autoclosure 的方法时还请特别小心，如果在容易产生歧义或者误解的时候，还是使用完整的闭包写法会比较好。

 */

//func ??<T>(optionalValue: T?, defaultValue: @autoclosure () -> T) -> T {
//    switch optionalValue {
//    case .Some(let value):
//        return value
//    case .None:
//        return defaultValue()
//    }
//}

func defaultValue() -> Int {
    print("print defaultValue")
    return 0
}

let a: Int? = 1
let b: Int? = nil
a ?? defaultValue()
b ?? defaultValue()
