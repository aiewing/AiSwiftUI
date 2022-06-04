
// 因为 Optional Chaining 是随时都可能提前返回 nil 的，所以使用 Optional Chaining 所得到的东西其实都是 Optional 的

class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}

extension Toy {
    func play() {
        
    }
}

// 最后返回的是一个可选值
let playClosure = { (child: Child) -> ()? in
    child.pet?.toy?.play()
}

let xiaoming = Child()
if let result = playClosure(xiaoming) {
    print("好开心！")
} else {
    print("没有玩具可以玩")
}
