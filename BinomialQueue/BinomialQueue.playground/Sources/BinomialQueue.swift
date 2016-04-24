/*
 Binomial Queue
 */
public class BinNode<T: Comparable> {
    var value: T
    var firstChild: BinNode?
    var nextSibling: BinNode?
    var height: Int
    
    public init(value: T) {
        self.value = value
        height = 0
    }
}

public class BinomialQueue<T: Comparable> {
    private var forest = [BinNode<T>?]()
    public var count: Int {
        return forest.count
    }
    
    public init () {}
    
    public convenience init(array: [T]) {
        self.init()
        for value in array {
            insert(value)
        }
    }
    
    public convenience init(count: Int) {
        self.init()
        forest = Array.init(count: count, repeatedValue: nil)
    }
    
    func combine(node: BinNode<T>, withNode: BinNode<T>) -> BinNode<T> {
        if node.value > withNode.value {
            return combine(withNode, withNode: node)
        }
        withNode.nextSibling = node.firstChild
        node.firstChild = withNode
        node.height += 1
        return node
    }
}

//MARK: - Basic Operations
extension BinomialQueue {
    public func merge(queue: BinomialQueue<T>) {
        if queue.forest.count == 0 {
            return
        }else if forest.count == 0 {
            forest = queue.forest
        }else {
            if queue.forest.count > forest.count {
                forest.appendContentsOf(Array.init(count: queue.forest.count - forest.count, repeatedValue: nil))
            }
            var temp: BinNode<T>?
            for i in 0..<forest.count {
                let node1 = forest[i]
                let node2: BinNode<T>?
                if i >= queue.forest.count {
                    node2 = nil
                }else {
                    node2 = queue.forest[i]
                }
                
                switch (node1, node2, temp) {
                case (nil, nil, nil): temp = nil
                case (_, nil, nil): temp = nil
                case (nil, _, nil):
                    forest[i] = node2
                    temp = nil
                case (nil, nil, _):
                    forest[i] = temp
                    temp = nil
                case (_, _, nil):
                    temp = combine(node1!, withNode: node2!)
                    forest[i] = nil
                case (_, nil, _):
                    temp = combine(node1!, withNode: temp!)
                    forest[i] = nil
                case (nil, _, _):
                    temp = combine(node2!, withNode: temp!)
                case (_, _, _):
                    forest[i] = temp
                    temp = combine(node1!, withNode: node2!)
                }
            }
            if let temp = temp {
                forest.append(temp)
            }
        }
        queue.removeAll()
    }
    
    public func insert(value: T) {
        var forest = [BinNode<T>?]()
        forest.append(BinNode<T>.init(value: value))
        let queue = BinomialQueue<T>.init()
        queue.forest = forest
        merge(queue)
    }
    
    public func deleteMin() -> T?{
        var minNode: BinNode<T>?
        var minIndex = 0
        for i in 0..<forest.count {
            if let node = forest[i] {
                if minNode == nil {
                    minNode = node
                    minIndex = i
                }else if node.value < minNode!.value{
                    minNode = node
                    minIndex = i
                }
            }
        }
        guard let deleteNode = minNode else { return nil}
        let deleteQueue = BinomialQueue<T>.init(count: minIndex)
        if let firstChild =  deleteNode.firstChild{
            deleteQueue.forest[firstChild.height] = firstChild
            var node = firstChild
            while case let next? = node.nextSibling {
                deleteQueue.forest[next.height] = next
                node = next
            }
        }
        forest[minIndex] = nil
        merge(deleteQueue)
        return deleteNode.value
    }
    
    public func removeAll() {
        forest.removeAll()
    }
}

//MARK: - Debug
extension BinomialQueue: CustomStringConvertible {
    public var description: String {
        if forest.count == 0 {
            return "[]"
        }
        var s = "["
        for i in 0..<forest.count {
            if let node = forest[i] {
                s += "\(node.description)"
            }else {
                s += "nil"
            }
            if i != forest.count - 1 {
                s += ", "
            }
        }
        s += "]"
        return s
    }
}

extension BinNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if let firstChild = firstChild {
            s += "(\(firstChild.description)"
            var node = firstChild
            while case let next? = node.nextSibling {
                s += ", \(next.description)"
                node = next
            }
            s += ")"
        }
        return s
    }
}