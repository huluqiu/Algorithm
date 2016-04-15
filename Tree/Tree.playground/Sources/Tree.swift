/*
 树 ----- 链表结构
 */

public class TreeNode<T> {
    public var value: T
    
    public var parent: TreeNode?
    public var children = [TreeNode<T>]()
    
    public init(value: T) {
        self.value = value
    }
    
    public func addChild(node: TreeNode) {
        children.append(node)
        node.parent = self
    }
    
    public func addChild(value: T) {
        let node = TreeNode<T>(value: value)
        children.append(node)
        node.parent = self
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joinWithSeparator(", ") + "}"
        }
        return s
    }
}
