


/*
 在一个数组内，我想取出 index 为 0, 2, 3 的元素的时候，现有的体系就会比较吃力。我们很可能会要去枚举数组，然后在循环里判断是否是我们想要的位置
 */

extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            for (index, i) in input.enumerated() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

var arr = [1, 2, 3, 4, 5]
print(arr[[1, 2, 3]])
arr[[0, 1, 2]] = [-1, -2 , -3]
print(arr[[0, 1, 2]])


/*
 虽然我们在这里实现了下标为数组的版本，但是我并不推荐使用这样的形式。如果阅读过参数列表一节的读者也许会想为什么在这里我们不使用看起来更优雅的参数列表的方式，也就是 subscript(input: Int...) 的形式。不论从易用性还是可读性上来说，参数列表的形式会更好。但是存在一个问题，那就是在只有一个输入参数的时候参数列表会导致和现有的定义冲突，有兴趣的读者不妨试试看。当然，我们完全可以使用至少两个参数的的参数列表形式来避免这个冲突，即定义形如 subscript(first: Int, second: Int, others: Int...) 的下标方法，我想这作为练习留给读者进行尝试会更好。
 */
