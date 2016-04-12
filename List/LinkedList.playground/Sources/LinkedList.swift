
public class LinkedListNode<T> {
    public var value: T
    public var next: LinkedListNode?
    public var prev: LinkedListNode?
    
    public init(value: T){
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var firstNode: Node? {
        return head
    }
    
    public var lastNode: Node? {
        if var node = head {
            while case let next? = node.next {
                node = next
            }
            return node
        }else {
            return nil
        }
    }
    
    public var count: Int {
        if var node = head {
            var num = 1
            while case let next? = node.next {
                node = next
                num += 1
            }
            return num
        }else {
            return 0
        }
    }
    
    public func nodeAtIndex(index: Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 {
                    return node
                }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    public subscript(index: Int) -> T {
        let node = nodeAtIndex(index)
        assert(node != nil)
        return node!.value
    }
    
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = lastNode {
            newNode.prev = lastNode
            lastNode.next = newNode
        }else {
            head = newNode
        }
    }
    
    private func nodesBeforeAndAfter(index: Int) -> (Node?, Node?) {
        assert(index >= 0)
        
        var i = index
        var next = head
        var prev: Node?
        
        while next != nil && i > 0{
            i -= 1
            prev = next
            next = next!.next
        }
        assert(i == 0)
        
        return (prev, next)
    }
    
    public func insert(value: T, atIndex index: Int) {
        let (prev, next) = nodesBeforeAndAfter(index)
        
        let newNode = Node(value: value)
        newNode.next = next
        newNode.prev = prev
        prev?.next = newNode
        next?.prev = newNode
        
        if prev == nil {
            head = newNode
        }
    }
    
    public func removeAll() {
        head = nil
    }
    
    public func removeNode(node: Node) -> T {
        let prev = node.prev
        let next = node.next
        
        if let prev = node.prev {
            prev.next = next
        }else {
            head = next
        }
        next?.prev = prev
        
        node.next = nil
        node.prev = nil
        
        return node.value
    }
    
    public func removeLast() -> T {
        assert(!isEmpty)
        return removeNode(lastNode!)
    }
    
    public func removeAtIndex(index: Int) -> T {
        let node = nodeAtIndex(index)
        assert(node != nil)
        return removeNode(node!)
    }
    
    public init() {
        
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil {
                s += ", "
            }
        }
        return s + "]"
    }
}


