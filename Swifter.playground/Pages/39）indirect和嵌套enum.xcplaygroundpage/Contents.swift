import Foundation




/*
 链表的定义
 */

/*
 在 enum 的定义中嵌套自身对于 class 这样的引用类型来说没有任何问题，但是对于像 struct 或者 enum 这样的值类型来说，普通的做法是不可行的。我们需要在定义前面加上 indirect 来提示编译器不要直接在值类型中直接嵌套。用 enum 表达链表的好处在于，我们可以清晰地表示出空节点这一定义，这在像 Swift 这样类型十分严格的语言中是很有帮助的。比如我们可以寥寥数行就轻易地实现链表节点的删除方法，在 enum 中添加
 */

indirect enum LinkedList<Element: Comparable> {
    case empty
    case node(Element, LinkedList<Element>)
    
    func removing(_ element: Element) -> LinkedList<Element> {
        if case let .node(value, next) = self {
            if value == element {
                return next
            } else {
                return .node(value, next.removing(element))
            }
        } else {
            return .empty
        }
    }
}

let linkedList: LinkedList<Int> = LinkedList.node(1, .node(2, .node(3, .node(4, .empty))))
var node: LinkedList<Int> = linkedList
node = node.removing(2)

while case let .node(value, next) = node {
    print(value)
    node = next
}
