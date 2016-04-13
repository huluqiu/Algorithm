/*
 循环队列
 进队和出队操作均为O(1)
 */
public struct Queue<T> {
    private var array = [T?]()
    private var capacity: Int
    private var count: Int = 0
    private var front: Int = 0{
        didSet {
            if front >= capacity {
                front -= capacity
            }
        }
    }
    private var rear: Int = 0{
        didSet {
            if rear >= capacity {
                rear -= capacity
            }
        }
    }
    
    public init(capacity: Int = 10) {
        self.capacity = capacity
        array = .init(count: capacity, repeatedValue: nil)
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var isFull: Bool {
        return count == capacity
    }
    
    public mutating func enqueue(element: T) {
        if isFull {
            return
        }
        array[rear] = element
        rear += 1
        count += 1
    }
    
    public mutating func dequeue() -> T? {
        guard !isEmpty, let element = array[front] else { return nil}
        array[front] = nil
        front += 1
        count -= 1
        return element
    }
    
    public mutating func removeAll() {
        array = .init(count: capacity, repeatedValue: nil)
        count = 0
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        var s = "["
        var i = 0
        for element in array {
            if let element = element {
                s += "\(element)"
            }else{
                s += "\(element)"
            }
            i += 1
            if i != array.count {
                s += ", "
            }
        }
        return s + "]"
    }
}