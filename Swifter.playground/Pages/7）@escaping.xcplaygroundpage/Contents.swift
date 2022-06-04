/*
 关于 @escaping 最后还有一点想要说明。如果你在协议或者父类中定义了一个接受 @escaping 为参数方法，那么在实现协议和类型或者是这个父类的子类中，对应的方法也必须被声明为 @escaping，否则两个方法会被认为拥有不同的函数签名
 */

// 测试结果是可以编译通过的
protocol Person {
    func work(block: @escaping () -> ())
}

class Car: Person {
    func work(block: () -> ()) {
        block()
    }
}

let c = Car()
c.work {
    print("c.work")
}
