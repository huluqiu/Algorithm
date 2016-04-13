# 栈
栈的原则是后进先出

```swift
//进栈
stack.push("Nico")
stack.push("Azusa")
stack.push("Miku")
//出栈
stack.pop()
//"Miku"
stack.pop()
//"Azusa"
stack.pop()
//"Nico"
```
在swift中实现栈很容易，用数组的`append()`和`removeLast()`就能模拟进栈和出栈,实现如下

```swift
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
```
