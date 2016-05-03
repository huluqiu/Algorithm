//: Playground - noun: a place where people can play

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

var array = [7, 4, 8, 0, 1, 3]
mergeSort(&array)
