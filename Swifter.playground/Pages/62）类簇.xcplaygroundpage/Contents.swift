



/*
 虽然可能不太被重视，但类簇 (class cluster) 确实是 Cocoa 框架中广泛使用的设计模式之一。简单来说类簇就是使用一个统一的公共的类来订制单一的接口，然后在表面之下对应若干个私有类进行实现的方式。这么做最大的好处是避免的公开很多子类造成混乱，一个最典型的例子是 NSNumber：我们有一系列的不同的方法可以从整数，浮点数或者是布尔值来生成一个 NSNumber 对象，而实际上它们可能会是不同的私有子类对象
 
 NSNumber * num1 = [[NSNumber alloc] initWithInt:1];
 // __NSCFNumber

 NSNumber * num2 = [[NSNumber alloc] initWithFloat:1.0];
 // __NSCFNumber

 NSNumber * num3 = [[NSNumber alloc] initWithBool:YES];
 // __NSCFBoolean”

 在 Objective-C 中，init 开头的初始化方法虽然打着初始化的名号，但是实际做的事情和其他方法并没有太多不同之处。类簇在 Objective-C 中实现起来也很自然，在所谓的“初始化方法”中将 self 进行替换，根据调用的方式或者输入的类型，返回合适的私有子类对象就可以了。
 
 但是 Swift 中的情况有所不同。因为 Swift 拥有真正的初始化方法，在初始化的时候我们只能得到当前类的实例，并且要完成所有的配置。也就是说对于一个公共类来说，是不可能在初始化方法中返回其子类的信息的。对于 Swift 中的类簇构建，一种有效的方法是使用工厂方法来进行。
 
 例如下面的代码通过 Drinking 的工厂方法将可乐和啤酒两个私有类进行了类簇化
 */
import UIKit

class Drinking {
    typealias LiquidColor = UIColor
    var color: LiquidColor {
        return .clear
    }

    class func drinking(name: String) -> Drinking {
        var drinking: Drinking
        switch name {
        case "Coke":
            drinking = Coke()
        case "Beer":
            drinking = Beer()
        default:
            drinking = Drinking()
        }

        return drinking
    }
}

class Coke: Drinking {
    override var color: LiquidColor {
        return .black
    }
}

class Beer: Drinking {
    override var color: LiquidColor {
        return .yellow
    }
}

let coke = Drinking.drinking(name: "Coke")
let beer = Drinking.drinking(name: "Beer")

let cokeClass = NSStringFromClass(type(of: coke)) //Coke
let beerClass = NSStringFromClass(type(of: beer)) //Beer
print(cokeClass) // Yellow
print(beerClass) // Yellow
