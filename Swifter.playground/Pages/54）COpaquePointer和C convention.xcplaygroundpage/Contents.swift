


/*
 在 C 中有一类指针，你在头文件中无法找到具体的定义，只能拿到类型的名字，而所有的实现细节都是隐藏的。这类指针在 C 或 C++ 中被叫做不透明指针 (Opaque Pointer)，顾名思义，它的实现和表意对使用者来说是不透明的。
 
 我们在这里不想过多讨论 C 中不透明指针的应用场景和特性，毕竟这是一本关于 Swift 的书。在 Swift 中对应这类不透明指针的类型是 COpaquePointer，它用来表示那些在 Swift 中无法进行类型描述的 C 指针。那些能够确定类型的指针所表示的是其指向的内存是可以用某个 Swift 中的类型来描述的，因此都使用更准确的 UnsafePointer<T> 来存储。而对于另外那些 Swift 无法表述的指针，就统一写为 COpaquePointer，以作补充。
 
 在 Swift 早期 beta 的时候，曾经有不少 API 返回或者接受的是 COpaquePointer 类型。但是随着 Swift 的逐渐完善，大部分涉及到指针的 API 里的 COpaquePointer 都被正确地归类到了合适的 Unsafe 指针中，因此现在在开发中可能很少能再看到 COpaquePointer 了。
 
 最多的使用场景可能就是 COpaquePointer 和某个特定的 Unsafe 之间的转换了，我们可以分别使用这两个类型的初始化方法将一个指针转换从某个类型强制地转为另一个类型

 public struct UnsafeMutablePointer<Memory> :
                         Equatable, Hashable ... {
     //..
     init(_ other: COpaquePointer)
     //..
 }

 public struct COpaquePointer:
                 Equatable,
                 Hashable,
                 NilLiteralConvertible {
     //..
     init<T>(_ source: UnsafePointer<T>)
     //..
 }

 COpaquePointer 在 Swift 中扮演的是指针转换的中间人的角色，我们可以通过这个类型在不同指针类型间进行转换。当然了，这些转换都是不安全的，除非你知道自己在干什么，以及有十足的把握，否则不要这么做！
 
 另外一种重要的指针形式是指向函数的指针，在 C 中这种情况也并不少见，即一块存储了某个函数实际所在的位置的内存空间。从 Swift 2.0 开始，与这类指针可以被转化为闭包，不过和其他普通闭包不同，我们需要为它添加上 @convention 标注。
 
 举个例子，如果我们在 C 中有这样一个函数：
 
 int cFunction(int (callback)(int x, int y)) {
     return callback(1, 2);
 }

 这个函数接受一个 callback，这个 callback 有两个 int 类型的参数，cFunction 本身返回这个 callback 的结果。如果我们想在 Swift 中使用这个 C 函数的话，应该这样写：
 
 let callback: @convention(c) (Int32, Int32) -> Int32 = {
     (x, y) -> Int32 in
     return x + y
 }

 let result = cFunction(callback)
 print(result)
 // 输出：
 // 3

 在没有歧义的情况下，我们甚至可以省掉这个标注，而直接将它以一个 Swift 闭包的形式传递给 C
 let result = cFunction {
     (x, y) -> Int32 in
     return x + y
 }
 print(result)
 // 输出：
 // 3

 完美，你甚至感觉不到自己是在和 C 打交道！
 
 */
