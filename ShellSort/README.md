# 希尔排序
该算法是冲破二次时间屏障的第一批算法之一。它通过比较一定间隔的元素来工作。希尔排序使用一个增量序列`h1，h2，h3...ht`，只要`h1 = 1`的任何增量序列都是可行的。在使用增量`hk`的一趟排序之后，对于每一个`i`，我们有`a[i] <= a[i + hk]`。

# 例子
我们取`[1，...N/2]`为`A[N] = [7，1，2，0，4，8]`的增量序列
`N=6`，增量序列为`[1，3]`
取`3`，排序后得

```
[0，1，2，7，4，8]
```
取`1`，得

```
[0，1，2，4，7，8]
```
# 代码

```swift
func shellSort<T: Comparable>(inout array: [T], _ compared: (T, T) -> Bool) {
    guard array.count > 0 else { return }
    var increment = array.count / 2
    while increment > 0 {
        for i in 0..<array.count {
            var j = i
            let temp = array[j]
            while j >= increment && compared(temp, array[j - increment]){
                array[j] = array[j - increment]
                j -= increment
            }
            array[j] = temp
        }
        increment /= 2
    }
}
```


