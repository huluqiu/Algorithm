//: Playground - noun: a place where people can play
var queue = BinomialQueue<Int>.init()

queue.insert(1)
queue.insert(2)
queue.insert(3)
queue.insert(4)

var queue2 = BinomialQueue<Int>.init(array: [7, 6, 5])

queue.merge(queue2)

queue.deleteMin()
queue
queue.deleteMin()
queue

queue.removeAll()
