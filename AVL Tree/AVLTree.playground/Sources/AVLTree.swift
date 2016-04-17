/*
 AVL树
 */
public class TreeNode<T: Comparable> {
    public var value: T
    public var height: Int
    private var left: TreeNode?
    private var right: TreeNode?
    private var parent: TreeNode?
    
    public init(value: T) {
        self.value = value
        self.height = 1
    }
}

public class AVLTree<T: Comparable> {
    public var root: TreeNode<T>?
    
    public init() {
        
    }
    
    public convenience init(array: Array<T>) {
        self.init()
        for value in array {
            insert(value)
        }
    }
}

// MARK: - Helper
extension TreeNode {
    private var isLeftChild: Bool {
        return parent?.left === self
    }
    
    private var isRightChild: Bool {
        return parent?.right === self
    }
    
    private var isBalance: Bool {
        return abs(leftChildHeight - rightChildHeight) < 2
    }
    
    private var leftChildHeight: Int {
        if let left = left {
            return left.height
        }else {
            return 0
        }
    }
    
    private var rightChildHeight: Int {
        if let right = right {
            return right.height
        }else {
            return 0
        }
    }
    
    private func resetHeight() {
        height = max(leftChildHeight, rightChildHeight) + 1
    }
}

//MARK: - Insert
extension AVLTree {
    public func insert(value: T) {
        if let root = root {
            insertAtNode(root, withValue: value)
        }else {
            root = TreeNode.init(value: value)
        }
    }
    
    private func insertAtNode(node: TreeNode<T>, withValue value: T) {
        if value < node.value {
            if let left = node.left {
                insertAtNode(left, withValue: value)
            }else {
                node.left = TreeNode.init(value: value)
                node.left!.parent = node
            }
            if !node.isBalance {
                if value < node.left!.value {
                    rightRotateAtNode(node)
                }else {
                    leftRightRotateAtNode(node)
                }
            }

        }else if value > node.value {
            if let right = node.right {
                insertAtNode(right, withValue: value)
            }else {
                node.right = TreeNode.init(value: value)
                node.right!.parent = node
            }
            if !node.isBalance {
                if value > node.value {
                    leftRotateAtNode(node)
                }else {
                    rightLeftRotateAtNode(node)
                }
            }
        }
        
        node.resetHeight()
    }
    
}

//MARK: - Search
extension AVLTree {
    public func minimum() -> T? {
        guard var node = root else { return nil }
        while case let next? = node.left {
            node = next
        }
        return node.value
    }
    
    public func maximum() -> T? {
        guard var node = root else { return nil }
        while case let next? = node.right {
            node = next
        }
        return node.value
    }
    
    public func contains(value: T) -> Bool {
        return search(value) != nil
    }
    
    private func search(value: T) -> TreeNode<T>?{
        var node = root
        while node != nil {
            if value < node!.value {
                node = node!.left
            }else if value > node!.value {
                node = node!.right
            }else {
                return node
            }
        }
        return nil
    }
}

//MARK: - Delete
extension AVLTree {
//    public func delete(value: T) {
//        if let root = root {
//            deleteAtNode(root, value: value)
//        }
//    }
//    
//    private func deleteAtNode(node: TreeNode<T>, value: T) {
//        if value < node.value {
//            if let left = node.left {
//                deleteAtNode(left, value: value)
//            }
//        }else if value > node.value {
//            if let right = node.right {
//                deleteAtNode(right, value: value)
//            }
//        }
//        
//        node.resetHeight()
//    }
}

//MARK: - Rotate
extension AVLTree {
    private func rightRotateAtNode(node: TreeNode<T>) {
        let leftNode = node.left!
        
        node.left = leftNode.right
        leftNode.right?.parent = node
        
        leftNode.right = node
        leftNode.parent = node.parent
        if node.isLeftChild {
            leftNode.parent?.left = leftNode
        }else if node.isRightChild {
            leftNode.parent?.right = leftNode
        }
        if leftNode.parent == nil {
            root = leftNode
        }
        node.parent = leftNode
        
        node.resetHeight()
    }
    
    private func leftRotateAtNode(node: TreeNode<T>) {
        let rightNode = node.right!
        
        node.right = rightNode.left
        rightNode.left?.parent = node
        
        rightNode.left = node
        rightNode.parent = node.parent
        if node.isLeftChild {
            rightNode.parent?.left = rightNode
        }else if node.isRightChild {
            rightNode.parent?.right = rightNode
        }
        if rightNode.parent == nil {
            root = rightNode
        }
        node.parent = rightNode
        
        node.resetHeight()
    }
    
    private func leftRightRotateAtNode(node: TreeNode<T>) {
        leftRotateAtNode(node.left!)
        rightRotateAtNode(node)
    }
    
    private func rightLeftRotateAtNode(node: TreeNode<T>) {
        rightRotateAtNode(node.right!)
        leftRotateAtNode(node)
    }
    
}

// MARK: - Debug
extension AVLTree: CustomStringConvertible {
    public var description: String {
        if let root = root {
            return root.description
        }else {
            return "[]"
        }
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}