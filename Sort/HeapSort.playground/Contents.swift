//: Playground - noun: a place where people can play

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

var array = [0, 7, 4, 6, 5, 1]
heapSort(&array)