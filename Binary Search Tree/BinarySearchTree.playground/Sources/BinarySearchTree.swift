/*
 二叉查找树
 */

public class BinarySearchTree<T: Comparable> {

    private(set) public var value: T?
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    public var height: Int {
        if isLeaf {
            return 0
        }else {
            return 1 + max(left?.height ?? 0, right?.height ?? 0)
        }
    }
    
    public var depth: Int {
        var node = self
        var edges = 0
        while case let parent? = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    public init(value: T) {
        self.value = value
    }
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for value in array.dropFirst() {
            insert(value)
        }
    }
    
    // MARK: - Insert
    public func insert(value: T) {
        insert(value, parent: self)
    }
    
    private func insert(value: T, parent: BinarySearchTree) {
        if value < self.value {
            if let left = left {
                left.insert(value)
            }else {
                left = BinarySearchTree.init(value: value)
                left?.parent = self
            }
        }else {
            if let right = right {
                right.insert(value)
            }else {
                right = BinarySearchTree.init(value: value)
                right?.parent = self
            }
        }
    }
    
    // MARK: - Delete
    public func remove(value: T) -> BinarySearchTree? {
        if value < self.value {
            left = left?.remove(value)
        }else if value > self.value {
            right = right?.remove(value)
        }else if left != nil && right != nil {
            let replacement = right!.minimum()
            self.value = replacement.value
            self.right = right?.remove(replacement.value!)
        }else {
            if let left = left {
                replaceWithNode(left)
            }else if let right = right {
                replaceWithNode(right)
            }else {
                if isLeftChild {
                    parent?.left = nil
                }else {
                    parent?.right = nil
                }
                self.value = nil
                return nil
            }
        }
        
        return self
    }
    
    // MARK: - Search
    public func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value)
        }else if value > self.value {
            return right?.search(value)
        }else {
            return self
        }
    }
    
    public func contains(value: T) -> Bool {
        return search(value) != nil
    }
    
    public func minimum() -> BinarySearchTree {
        var node = self
        while case let next? = node.left {
            node = next
        }
        return node
    }
    
    public func maximum() -> BinarySearchTree {
        var node = self
        while case let next? = node.right {
            node = next
        }
        return node
    }
    
    // MARK: - Traversal
    public func traverseInOrder() -> Array<T> {
        var array = [T]()
        if let a = left?.traverseInOrder() {
            array.appendContentsOf(a)
        }
        if let value = value {
            array.append(value)
        }
        if let a = right?.traverseInOrder() {
            array.appendContentsOf(a)
        }
        return array
    }
    
    public func traversePreOrder() -> Array<T> {
        var array = [T]()
        if let value = value {
            array.append(value)
        }
        if let a = left?.traversePreOrder() {
            array.appendContentsOf(a)
        }
        if let a = right?.traversePreOrder() {
            array.appendContentsOf(a)
        }
        return array
    }
    
    public func traversePosOrder() -> Array<T> {
        var array = [T]()
        if let a = left?.traversePosOrder() {
            array.appendContentsOf(a)
        }
        if let a = right?.traversePosOrder() {
            array.appendContentsOf(a)
        }
        if let value = value {
            array.append(value)
        }
        return array
    }
}

// MARK: - Helper
extension BinarySearchTree {
    private var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    private var isLeftChild: Bool {
        return parent?.left === self
    }
    
    private func replaceWithNode(node: BinarySearchTree) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            }else {
                parent.right = node
            }
            node.parent = parent
        }
        self.value = node.value
        self.left = node.left
        self.right = node.right
    }
}

// MARK: - Output
extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        if let value = value {
            s += "\(value)"
        }
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}
