/*
 Swift 里可以将方法进行柯里化 (Currying)，这是也就是把接受多个参数的方法进行一些变形，使其更加灵活的方法。函数式的编程思想贯穿于 Swift 中，而函数的柯里化正是这门语言函数式特点的重要表现。
 */

import UIKit

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case touchUpInside
    case valueChanged
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func setTarget<T: AnyObject>(target: T, action: @escaping (T) -> () -> (), controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}

class MyViewController {
    let button = Control()
    
    func buttonSetTargetAction() {
        button.setTarget(target: self, action: MyViewController.onButtonTap, controlEvent: .touchUpInside)
    }
    
    func onButtonTap() {
        print("Button was tapped")
    }
}

let vc = MyViewController()
vc.buttonSetTargetAction()
vc.button.performActionForControlEvent(controlEvent: .touchUpInside)
