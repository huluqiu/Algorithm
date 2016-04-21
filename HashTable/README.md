# HashTable
其实就是个字典！

这里采用分离链接发和开放定址法中的线性探测法来解决冲突

### 分离链接法

利用链表将`hashValue`相同的键串起来

#### 数据结构

```swift
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
```

#### 基本操作

```swift
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
```

### 开放定制法

这里采用线性探测法来解决冲突

#### 数据结构

```swift
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
```

#### 基本操作

```swift
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
```



