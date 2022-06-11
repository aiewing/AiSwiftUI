




/*
 
 */

// 可以判等的类型的判断
let password = "aie"
switch password {
case "aie":
    print("密码通过")
default:
    print("密码错误")
}

// 对 Optional 的判断
let num: Int? = nil
switch num {
case nil:
    print("没值")
default:
    print("\(num)")
}

// 对范围的判断
let x = 0.5
switch x {
case -1.0...1.0:
    print("区间内")
default:
    print("区间外")
}
