/*
 HashTable - 分离链接法
 */

public struct HashTable<Key: Hashable, Value> {
    private typealias Bucket = [(key: Key, value: Value)]
    private var buckets: [Bucket]
    
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array.init(count: capacity, repeatedValue: [])
    }
    
    private func indexForKey(key :Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
}

//MARK: - Basic Operation
extension HashTable {
    public subscript(key: Key) -> Value? {
        get {
            return valueForKey(key)
        }set {
            if let value = newValue {
                updateValue(value, forKey: key)
            }else {
                removeValueForKey(key)
            }
        }
    }
    
    public func valueForKey(key: Key) -> Value? {
        let index = indexForKey(key)
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil
    }
    
    public mutating func updateValue(value: Value, forKey key: Key) {
        let index = indexForKey(key)
        
        for (i, element) in buckets[index].enumerate() {
            if element.key == key {
                buckets[index][i].value = value
                return
            }
        }
        buckets[index].append((key, value))
    }
    
    public mutating func removeValueForKey(key: Key) {
        let index = indexForKey(key)
        for (i, element) in buckets[index].enumerate() {
            if element.key == key {
                buckets[index].removeAtIndex(i)
            }
        }
    }
    
    public mutating func removeAll() {
        buckets = Array.init(count: buckets.count, repeatedValue: [])
    }
}

//MARK: - Debug
extension HashTable: CustomStringConvertible {
    public var description: String {
        return buckets.description
    }
}

