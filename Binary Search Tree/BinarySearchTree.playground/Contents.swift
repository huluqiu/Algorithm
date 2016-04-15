//: Playground - noun: a place where people can play

let tree = BinarySearchTree<Int>.init(value: 7)

tree.insert(5)
tree.insert(8)
tree.insert(9)

tree.traversePreOrder()
tree.traverseInOrder()
tree.traversePosOrder()

tree.count
tree.height
tree.maximum()
tree.minimum()
tree.search(5)

tree.contains(1)
tree.contains(8)

tree.remove(5)
tree.remove(7)
tree.remove(8)
tree.remove(9)

let tree2 = BinarySearchTree<Int>.init(array: [7, 1, 3, 9, 8])
tree2.traverseInOrder()
tree2.traversePreOrder()
tree2.traversePosOrder()


