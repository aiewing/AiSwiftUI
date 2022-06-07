
/*
 我们需要自己实现一个字面量表达的时候，可以简单地只实现定义的 init 方法就行了
 */
enum MyBool: Int {
    case myTrue
    case myFalse
}

extension MyBool: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: Bool) {
        self = value ? .myTrue : .myFalse
    }
}

let myTrue: MyBool = true
let myFalse: MyBool = false

print(myTrue.rawValue)
print(myFalse.rawValue)

/*
 可以通过 String 来生成 Person
 */
class Person: ExpressibleByStringLiteral {
    var name: String
    init(name value: String) {
        self.name = value
    }
    
    /*
     在所有的协议定义的 init 前面我们都加上了 required 关键字，这是由初始化方法的完备性需求所决定的，这个类的子类都需要保证能够做类似的字面量表达，以确保类型安全。
     */
    required convenience init(stringLiteral value: String) {
        self.name = value
    }

    required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.name = value
    }

    required convenience init(unicodeScalarLiteral value: String) {
        self.name = value
    }
}

let p: Person = "xiaoming"
print(p.name)

/*
 总结一下，字面量表达是一个很强大的特性，使用得当的话对缩短代码和清晰表意都很有帮助；但是这同时又是一个比较隐蔽的特性：因为你的代码并没有显式的赋值或者初始化，所以可能会给人造成迷惑：比如上面例子中为什么一个字符串能被赋值为 Person？你的同事在阅读代码的时候可能不得不去寻找这些负责字面量表达的代码进行查看 (而如果代码库很大的话，这不是一件容易的事情，因为你没有办法对字面量赋值进行 Cmd + 单击跳转)。
 和其他 Swift 的新鲜特性一样，我们究竟如何使用字面量表达，它的最佳实践到底是什么，都还是在研究及讨论中的。因此在使用这样的新特性时，必须力求表意清晰，没有误解，代码才能经受得住历史考验。
 */
