# 归并排序
这个算法的基本操作是合并两个已排序的数组。
## 合并算法
若要合并A，B两个已排序的数组，需要借助第三个数组C，同时遍历A，B两个数组，将其中较小值放到数组C，直到两数组都遍历完成。
### 例子
对以下两个数组进行合并

```
A: [0, 2, 4]
B: [1, 3, 5]
```
依次遍历两个数组，首先是`0`和`1`进行比较，`0`较小，放入C

```
A: [0, 2, 4]
    ↑
B: [1, 3, 5]
    ↑
C: [0]
```
接着比较`2`和`1`，`1`较小，放入C

```
A: [0, 2, 4]
       ↑
B: [1, 3, 5]
    ↑
C: [0，1]
```
比较`2`和`3`，`2`放入C

```
A: [0, 2, 4]
       ↑
B: [1, 3, 5]
       ↑
C: [0，1，2]
```
比较`4`和`3`，`3`放入C

```
A: [0, 2, 4]
          ↑
B: [1, 3, 5]
       ↑
C: [0，1，2，3]
```
比较`4`和`5`，`4`放入C

```
A: [0, 2, 4]
          ↑
B: [1, 3, 5]
          ↑
C: [0，1，2，3，4]
```
数组A已经遍历完毕，将B剩下的元素统统放进C

```
C：[0，1，2，3，4，5]
```
### 代码

```swift
func merge<T: Comparable>(inout array: [T], leftStart: Int, rightStart: Int, rightEnd: Int) {
    var leftPos = leftStart
    let leftEnd = rightStart - 1
    var rightPos = rightStart
    var tempArray = [T]()
    while leftPos <= leftEnd && rightPos <= rightEnd {
        if array[leftPos] < array[rightPos] {
            tempArray.append(array[leftPos])
            leftPos += 1
        }else {
            tempArray.append(array[rightPos])
            rightPos += 1
        }
    }
    while leftPos <= leftEnd {
        tempArray.append(array[leftPos])
        leftPos += 1
    }
    while rightPos <= rightEnd {
        tempArray.append(array[rightPos])
        rightPos += 1
    }
    var i = leftStart
    for element in tempArray {
        array[i] = element
        i += 1
    }
}
```
## 排序
如果N=1，那么只有一个元素要排序，直接返回。否则，递归地将前半部分和后半部分各自归并排序，得到排序后的两部分数据，再将这两部分数据合并到一起。
### 例子
对数组`[7, 1, 5, 0, 4, 8]`进行归并排序，我们递归地对其前3个数据和后3个数据分别归并排序，得到`[1，5，7]`和`[0，4，8]`，再将其合并，得到`[0，1，4，5，7，8]`
### 代码

```swift
func mSort<T: Comparable>(inout array: [T], left: Int, right: Int) {
    if left < right {
        let center = (left + right) / 2
        mSort(&array, left: left, right: center)
        mSort(&array, left: center + 1, right: right)
        merge(&array, leftStart: left, rightStart: center + 1, rightEnd: right)
    }
}

func mergeSort<T: Comparable>(inout array: [T]) {
    mSort(&array, left: 0, right: array.count - 1)
}
```

## 归并排序分析
对于N=1，归并排序所用的时间为1。否则，对N个数归并排序所用时间为完成两个大小为N/2的递归排序所用的时间再加上合并的时间，即：
$$ T(1) = 1 $$

$$ T(N) = 2T(\frac{N}{2}) + N $$
两边同除以N，得

$$ \frac{T(N)}{N} = \frac{T(\frac{N}{2})}{\frac{N}{2}} + 1$$
该方程对于2的幂的任意N成立，得
$$ \frac{T(\frac{N}{2})}{\frac{N}{2}} = \frac{T(\frac{N}{4})}{\frac{N}{4}} + 1$$

$$ \frac{T(\frac{N}{4})}{\frac{N}{4}} = \frac{T(\frac{N}{8})}{\frac{N}{8}} + 1$$

$$ .$$

$$ .$$

$$ \frac{T(2)}{2} = \frac{T(1)}{1} + 1$$
将这些方程相加，得

$$ T(N) = N + NlogN$$
所以，归并排序的时间复杂度`T(N) = O(NlogN)`

