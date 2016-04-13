//: Playground - noun: a place where people can play

var queue = Queue<String>.init(capacity: 5)
queue.isEmpty

queue.enqueue("Nico")
queue.isEmpty
queue.enqueue("Azusa")
queue.enqueue("Miku")

queue.dequeue()
queue
queue.dequeue()
queue.dequeue()
queue.isEmpty

queue.enqueue("Nico")
queue.enqueue("Azusa")
queue.enqueue("Miku")
queue.removeAll()
queue.isEmpty
