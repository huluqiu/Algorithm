//: Playground - noun: a place where people can play

//median3
func median3<T: Comparable>(inout array: [T], left: Int, right: Int) -> T {
    let center = (left + right) / 2
    if array[left] > array[center] {
        (array[left], array[center]) = (array[center], array[left])
    }
    if array[left] > array[right] {
        (array[left], array[right]) = (array[right], array[left])
    }
    if array[center] > array[right] {
        (array[center], array[right]) = (array[right], array[center])
    }
    (array[center], array[right - 1]) = (array[right - 1], array[center])
    return array[right - 1]
}

//Lumuto
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

func quickSortLumuto<T: Comparable>(inout array: [T], left: Int, right: Int) {
    if left < right {
        let p = partitionLumuto(&array, left: left, right: right)
        quickSortLumuto(&array, left: left, right: p - 1)
        quickSortLumuto(&array, left: p + 1, right: right)
    }
}

//Hoare
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

func quickSortHoare<T: Comparable>(inout array: [T], left: Int, right: Int) {
    if left < right {
        let p = partitionHoare(&array, left: left, right: right)
        quickSortHoare(&array, left: left, right: p - 1)
        quickSortHoare(&array, left: p + 1, right: right)
    }
}

func quickSort<T: Comparable>(inout array: [T]) {
//    quickSortLumuto(&array, left: 0, right: array.count - 1)
    quickSortHoare(&array, left: 0, right: array.count - 1)
}

var array = [7, 0, 2, 1, 8, 4, 5]
quickSort(&array)
