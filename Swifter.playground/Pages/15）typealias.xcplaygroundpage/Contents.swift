
import UIKit



/*
 typealias 是用来为已经存在的类型重新定义名字的，通过命名，可以使代码变得更加清晰。使用的语法也很简单，使用 typealias 关键字像使用普通的赋值语句一样，可以将某个已经存在的类型赋值为新的名字。
 */

typealias Location = CGPoint
typealias Distance = Double

func distance(from loaction: Location, to anotherLocation: Location) -> Distance {
    let dx = Distance(loaction.x - anotherLocation.x)
    let dy = Distance(loaction.y - anotherLocation.y)
    return sqrt(dx * dx + dy * dy)
}

let origin = Location(x: 0, y: 0)
let point = Location(x: 1, y: 1)
let d = distance(from: origin, to: point)
print(d)


// 泛型
class Person<T> {}
typealias Worker1 = Person
typealias Worker2 = Person<Int>
// 错误示范
//typealias Worker = Person<T>


/*
 另一个使用场景是某个类型同时实现多个协议的组合时。我们可以使用 & 符号连接几个协议，然后给它们一个新的更符合上下文的名字，来增强代码可读性
 */

protocol Cat {}
protocol Dog {}
typealias Pat = Cat & Dog
