



/*
 Swift 中我们虽然可以通过 dynamicType 来获取一个对象的动态类型 (也就是运行时的实际类型，而非代码指定或编译器看到的类型)。但是在使用中，Swift 现在却是不支持多方法的，也就是说，不能根据对象在动态时的类型进行合适的重载方法调用。
 */

class Pet {}
class Cat: Pet {}
class Dog: Pet {}
func printPet(_ pet: Pet) { print("Pet") }
func printPet(_ cat: Cat) { print("Meow") }
func printPet(_ dog: Dog) { print("Bark") }

printPet(Cat()) // Meow
printPet(Dog()) // Bark
printPet(Pet()) // Pet

/*
 对于 Cat 或者 Dog 的实例，总是会寻找最合适的方法，而不会去调用一个通用的父类 Pet 的方法
 */


func printThem(_ pet: Pet, _ cat: Cat) {
    printPet(pet)
    printPet(cat)
}
printThem(Dog(), Cat())

// 输出：
// Pet
// Meow

/*
 打印时的 Dog() 的类型信息并没有被用来在运行时选择合适的 printPet(dog: Dog) 版本的方法，而是被忽略掉，并采用了编译期间决定的 Pet 版本的方法。因为 Swift 默认情况下是不采用动态派发的，因此方法的调用只能在编译时决定。
 */


// 要想绕过这个限制，我们可能需要进行通过对输入类型做判断和转换

func printThere(_ pet: Pet, _ cat: Cat) {
    if let aCat = pet as? Cat {
        printPet(aCat)
    } else if let aDog = pet as? Dog {
        printPet(aDog)
    }
    printPet(cat)
}
printThere(Dog(), Cat())
// 输出：
// Bark
// Meow
