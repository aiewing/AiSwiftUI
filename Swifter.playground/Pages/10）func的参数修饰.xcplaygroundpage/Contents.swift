import UIKit

//func incrementor(varibale: Int) -> Int {
//    varibale += 1
//    return varibale
//}

/*
 编译错误。为什么在 Swift 里这样都不行呢？答案是因为 Swift 其实是一门讨厌变化的语言。所有有可能的地方，都被默认认为是不可变的，也就是用 let 进行声明的。这样不仅可以确保安全，也能在编译器的性能优化上更有作为。在方法的参数上也是如此，我们不写修饰符的话，默认情况下所有参数都是 let 的
 */

func incrementor(varibale: inout Int) -> Int {
    varibale += 1
    print(varibale)
    return varibale
}

var luckyNumber = 7
incrementor(varibale: &luckyNumber)
print(luckyNumber)

/*
 如果你对 Swift 的值类型和引用类型的区别有所了解的话，会知道 Int 其实是一个值类型，我们并不能直接修改它的地址来让它指向新的值。那么这里这种类似 C 中取地址的 & 符号到底做了额什么？对于值类型来说，inout 相当于在函数内部创建了一个新的值，然后在函数返回时将这个值赋给 & 修饰的变量，这与引用类型的行为是不同的。在关于值类型和引用类型一节中我们还会看到两者更多的区别。
 */


/*
 要注意的是参数的修饰是具有传递限制的，就是说对于跨越层级的调用，我们需要保证同一参数的修饰是统一的。举个例子，比如我们想扩展一下上面的方法，实现一个可以累加任意数字的 +N器
 
 外层的 makeIncrementor 的返回里也需要在参数的类型前面明确指出修饰词，以符合内部的定义，否则将无法编译通过。
 */
func makeIncrementor(addNumber: Int) -> ((inout Int) -> ()) {
    func incrementor(varibale: inout Int) -> () {
        varibale += addNumber
    }
    return incrementor
}

var number = 10
let afterumber = makeIncrementor(addNumber: 10)(&number)
print(number)
