



/*
 @selector 是 Objective-C 时代的一个关键字，它可以将一个方法转换并赋值给一个 SEL 类型，它的表现很类似一个动态的函数指针。在 Objective-C 时 selector 非常常用，从设定 target-action，到自举询问是否响应某个方法，再到指定接受通知时需要调用的方法等等，都是由 selector 来负责的
 */

/*
 -(void) callMe {
     //...
 }

 -(void) callMeWithParam:(id)obj {
     //...
 }

 SEL someMethod = @selector(callMe);
 SEL anotherMethod = @selector(callMeWithParam:);

 // 或者也可以使用 NSSelectorFromString
 // SEL someMethod = NSSelectorFromString(@"callMe");
 // SEL anotherMethod = NSSelectorFromString(@"callMeWithParam:");
 */

/*
 在 Swift 中没有 @selector 了，取而代之，从 Swift 2.2 开始我们使用 #selector 来从暴露给 Objective-C 的代码中获取一个 selector。类似地，在 Swift 里对应原来 SEL 的类型是一个叫做 Selector 的结构体。
 */


@objc func callMe() {
    //...
}
@objc func callMeWithParam(obj: AnyObject!) {
    //...
}
@objc func turn(by angle: Int, speed: Float) {
    //...
}

let someMethod = #selector(callMe)
let anotherMethod = #selector(callMeWithParam(obj:))
let method = #selector(turn(by:speed:))

/*
 最后需要注意的是，selector 其实是 Objective-C runtime 的概念。在 Swift 4 中，默认情况下所有的 Swift 方法在 Objective-C 中都是不可见的，所以你需要在这类方法前面加上 @objc 关键字，将这个方法暴露给 Objective-C，才能进行使用。
 */
