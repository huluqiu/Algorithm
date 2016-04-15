# 二叉查找树
二叉查找树是一颗满足下面条件的二叉树
`value[left] < value[root] < value[right]`
如下图所示
![](/Users/alezai/Documents/GitRepo/Algorithm/Binary Search Tree/Image/BinarySearchTree.png)

## insert

```swift
    public func insert(value: T) {
        insert(value, parent: self)
    }
    
    private func insert(value: T, parent: BinarySearchTree) {
        if value < self.value {
            if let left = left {
                left.insert(value)
            }else {
                left = BinarySearchTree.init(value: value)
                left?.parent = self
            }
        }else {
            if let right = right {
                right.insert(value)
            }else {
                right = BinarySearchTree.init(value: value)
                right?.parent = self
            }
        }
    }
```

## search

```swift
    public func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value)
        }else if value > self.value {
            return right?.search(value)
        }else {
            return self
        }
    }
    
    public func contains(value: T) -> Bool {
        return search(value) != nil
    }
    
    public func minimum() -> BinarySearchTree {
        var node = self
        while case let next? = node.left {
            node = next
        }
        return node
    }
    
    public func maximum() -> BinarySearchTree {
        var node = self
        while case let next? = node.right {
            node = next
        }
        return node
    }
```

## traverse

```swift
    public func traverseInOrder() -> Array<T> {
        var array = [T]()
        if let a = left?.traverseInOrder() {
            array.appendContentsOf(a)
        }
        if let value = value {
            array.append(value)
        }
        if let a = right?.traverseInOrder() {
            array.appendContentsOf(a)
        }
        return array
    }
    
    public func traversePreOrder() -> Array<T> {
        var array = [T]()
        if let value = value {
            array.append(value)
        }
        if let a = left?.traversePreOrder() {
            array.appendContentsOf(a)
        }
        if let a = right?.traversePreOrder() {
            array.appendContentsOf(a)
        }
        return array
    }
    
    public func traversePosOrder() -> Array<T> {
        var array = [T]()
        if let a = left?.traversePosOrder() {
            array.appendContentsOf(a)
        }
        if let a = right?.traversePosOrder() {
            array.appendContentsOf(a)
        }
        if let value = value {
            array.append(value)
        }
        return array
    }
```

## delete

```swift
    public func remove(value: T) -> BinarySearchTree? {
        if value < self.value {
            left = left?.remove(value)
        }else if value > self.value {
            right = right?.remove(value)
        }else if left != nil && right != nil {
            let replacement = right!.minimum()
            self.value = replacement.value
            self.right = right?.remove(replacement.value!)
        }else {
            if let left = left {
                replaceWithNode(left)
            }else if let right = right {
                replaceWithNode(right)
            }else {
                if isLeftChild {
                    parent?.left = nil
                }else {
                    parent?.right = nil
                }
                self.value = nil
                return nil
            }
        }
        
        return self
    }
```
