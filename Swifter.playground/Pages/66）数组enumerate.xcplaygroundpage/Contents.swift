

/*
 使用 NSArray 时一个很常遇见的的需求是在枚举数组内元素的同时也想使用对应的下标索引，在 Objective-C 中最方便的方式是使用 NSArray 的 enumerateObjectsUsingBlock: 方法。因为通过这个方法可以显式地同时得到元素和下标索引，这会有最好的可读性，并且 block 也意味着可以方便地在不同的类之间传递和复用这些代码。
 
 比如我们想要对某个数组内的前三个数字进行累加 (请原谅我，因为这只是为这一节内容生造出来的例子，实际情况下我们就算有这样的需求可能也不太会这么处理)：
 
 NSArray *arr = @[@1, @2, @3, @4, @5];
 __block NSInteger result = 0;
 [arr enumerateObjectsUsingBlock:^(NSNumber *num, NSUInteger idx, BOOL *stop) {
     result += [num integerValue];
     if (idx == 2) {
         *stop = YES;
     }
 }];

 NSLog(@"%ld", result);
 // 输出：6”

 这里我们需要用到 *stop 这个停止标记的指针，并且直接设置它对应的值为 YES 来打断并跳出循环。而在 Swift 中，这个 API 的 *stop 被转换为了对应的 UnsafeMutablePointer<ObjCBool>。如果不明白 Swift 的指针的表示形式的话，一开始可能会被吓一跳，但是一旦当我们明白 Unsafe 开头的这些指针类型的用法之后，就会知道我们需要对应做的事情就是将这个指向 ObjCBool 的指针指向的内存的内容设置为 true 而已
 */

import UIKit

let arr: NSArray = [1,2,3,4,5]
var result: Int = 0
arr.enumerateObjects { (num, idx, stop) -> Void in
    result += num as! Int
    if idx == 2 {
        stop.pointee = true
    }
}
print(result)


/*
 虽然说使用 enumerateObjectsUsingBlock: 非常方便，但是其实从性能上来说这个方法并不理想 (这里有一篇四年前的星期五问答阐述了这个问题，而且一直以来情况都没什么变化)。另外这个方法要求作用在 NSArray 上，这显然已经不符合 Swift 的编码方式了。在 Swift 中，我们在遇到这样的需求的时候，有一个效率，安全性和可读性都很好的替代，那就是快速枚举某个数组的 EnumerateGenerator，它的元素是同时包含了元素下标索引以及元素本身的多元组
 */

let intArr = [1,2,3,4,5]
result = 0
for (idx, num) in intArr.enumerated() {
    result += num
    if idx == 2 {
        break
    }
}
print(result)
