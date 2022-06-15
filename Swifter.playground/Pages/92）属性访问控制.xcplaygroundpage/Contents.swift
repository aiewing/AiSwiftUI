

/*
 Swift 中由低至高提供了 private，fileprivate，internal，public 和 open 五种访问控制的权限。默认的 internal 在绝大部分时候是适用的，另外由于它是 Swift 中的默认的控制级，因此它也是最为方便的。
 
 private 让代码只能在当前作用域或者同一文件中同一类型的作用域中被使用，fileprivate 表示代码可以在当前文件中被访问，而不做类型限定。例如，以下代码是合法的：

 */

class Foo {
    private var privateBar = "privateBar"
    fileprivate var filePrivateBar = "filePrivateBar"
}

class Baz {
    func baz() {
        print(Foo().filePrivateBar)
    }
}

extension Foo {
    func fooExtension() {
        print(privateBar)
    }
}

Baz().baz()
Foo().fooExtension()


/*
 对于一个严格的项目来说，精确的最小化访问控制级别对于代码的维护来说还是相当重要的。我们想让同一 module (或者说是 target) 中的其他代码访问的话，保持默认的 internal 就可以了。如果我们在为其他开发者开发库的话，可能会希望用一些 public 甚至 open，因为在 target 外只能调用到 public 和 open 的代码。public 和 open 的区别在于，只有被 open 标记的内容才能在别的框架中被继承或者重写。因此，如果你只希望框架的用户使用某个类型和方法，而不希望他们继承或者重写的话，应该将其限定为 public 而非 open。
 
 以上是方法和类型的访问控制的情况。而对于属性来说，访问控制还多了一层需要注意的地方。在类型中的属性默认情况下：
 
 class MyClass {
     var name: String?
 }

 因为没有任何的修饰，所以我们可以在同一 module 中随意地读取或者设置这个变量。从类型外部读取一个实例成员变量是很普通的需求，而对其进行设定的话就需要小心一些了。当然实际我们在构建一个类时是会有需要设置的情况的，一般来说会是在这个类型外的地方，对这个类型对象的某些特性进行配置。
 
 对于那些我们只希望在当前文件中使用的属性来说，当然我们可以在声明前面加上 private 使其变为私有：
 
 class MyClass {
     private var name: String?
 }

 但是在开发中所面临的更多的情况是我们希望在类型之外也能够读取到这个类型，同时为了保证类型的封装和安全，只能在类型内部对其进行改变和设置。这时，我们可以通过下面的写法将读取和设置的控制权限分开
 
 class MyClass {
     private(set) var name: String?
 }

 因为 set 被限制为了 private，我们就可以保证 name 只会在当代码前作用域被更改。这为之后更改或者调试代码提供了很好的范围控制，可以让我们确定寻找问题所需要关心的范围。
 
 这种写法没有对读取做限制，相当于使用了默认的 internal 权限。如果我们希望在别的 module 中也能访问这个属性，同时又保持只在当前作用域可以设置的话，我们需要将 get 的访问权限提高为 public。属性的访问控制可以通过两次的访问权限指定来实现，具体来说，将刚才的声明变为：
 
 public class MyClass {
     public private(set) var name: String?
 }

 这时我们就可以在 module 之外也访问到 MyClass 的 name 了。

 我们在 MyClass 前面也添加的 public，这是编译器所要求的。因为如果只为 name 的 get 添加 public 而不管 MyClass 的话，module 外就连 MyClass 都访问不到了，属性的访问控制级别也就没有任何意义了。
 */
