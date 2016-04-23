/*
 AVL树
 */
public class TreeNode<T: Comparable> {
    private var value: T
    private var height: Int
    private var left: TreeNode?
    private var right: TreeNode?
    private var parent: TreeNode?
    
    public init(value: T) {
        self.value = value
        self.height = 1
    }
}

public class AVLTree<T: Comparable> {
    private var root: TreeNode<T>? {
        didSet {
            root?.parent = nil
        }
    }
    
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

extension AVLTree {
    private func reconnectParentFromNode(node: TreeNode<T>, toNode: TreeNode<T>?) {
        guard let parent = node.parent else {
            root = toNode
            node.parent = nil
            return
        }
        if node.isLeftChild {
            parent.left = toNode
        }else {
            parent.right = toNode
        }
        toNode?.parent = parent
        node.parent = nil
    }
    
    private func reconnectLeftChildFromNode(node: TreeNode<T>, toNode: TreeNode<T>) {
        if let left = node.left {
            toNode.left = left
            left.parent = toNode
            node.left = nil
            toNode.resetHeight()
        }else {
            toNode.left = nil
        }
    }
    
    private func reconnectRightChildFromNode(node: TreeNode<T>, toNode: TreeNode<T>) {
        if let right = node.right {
            toNode.right = right
            right.parent = toNode
            node.right = nil
            toNode.resetHeight()
        }else {
            toNode.right = nil
        }
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
                if value > node.right!.value {
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
        return findMinAtNode(root)?.value
    }
    
    public func maximum() -> T? {
        return findMaxAtNode(root)?.value
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
    
    private func findMinAtNode(node: TreeNode<T>?) -> TreeNode<T>? {
        guard var node = node else { return nil }
        while case let next? = node.left {
            node = next
        }
        return node
    }
    
    private func findMaxAtNode(node: TreeNode<T>?) -> TreeNode<T>? {
        guard var node = node else { return nil }
        while case let next? = node.right {
            node = next
        }
        return node
    }
}

//MARK: - Delete
extension AVLTree {
    public func delete(value: T) {
        if let root = root {
            deleteAtNode(root, value: value)
        }
    }
    
    private func deleteAtNode(node: TreeNode<T>, value: T) {
        if value == node.value {
            if let rightMinNode = findMinAtNode(node.right) {
                if rightMinNode === node.right {
                    reconnectParentFromNode(node, toNode: rightMinNode)
                    reconnectLeftChildFromNode(node, toNode: rightMinNode)
                }else {
                    node.value = rightMinNode.value
                    reconnectParentFromNode(rightMinNode, toNode: nil)
                }
            }else {
                reconnectParentFromNode(node, toNode: node.left)
            }
        }else if value < node.value {
            let left = node.left!
            deleteAtNode(left, value: value)
            if !node.isBalance {
                guard let right = node.right else { return }
                if right.leftChildHeight > right.rightChildHeight {
                    rightLeftRotateAtNode(node)
                }else {
                    leftRotateAtNode(node)
                }
            }
        }else {
            let right = node.right!
            deleteAtNode(right, value: value)
            if !node.isBalance {
                guard let left = node.left else { return }
                if left.leftChildHeight < left.rightChildHeight {
                    leftRightRotateAtNode(node)
                }else {
                    rightRotateAtNode(node)
                }
            }
        }
        
        node.resetHeight()
    }
}

//MARK: - Rotate
extension AVLTree {
    private func rightRotateAtNode(node: TreeNode<T>) {
        let leftNode = node.left!
        
        reconnectParentFromNode(node, toNode: leftNode)
        
        node.left = leftNode.right
        leftNode.right?.parent = node
        
        leftNode.right = node
        node.parent = leftNode
        
        node.resetHeight()
        leftNode.resetHeight()
    }
    
    private func leftRotateAtNode(node: TreeNode<T>) {
        let rightNode = node.right!
        
        reconnectParentFromNode(node, toNode: rightNode)
        
        node.right = rightNode.left
        rightNode.left?.parent = node
        
        rightNode.left = node
        node.parent = rightNode
        
        node.resetHeight()
        rightNode.resetHeight()
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