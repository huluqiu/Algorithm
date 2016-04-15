/*
 二叉树 ------ 链表结构
 */

public class BinaryTree<T> {
    public var value: T
    public var left: BinaryTree?
    public var right: BinaryTree?
    public var count: Int {
        var count = 1
        if left != nil {
            count += left!.count
        }
        if right != nil {
            count += right!.count
        }
        return count
    }
    
    public init(value: T) {
        self.value = value
    }
    
    public init(value: T, left: BinaryTree?, right: BinaryTree?) {
        self.value = value
        self.left = left
        self.right = right
    }
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        s += " {"
        if left != nil {
            s += left!.description
        }else {
            s += "nil"
        }
        s += ", "
        if right != nil {
            s += right!.description
        }else {
            s += "nil"
        }
        s += "}"
        return s
    }
}