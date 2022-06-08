


/*
 与 Objective-C 不同，Swift 的初始化方法需要保证类型的所有属性都被初始化。所以初始化方法的调用顺序就很有讲究。在某个类的子类中，初始化方法里语句的顺序并不是随意的，我们需要保证在当前子类实例的成员初始化完成后才能调用父类的初始化方法
 */

class Cat {
    var name: String
    init() {
        name = "cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
        super.init()
        name = "tiger"
    }
}

/*
 一般来说，子类的初始化顺序是：

 1. 设置子类自己需要初始化的参数，power = 10
 2. 调用父类的相应的初始化方法，super.init()
 3. 对父类中的需要改变的成员进行设定，name = "tiger”

 */

class Lion: Cat {
    let power: Int
    override init() {
        power = 9
    }
}
/*
 第 2 步的 super.init() 也是可以不用写的 (但是实际上还是调用的，只不过是为了简便 Swift 帮我们完成了)
 
 但是如果要调用 name = "tiger" ，就需要实现 super.init()
 */
