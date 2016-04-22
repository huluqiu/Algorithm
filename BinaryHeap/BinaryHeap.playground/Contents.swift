//: Playground - noun: a place where people can play
var heap = BinaryHeap<Int>.init(array: [7, 1, 5, 2, 9])

heap.minimum()

heap.deleteMin()
heap.deleteMin()
heap.deleteMin()

heap.minimum()

heap.insert(4)
heap.insert(3)

heap.debugDescription
heap.removeAtIndex(1)
heap.debugDescription

heap.removeAll()
