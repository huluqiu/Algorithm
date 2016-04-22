/*
 BinaryHeap - Min
 */

public struct BinaryHeap<T: Comparable> {
    private var elements = [T]()
    
    public init(array: [T]) {
        buildHeap(array)
    }

    private mutating func percolateUpAtIndex(index: Int) {
        assert(index < elements.count)
        let element = elements[index]
        var i = index
        var child = i
        while i != 0 && elements[(i - 1) / 2] > element {
            elements[i] = elements[(i - 1) / 2]
            child = i
            i = (i - 1) / 2
        }
        if i == 0 {
            if elements[0] > element {
                elements[child] = elements[0]
            }else {
                i = child
            }
        }
        elements[i] = element
    }
    
    private mutating func percolateDownAtIndex(index: Int, lastElementIndex: Int) {
        assert(index < elements.count)
        let element = elements[index]
        let lastElement = elements[lastElementIndex]
        var i = index
        
        while i * 2 + 1 < elements.count {
            var child = 2 * i + 1
            if child != elements.count - 1 && elements[child + 1] < elements[child] {
                child += 1
            }
            if elements[child] < lastElement{
                elements[i] = elements[child]
            }else {
                break
            }
            i = child
        }
        elements[i] = lastElement
        elements[lastElementIndex] = element
    }
}

//MARK: - Basic Operations
extension BinaryHeap {
    private mutating func buildHeap(array: [T]) {
        for element in array {
            insert(element)
        }
    }
    
    public mutating func insert(element: T) {
        elements.append(element)
        percolateUpAtIndex(elements.count - 1)
    }
    
    public mutating func deleteMin() {
        assert(elements.count > 0)
        percolateDownAtIndex(0, lastElementIndex: elements.count - 1)
        elements.removeLast()
    }
    
    public func minimum() -> T? {
        return elements.first
    }
    
    public mutating func removeAtIndex(index: Int) {
        assert(index < elements.count)
        elements[index] = minimum()!
        percolateUpAtIndex(index)
        deleteMin()
    }
    
    public mutating func removeAll() {
        elements.removeAll()
    }
}

//MARK: - Debug
extension BinaryHeap: CustomStringConvertible {
    public var description: String {
        if elements.count > 0 {
            return descriptionAtIndex(0)
        }else {
            return "nil"
        }
    }
    
    private func descriptionAtIndex(index: Int) -> String {
        var s = ""
        let left = 2 * index + 1
        if left < elements.count {
            s += "(\(descriptionAtIndex(left)))<- "
        }
        s += "\(elements[index])"
        let right = left + 1
        if right < elements.count {
            s += " ->(\(descriptionAtIndex(right)))"
        }
        return s
    }
}

extension BinaryHeap: CustomDebugStringConvertible {
    public var debugDescription: String {
        return elements.description
    }
}