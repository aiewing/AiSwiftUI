//
//  main.swift
//  SwifterTest
//
//  Created by Aiewing on 2022/6/13.
//

import Foundation

typealias Task = (_ cancel: Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping () -> ()) -> Task? {
    func dispatchLater(block: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: block)
    }

    var closure: (() -> Void)? = task
    var result: Task?

    let delayedClosure: Task = { cancal in
        if let internalClosure = closure {
            if !cancal {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }

    result = delayedClosure

    dispatchLater {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }

    return result
}

func cancel(_ task: Task?) {
    task?(true)
}

print("--开始--")
delay(2) {
    print("2秒后输入")
}

while true {

}
