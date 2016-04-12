//: Playground - noun: a place where people can play

let list = LinkedList<String>()

list.isEmpty
list.firstNode
list.lastNode

list.append("Nico")
list.isEmpty
list.firstNode?.value
list.lastNode?.value
list.count

list.append("Miku")
list.firstNode?.value
list.lastNode?.value
list.count

list.firstNode?.prev
list.firstNode?.next?.value
list.lastNode?.prev?.value
list.lastNode?.next

list.nodeAtIndex(0)?.value
list.nodeAtIndex(1)?.value
list.nodeAtIndex(2)

list[0]
list[1]
//list[2] //error

list.insert("Azusa", atIndex: 1)

list.removeAll()
list.firstNode
list.lastNode
list.count

list.append("Nico")
list.append("Azusa")
list.append("Miku")

list.removeAtIndex(1)
list
list.removeLast()
list
list.removeNode(list.firstNode!)
list