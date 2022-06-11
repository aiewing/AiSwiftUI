



/*
 
 */
protocol IntervalType {
    func clamp(interbalToClamp: Self) -> Self
}

/*
 比如上面这个 IntervalType 的协议定义了一个方法，接受实现该协议的自身的类型，并返回一个同样的类型。
 
 这么定义是因为协议其实本身是没有自己的上下文类型信息的，在声明协议的时候，我们并不知道最后究竟会是什么样的类型来实现这个协议，Swift 中也不能在协议中定义泛型进行限制。而在声明协议时，我们希望在协议中使用的类型就是实现这个协议本身的类型的话，就需要使用 Self 进行指代。
 
 但是在这种情况下，Self 不仅指代的是实现该协议的类型本身，也包括了这个类型的子类。从概念上来说，Self 十分简单，但是实际实现一个这样的方法却稍微要转个弯
 
 */

protocol Copyable {
    func copy() -> Self
}

class MyClass: Copyable {
    /*
     但是显然类型是有问题的，因为该方法要求返回一个抽象的、表示当前类型的 Self，但是我们却返回了它的真实类型 MyClass，这导致了无法编译。也许你会尝试把方法声明中的 Self 改为 MyClass，这样声明就和实际返回一致了，但是很快你会发现这样的话，实现的方法又和协议中的定义不一样了，依然不能编译。
     */
//    func copy() -> Self {
//        let result = MyClass()
//        return result
//    }
    
    /*
     为了解决这个问题，我们在这里需要的是通过一个和当前上下文 (也就是和 MyClass) 无关的，又能够指代当前类型的方式进行初始化。我们可以使用 type(of:) 来获取对象类型，通过它也可以进一步进行初始化，以保证方法与当前类型上下文无关，这样不论是 MyClass 还是它的子类，都可以正确地返回合适的类型满足 Self 的要求
     
     但是很不幸，单单是这样还是无法通过编译，编译器提示我们如果想要构建一个 Self 类型的对象的话，需要有 required 关键字修饰的初始化方法，这是因为 Swift 必须保证当前类和其子类都能响应这个 init 方法。
     */
//    func copy() -> Self {
//        let result = type(of: self).init()
//        return result
//    }
    
    
    /*
     另一个解决的方案是在当前类类的声明前添加 final 关键字，告诉编译器我们不再会有子类来继承这个类型。在这个例子中，我们选择添加上 required 的 init 方法。
     */
    func copy() -> Self {
        let result = type(of: self).init()
        return result
    }
    
    required init() {
        
    }
}
