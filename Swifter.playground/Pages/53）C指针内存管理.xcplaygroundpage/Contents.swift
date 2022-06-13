
import UIKit

/*
 C 指针在 Swift 中被冠名以 unsafe 的另一个原因是无法对其进行自动的内存管理。和 Unsafe 类的指针工作的时候，我们需要像 ARC 时代之前那样手动地来申请和释放内存，以保证程序不会出现泄露或是因为访问已释放内存而造成崩溃。
 
 我们如果想要声明，初始化，然后使用一个指针的话，完整的做法是使用 allocate 和 initialize 来创建。
 */
// 错误例子
class MyClass {
    var a = 1
    deinit {
        print("deinit")
    }
}
//var pointer: UnsafeMutablePointer<MyClass>!
//pointer = UnsafeMutablePointer<MyClass>.allocate(capacity: 1)
//pointer.initialize(to: MyClass())
//print(pointer.pointee.a)  // 1
//pointer = nil


/*
 虽然我们最后将 pointer 值为 nil，但是由于 UnsafeMutablePointer 并不会自动进行内存管理，因此其实 pointer 所指向的内存是没有被释放和回收的 (这可以从 MyClass 的 deinit 没有被调用来加以证实；这造成了内存泄露。正确的做法是为 pointer 加入 deinitialize 和 deallocate，它们分别会释放指针指向的内存的对象以及指针自己本身
 */

var pointer: UnsafeMutablePointer<MyClass>!

pointer = UnsafeMutablePointer<MyClass>.allocate(capacity: 1)
pointer.initialize(to: MyClass())

print(pointer.pointee.a)
//pointer.deinitialize()
//pointer.deallocate(capacity: 1)
pointer = nil


/*
 在手动处理这类指针的内存管理时，我们需要遵循的一个基本原则就是谁创建谁释放。deallocate 与 deinitialize 应该要和 allocate 与 initialize 成对出现，如果不是你创建的指针，那么一般来说你就不需要去释放它。一种最常见的例子就是如果我们是通过调用了某个方法得到的指针，那么除非文档或者负责这个方法的开发者明确告诉你应该由使用者进行释放，否则都不应该去试图管理它的内存状态
 
 虽然在本节的例子中使用的都是 allocate 和 deallocate 的情况，但是指针的内存申请也可以使用 malloc 或者 calloc 来完成，这种情况下在释放时我们需要对应使用 free 而不是 deallocate。
 */
