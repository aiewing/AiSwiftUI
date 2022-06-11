



/*
 switch 语句中，我们可以使用 where 来限定某些条件 case
 */
let name = ["王小二", "张三", "李四", "王麻子"]
name.forEach {
    switch $0 {
    case let x where x.hasPrefix("王"):
        print("\($0) 信王")
    default:
        print("你好 \($0)")
    }
}

/*
 在 for 中我们也可以使用 where 来做类似的条件限定
 */

let num: [Int?] = [44, 99, nil]
let n = num.flatMap { $0 }
print(n)

for score in n where score > 60 {
    print("及格了： \(score)")
}

/*
 和 for 循环中类似，我们也可以对可选绑定进行条件限定。不过在 Swift 3 中，if let 和 guard let 的条件不再使用 where 语句，而是直接和普通的条件判断一样，用逗号写在 if 或者 guard 的后面
 */
num.forEach {
    if let score = $0, score > 60 {
        print("及格了： \(score)")
    }
}

/*
 这两种使用的方式都可以用额外的 if 来替代，这里只不过是让我们的代码更加易读了。
 
 也有一些场合是只有使用 where 才能准确表达的，比如我们在泛型中想要对方法的类型进行限定的时候。比如在标准库里对 RawRepresentable 协议定义 != 运算符定义时
 */

//public func !====<T:RawRepresentable where T.RawValue: Equatable>(lhs: T, rhs: T) -> Bool {
//    return lhs.rawValue != rhs.rawValue
//}

/*
 这里限定了 T.RawValue 必须要遵守 Equatable 协议，这样我们才能通过对比 lhs 和 rhs 的 rawValue 是否相等，进而判断这两个 RawRepresentable 值是否相等。如果没有 where 的保证的话，下面的代码就无法编译。同时，我们也限定了那些 RawValue 无法判等的 RawRepresentable 类型不能进行判等
 */

/*
 在有些时候，我们会希望一个协议扩展的默认实现只在某些特定的条件下适用，这时我们就可以用 where 关键字来进行限定。标准库中的协议扩展大量使用了这个技术来进行限定，比如 Sequence 的 sorted 方法就被定义在这样一个类型限制的协议扩展中：
 */

extension Sequence where Self.Iterator.Element: Comparable {
    public func sorted() -> [Self.Iterator.Element]
}
