


/*
 Swift 的闭包写法很多，但是最正规的应该是完整地将闭包的输入和输出都写上，然后用 in 关键字隔离参数和实现。比如我们想实现一个 Int 的 extension，使其可以执行闭包若干次，并同时将次数传递到闭包中：
 */

extension Int {
    func times(f: (Int) -> ()) {
        print("Int")
        for i in 1...self {
            f(i)
        }
    }
}

3.times { i in
    print(i)
}

// 输出：
// Int
// 1
// 2
// 3
