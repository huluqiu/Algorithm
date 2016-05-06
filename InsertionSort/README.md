# 插入排序
最简单的排序算法之一，对于数组`a[N]`,由`N`趟排序，每趟读入`a[i]`,保证`[0, i]`有序。即每次读入一个数据，并将其放在前面已排序数组中的正确位置。复杂度为`O(N)`
## 例子
对下面这个数组进行插入排序

```
[7, 1, 5, 0, 4, 8]
 ↑
```
读入7

```
[7, 1, 5, 0, 4, 8]
    ↑
```
读入1

```
[1, 7, 5, 0, 4, 8]
       ↑
```
读入5

```
[1, 5, 7, 0, 4, 8]
          ↑
```
读入0

```
[0, 1, 5, 7, 4, 8]
             ↑
```
读入4

```
[0, 1, 4, 5, 7, 8]
                ↑
```
读入8

```
[0, 1, 4, 5, 7, 8]
```
## 代码

```swift
func insertionSort<T: Comparable>(inout array: [T], _ compared: (T, T) -> Bool) {
    guard array.count > 0 else { return }
    for i in 0..<array.count {
        var j = i
        let temp = array[j]
        while j > 0 && compared(temp, array[j - 1]) {
            array[j] = array[j - 1]
            j -= 1
        }
        array[j] = temp
    }
}
```

