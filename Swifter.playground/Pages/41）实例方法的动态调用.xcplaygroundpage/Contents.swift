



/*
 可以让我们不直接使用实例来调用这个实例上的方法，而是通过类型取出这个类型的某个实例方法的签名，然后再通过传递实例来拿到实际需要调用的方法。
 */
class MyClass {
    func method(number: Int) -> Int {
        return number + 1
    }
}

let foo = MyClass.method
let object = MyClass()
let result = foo(object)(1)
print(result)

/*
 这种语法看起来会比较奇怪，但是实际上并不复杂。Swift 中可以直接用 Type.instanceMethod 的语法来生成一个可以柯里化的方法。如果我们观察 f 的类型 (Alt + 单击)，可以知道它是
 
 foo: MyClass -> (Int) -> Int
 */

let f = {(obj: MyClass) -> (Int) -> Int in
    return obj.method
}

print(f(object)(1))
