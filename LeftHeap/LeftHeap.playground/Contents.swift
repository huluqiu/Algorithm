//: Playground - noun: a place where people can play

var heap1 = LeftHeap<Int>.init(array: [1, 2, 3, 4, 5])
var heap2 = LeftHeap<Int>.init(array: [6, 7, 8, 9, 10])

heap1.mergeWithHeap(heap2)
heap1.deleteMin()