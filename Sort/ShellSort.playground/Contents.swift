//: Playground - noun: a place where people can play
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

var array = [7, 1, 5, 4, 0, 2]
shellSort(&array, <)
//shellSort(&array, >)