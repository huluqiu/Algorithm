/*
 HashTable - 开放定址法 - 线性探测
 */
public struct HashTable<Key: Hashable, Value> {
    private var buckets: [(key: Key, value: Value)?]
    
    public init(capacity: Int) {
        precondition(capacity > 0)
        buckets = Array.init(count: capacity, repeatedValue: nil)
    }
    
    private func indexForKey(key: Key) -> Int {
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
        var index = indexForKey(key)
        var i = 0
        while case let element? = buckets[index] {
            if element.key == key {
                return element.value
            }else if i < buckets.count {
                i += 1
                index += 1
                if index >= buckets.count {
                    index -= buckets.count
                }
            }else { break }
        }
        return nil
    }

    public mutating func updateValue(value: Value, forKey key: Key) {
        var index = indexForKey(key)
        var i = 0
        while case let element? = buckets[index] {
            if element.key == key {
                break
            }else if element.key != key && i < buckets.count {
                i += 1
                index += 1
                if index >= buckets.count {
                    index -= buckets.count
                }
            }else{ return }
        }
        buckets[index] = (key, value)
    }

    public mutating func removeValueForKey(key: Key) {
        var index = indexForKey(key)
        var i = 0
        while case let element? = buckets[index] {
            if element.key == key {
                buckets[index] = nil
            }else if i < buckets.count {
                i += 1
                index += 1
                if index >= buckets.count {
                    index -= buckets.count
                }
            }else { break }
        }
    }

    public mutating func removeAll() {
        buckets = Array.init(count: buckets.count, repeatedValue: nil)
    }
}

//MARK: - Debug
extension HashTable: CustomStringConvertible {
    public var description: String {
        return buckets.description
    }
}