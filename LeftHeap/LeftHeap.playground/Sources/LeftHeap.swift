/*
 LeftHeap - min
 */

public class HeapNode<T: Comparable> {
    var value: T
    var left: HeapNode?
    var right: HeapNode?
    var npl: Int
    
    public init(value: T) {
        self.value = value
        npl = 0
    }
}

public class LeftHeap<T: Comparable> {
    var root: HeapNode<T>?
    
    public init() {}
    
    public convenience init(array: [T]) {
        self.init()
        for value in array {
            insert(value)
        }
    }
    
    func swapChildren(node: HeapNode<T>) {
        let right = node.right
        node.right = node.left
        node.left = right
    }
    
    func merge(node: HeapNode<T>, intoNode root: HeapNode<T>) -> HeapNode<T> {
        guard let left = root.left else {
            root.left = node
            return root
        }
        root.right = merge(root.right, withNode: node)
        if left.npl < root.right!.npl {
            swapChildren(root)
        }
        root.npl = root.right!.npl + 1
        return root
    }

    func merge(node: HeapNode<T>?, withNode: HeapNode<T>?) -> HeapNode<T>? {
        guard let node1 = node else { return withNode }
        guard let node2 = withNode else { return node }
        if node1.value < node2.value {
            return merge(node2, intoNode: node1)
        }else{
            return merge(node1, intoNode: node2)
        }
    }
    
    public func insert(value: T) {
        let node = HeapNode<T>.init(value: value)
        root = merge(root, withNode: node)
    }
    
    public func mergeWithHeap(heap: LeftHeap<T>?) {
        guard let heap = heap else { return }
        root = merge(root, withNode: heap.root)
    }
    
    public func deleteMin() {
        root = merge(root?.left, withNode: root?.right)
    }
}

//MARK: - Debug
extension HeapNode: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description))<- "
        }
        s += "\(value)"
        if let right = right {
            s += " ->(\(right.description))"
        }
        return s
    }
}

extension LeftHeap: CustomStringConvertible {
    public var description: String {
        guard let root = root else { return "nil" }
        return root.description
    }
}