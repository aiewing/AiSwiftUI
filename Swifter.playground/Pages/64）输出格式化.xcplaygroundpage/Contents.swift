
import UIKit



/*
 C 系语言在字符串格式化输出上，需要通过类似 %d，%f 或者在 Objective-C 中的 %@ 这样的格式在指定的位置设定占位符，然后通过参数的方式将实际要输出的内容补充完整。例如 Objective-C 中常用的向控制台输出的 NSLog 方法就使用了这种格式化方法
 
 int a = 3;
 float b = 1.234567;
 NSString *c = @"Hello";
 NSLog(@"int:%d float:%f string:%@",a,b,c);
 // 输出：
 // int:3 float:1.234567 string:Hello
 
 在 Swift 里，我们在输出时一般使用的 print 中是支持字符串插值的，而字符串插值时将直接使用类型的 Streamable，Printable 或者 DebugPrintable 协议 (按照先后次序，前面的没有实现的话则使用后面的) 中的方法返回的字符串并进行打印。这样，我们就可以不借助于占位符，也不用再去记忆类型所对应的字符表示，就能很简单地输出各种类型的字符串描述了。比如上面的代码在 Swift 中可以等效写为
 */

let a = 3;
let b = 1.234567  // 我们在这里不去区分 float 和 Double 了
let c = "Hello"
print("int:\(a) double:\(b) string:\(c)")
// int:3 double:1.234567 string:Hello

/*
 不需要记忆麻烦的类型指代字符是很赞的事情，这大概也算摆脱了 C 留下的一个包袱吧。但是类 C 的这种字符串格式化也并非一无是处，在需要以一定格式输出的时候传统的方式就显得很有用，比如我们打算只输出上面的 b 中的小数点后两位的话，在 Objective-C 中使用 NSLog 时可以写成下面这样
 
 NSLog(@"float:%.2f",b);
 // 输出： float:1.23
 
 而到了 Swift 的 print 中，就没有这么幸运了，这个方法并不支持在字符串插值时使用像小数点限定这样的格式化方法。因此，我们可能不得不往回求助于使用类似原来那样的字符串格式化方法。String 的格式化初始方法可以帮助我们利用格式化的字符串
 */

let format = String(format:"%.2f",b)
print("double:\(format)")
// 输出： double:1.23

/*
 当然，每次这么写的话也很麻烦。如果我们需要大量使用类似的字符串格式化功能的话，我们最好为 Double 写一个扩展
 */

extension Double {
    func format(_ f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

// 这样，在使用字符串插值和 print 的时候就能方便一些了：
print("double: \(b.format(".2"))")
