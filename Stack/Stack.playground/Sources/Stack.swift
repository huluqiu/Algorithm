
public struct Stack<T> {
    private var array = [T]()
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func push(element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        if isEmpty {
            return nil
        }else {
            return array.removeLast()
        }
    }
    
    public mutating func removeAll() {
        array.removeAll()
    }
    
    public init() {
        
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        var s = "["
        var i = 0
        for element in array {
            s += "\(element)"
            i += 1
            if i != array.count {
                s += ", "
            }
        }
        return s + "]"
    }
}