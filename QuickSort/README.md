# 快速排序
快排的核心思想就是分组，选取一个枢纽元，将数组分为小于和大于枢纽元的两堆，然后递归地对这两堆进行快速排序，来完成排序。将数组S快速排序，基本步骤如下：

1. 如果S中元素个数是0或是1，则返回 
2. 从S中选取枢纽元v
3. 将`S - {v}`分为两个集合，`S1 = {x < v}, S2 = {x > v}`
4. 重新组合为`{quickSort(S1), v, quickSort{S2}}`

## 例子
对`[7，1，2，0，4，8]`进行快速排序
假设我们选取4为枢纽元，则分为

```
S1 = {1, 2, 0}
v = 4
S2 = {7, 8}
```

## 分组
### Lumuto
选取枢纽元，并将其放在数组末尾，利用两个游标i和j，保证在任意时刻，有

```
[values <= pivot | values > pivot  | 待   处   理 | pivot]
 left     i - 1   i         j - 1   j    right-1   right
```
#### 例子
对`[7，1，2，0，8，4]`进行分组，起初令`i=j=left`，有

```
[  7  ,  1  ,  2  ,  0  ,  8  |  4  ]
  left                         right
   i                           pivot
   j
```
因为7>pivot,所以i不动，j继续往前走

```
[  7  ,  1  ,  2  ,  0  ,  8  |  4  ]
  left                         right
   i     
         j
```
因为1<pivot,所以交换i和j所在位置的值，i加1，j继续往前扫描，得

```
[  1  ,  7  ,  2  ,  0  ,  8  |  4  ]
  left                         right
         i     
               j
```
2<pivot,同上

```
[  1  ,  2  ,  7  ,  0  ,  8  |  4  ]
  left                         right
               i     
                     j
```
0<pivot，同上

```
[  1  ,  2  ,  0  ,  7  ,  8  |  4  ]
  left                         right
                     i     
                           j
```
8>pivot, i 不动，j继续往前扫描

```
[  1  ,  2  ,  0  ,  7  ,  8  |  4  ]
  left                         right
                     i     
                                 j
```
j到达末尾，交换枢纽元和i所在位置的值，得

```
[  1  ,  2  ,  0  |  4  |  8  ， 7  ]
  left                         right
                     i     
                                 j
```
分组完毕

#### 实现

```swift
func partitionLumuto<T: Comparable>(inout array: [T], left: Int, right: Int) -> Int {
    let pivot = array[right]
    var i = left
    for j in left..<right {
        if array[j] <= pivot {
            (array[i], array[j]) = (array[j], array[i])
            i += 1
        }
    }
    (array[i], array[right]) = (array[right], array[i])
    return i
}
```
### Hoare
同样，选取枢纽元，将其放在数组末尾，利用两个游标i，j，保证在任意时刻有：

```
[values <= pivot |  待   处   理  | values > pivot | pivot]
 left        i     i+1       j-1    j               right
```
#### 例子
对`[7，1，2，0，8，4]`进行分组，起初令`i=left-1, j=right`，有

```
[  7  ,  1  ,  2  ,  0  ,  8  |  4  ]
  left                         right
i                              pivot
                                 j
```
开始扫描，i指向7，j指向8

```
[  7  ,  1  ,  2  ,  0  ,  8  |  4  ]
  left                         right
   i                           pivot
                           j
```
7>pivot,i停止扫描，8>pivot，j继续扫描

```
[  7  ,  1  ,  2  ,  0  ,  8  |  4  ]
  left                         right
   i                           pivot
                     j
```
j指向0<pivot,停止扫描，此刻，i和j都停止了，交换两者的值，得

```
[  0  ,  1  ,  2  ,  7  ,  8  |  4  ]
  left                         right
   i                           pivot
                     j
```
继续向前扫描，i指向1，j指向2

```
[  0  ,  1  ,  2  ,  7  ,  8  |  4  ]
  left                         right
         i                     pivot
               j
```
1<pivot,i继续向前，2<pivot，j停止扫描

```
[  0  ,  1  ,  2  ,  7  ,  8  |  4  ]
  left                         right
               i               pivot
               j
```
i指向2<pivot,i继续向前

```
[  0  ,  1  ,  2  ,  7  ,  8  |  4  ]
  left                         right
                     i         pivot
               j
```
i指向7>pivot，此刻i和j都停止扫描，且有i > j，直接交换i所在位置的值和pivot，得

```
[  0  ,  1  ,  2  |  4  |  8  ,  7  ]
  left             pivot        right
                     i         
               j
```
分组完毕
#### 代码

```swift
func partitionHoare<T: Comparable>(inout array: [T], left: Int, right: Int) -> Int {
    let pivot = median3(&array, left: left, right: right)
    if left + 1 >= right {
        return left
    }
    var i = left
    var j = right - 1
    while true {
        repeat { i += 1} while array[i] < pivot
        repeat { j -= 1} while array[j] > pivot
        if i < j {
            swap(&array[i], &array[j])
        }else {
            (array[i], array[right - 1]) = (array[right - 1], array[i])
            return i
        }
    }
}
```
## 快排
上面的分组完毕后会返回枢纽元的位置，因此我们便能很方便的进行快速排序，如下

```swift
func quickSort<T: Comparable>(inout array: [T], left: Int, right: Int) {
    if left < right {
        let p = partition(&array, left: left, right: right)
        quickSort(&array, left: left, right: p - 1)
        quickSort(&array, left: p + 1, right: right)
    }
}
```


