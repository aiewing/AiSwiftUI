


struct Meat {
    
}

struct Grass {
    
}

protocol Animal {
    associatedtype F
    func eat(_ food: F)
}

struct Tiger: Animal {
    typealias F = Meat
    func eat(_ food: Meat) {
        print("eat \(food)")
    }
}

struct Sheep: Animal {
    typealias F = Grass
    func eat(_ food: Grass) {
        print("eat \(food)")
    }
}

//func isDangerous(animal: Animal) -> Bool {
//    if animal is Tiger {
//        return true
//    } else {
//        return false
//    }
//}

/*
 编译器会告诉我们：
 protocol 'Animal' can only be used as a generic constraint because it has Self or associated type requirements

 这是因为 Swift 需要在编译时确定所有类型，这里因为 Animal 包含了一个不确定的类型，所以随着 Animal 本身类型的变化，其中的 F 将无法确定 (试想一下如果在这个函数内部调用 eat 的情形，你将无法指定 eat 参数的类型)。在一个协议加入了像是 associatedtype 或者 Self 的约束后，它将只能被用为泛型约束，而不能作为独立类型的占位使用，也失去了动态派发的特性。也就是说，这种情况下，我们需要将函数改写为泛型
 */

func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tiger {
        return true
    } else {
        return false
    }
}

let tiger = Tiger()
tiger.eat(Meat())

if isDangerous(animal: tiger) {
    print("tiger is dangerous")
} else {
    print("tiger is not dangerous")
}

let sheep = Sheep()
sheep.eat(Grass())
