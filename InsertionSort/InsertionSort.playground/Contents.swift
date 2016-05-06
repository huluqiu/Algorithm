//: Playground - noun: a place where people can play

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

var array = [7, 3, 1, 8, 0, 2]

insertionSort(&array, <)
