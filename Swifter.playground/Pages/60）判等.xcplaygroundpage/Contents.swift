



/*
 我们在 Objective-C 时代，通常使用 -isEqualToString: 来在已经能确定比较对象和待比较对象都是 NSString 的时候进行字符串判等。Swift 中的 String 类型中是没有 -isEqualToString: 或者 -isEqual: 这样的方法的，因为这些毕竟是 NSObject 的东西。在 Swift 的字符串内容判等，我们简单地使用 == 操作符来进行
 */

let str1 = "快乐的字符串"
let str2 = "快乐的字符串"
let str3 = "开心的字符串"

str1 == str2  // true
str1 == str3  // false

/*
 在判等上 Swift 的行为和 Objective-C 有着巨大的差别。在 Objective-C 中 == 这个符号的意思是判断两个对象是否指向同一块内存地址。其实很多时候这并不是我们经常所期望的判等，我们更关心的往往还是对象的内容相同，而这种意义的相等即使两个对象引用的不是同一块内存地址时，也是可以做到的。Objective-C 中我们通常通过对 -isEqual: 进行重写，或者更进一步去实现类似 -isEqualToString: 这样的 -isEqualToClass: 的带有类型信息的方法来进行内容判等。如果我们没有在任意子类重写 -isEqual: 的话，在调用这个方法时会直接使用 NSObject 中的版本，去直接进行 Objective-C 的 == 判断。
 
 在 Swift 中情况大不一样，Swift 里的 == 是一个操作符的声明，在 Equatable 里声明了这个操作符的协议方法
 
 protocol Equatable {
     func ==(lhs: Self, rhs: Self) -> Bool
 }
 */

import UIKit

class TodoItem {
    let uuid: String
    let title: String
    init(uuid: String, title: String) {
        self.uuid = uuid
        self.title = title
    }
}

extension TodoItem: Equatable {
    
}

func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
    return lhs.uuid == rhs.uuid
}

let item1 = TodoItem(uuid: "123456", title: "fdsafdsfd")
let item2 = TodoItem(uuid: "123456", title: "ffdsfds")
print(item1 == item2) // true
print(item1 === item2) // false

/*
 对于 == 的实现我们并没有像实现其他一些协议一样将其放在对应的 extension 里，而是放在了全局的 scope 中。这是合理的做法，因为你应该需要在全局范围内都能使用 ==。事实上，Swift 的操作符都是全局的，关于操作符的更多信息，可以参看操作符一节。
 
 Swift 的基本类型都重载了自己对应版本的 ==，而对于 NSObject 的子类来说，如果我们使用 == 并且没有对于这个子类的重载的话，将转为调用这个类的 -isEqual: 方法。这样如果这个 NSObject 子类原来就实现了 -isEqual: 的话，直接使用 == 并不会造成它和 Swift 类型的行为差异；但是如果无法找到合适的重写的话，这个方法就将回滚到最初的 NSObject 里的实现，对引用对象地址进行直接比较。
 
 因此对于 NSObject 子类的判等你有两种选择，要么重载 ==，要么重写 -isEqual:。如果你只在 Swift 中使用你的类的话，两种方式是等效的；但是如果你还需要在 Objective-C 中使用这个类的话，因为 Objective-C 不接受操作符重载，只能使用 -isEqual:，这时你应该考虑使用第二种方式。
 
 对于原来 Objective-C 中使用 == 进行的对象指针的判定，在 Swift 中提供的是另一个操作符 ===。在 Swift 中 === 只有一种重载：
 func ===(lhs: AnyObject?, rhs: AnyObject?) -> Bool

 它用来判断两个 AnyObject 是否是同一个引用。
 
 对于判等，和它紧密相关的一个话题就是哈希，因为哈希是一个稍微复杂的话题，所以我将它分成了一个单节。但是如果在实际项目中你需要重载 == 或者重写 -isEqual: 来进行判等的话，很可能你也会想看看有关哈希的内容，重载了判等的话，我们还需要提供一个可靠的哈希算法使得判等的对象在字典中作为 key 时不会发生奇怪的事情。
 */


class MyClass: NSObject {
    let uuid: String
    let title: String
    init(uuid: String, title: String) {
        self.uuid = uuid
        self.title = title
    }
    
    static func ==(lhs: MyClass, rhs: MyClass) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

let class1 = MyClass(uuid: "123456", title: "fdsafdsfd")
let class2 = MyClass(uuid: "123456", title: "ffdsfds")
print(class1 == class2) // true
print(class1 === class2) // false
