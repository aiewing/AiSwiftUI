

/*
 
 
 
 */
protocol MyProtocol {
    func foo()
}

extension MyProtocol {
    func foo() {
        print("foo in MyProtocol")
    }
}

struct MyStruct: MyProtocol {
    
}
MyStruct().foo()

class MyClass: MyProtocol {
    func foo() {
        print("foo in MyClass")
    }
}
MyClass().foo()

/*
 protocol extension 为 protocol 中定义的方法提供了一个默认的实现。有了这个特性以后，之前被放在全局环境中的接受 CollectionType 的 map 方法，就可以被移动到 CollectionType 的协议扩展中去了
 */

protocol A1 {
    func method1()
}

extension A1 {
    func method1() {
        print("Hi")
    }
    func method2() {
        print("Hi")
    }
}

struct B1: A1 {
    func method1() {
        print("Hello")
    }
    func method2() {
        print("Hello")
    }
}

let b1 = B1()
b1.method1() // Hello
b1.method2() // Hello

let a1: A1 = B1()
a1.method1() // Hello
a1.method2() // Hi

/*
 对于 method1，因为它在 protocol 中被定义了，因此对于一个被声明为遵守协议的类型的实例 (也就是对于 a1) 来说，可以确定实例必然实现了 method1，我们可以放心大胆地用动态派发的方式使用最终的实现 (不论它是在类型中的具体实现，还是在协议扩展中的默认实现)；
 
 但是对于 method2 来说，我们只是在协议扩展中进行了定义，没有任何规定说它必须在最终的类型中被实现。在使用时，因为 a1 只是一个符合 A1 协议的实例，编译器对 method2 唯一能确定的只是在协议扩展中有一个默认实现，因此在调用时，无法确定安全，也就不会去进行动态派发，而是转而编译期间就确定的默认实现。”
 */


/*
 如果类型推断得到的是实际的类型
    那么类型中的实现将被调用；如果类型中没有实现的话，那么协议扩展中的默认实现将被使用

 如果类型推断得到的是协议，而不是实际类型
    并且方法在协议中进行了定义，那么类型中的实现将被调用；如果类型中没有实现，那么协议扩展中的默认实现被使用
 
    否则 (也就是方法没有在协议中定义)，扩展中的默认实现将被调用
 */
