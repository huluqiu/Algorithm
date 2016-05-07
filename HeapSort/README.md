# 堆排序
通过优先队列来完成排序。比如要进行升序排序，则构建一个max堆，每次对堆进行`delete`操作，删除后的值放在数组末尾，这样，只要进行N次(实际只要N-1次，最后一次不用删除)，即可完成排序。由于堆每次`delete`操作均要花费`logN`，所以时间复杂度为`O(NlogN)`。

# 例子
对于数组`[7，1，2，0，4，8]`，我们先对其进行建堆操作，得到

```
[8，4，7，0，1，2]
```
第一次`delete`操作时：将8删除，并放在数组末尾，需将2放在堆顶，并对其进行下滤操作，箭头表示数组末尾

```
[7，4，2，0，1，8]
					↑
```
第二次，将7放在数组末尾，将1放在堆顶，下滤

```
[4，1，2，0，7，8]
            ↑
```
第三次，将4放在数组末尾，将0放在放在堆顶，下滤

```
[2，1，0，4，7，8]
         ↑
```
第四次，将2放在数组末尾，将0放在堆顶，下滤

```
[1，0，2，4，7，8]
       ↑
```
第五次，由于数组只剩两个元素，直接交换，得到最后结果

```
[0，1，2，4，7，8]
    ↑
```

# 代码
这里用一个下滤操作来实现建队和删除，建堆通过从最后一个非叶子节点开始下滤，直到根节点完成下滤来完成建堆；删除则是通过交换堆顶和数组末尾元素，将数组数量-1，并对堆顶元素进行下滤来完成删除。

```swift
func percolateDown<T: Comparable>(inout array: [T], atIndex index: Int, count: Int) {
    let element = array[index]
    var i = index
    while i * 2 + 1 < count {
        var child = i * 2 + 1
        if child != count - 1 && array[child] < array[child + 1] {
            child += 1
        }
        if array[child] > element {
            array[i] = array[child]
        }else {
            break
        }
        i = child
    }
    array[i] = element
}

func heapSort<T: Comparable>(inout array: [T]) {
    var i = array.count / 2
    while i >= 0 {
        percolateDown(&array, atIndex: i, count: array.count)
        i -= 1
    }
    i = array.count - 1
    while i > 0 {
        swap(&array[0], &array[i])
        percolateDown(&array, atIndex: 0, count: i)
        i -= 1
    }
}
```

