

func logIfTrue(_ predicate: () -> Bool) {
    if predicate() {
        print("True")
    }
}

logIfTrue { 2 > 1 }


func logIfTrue2(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("True")
    }
}

// 有了@autoclosure Swift 将会把 2 > 1 这个表达式自动转换为 () -> Bool。
logIfTrue2(2 > 1)
