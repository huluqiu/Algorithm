//: Playground - noun: a place where people can play

var tree = AVLTree<Int>.init(array: [7, 5, 6, 2, 3, 9, 10])

tree.minimum()

tree.maximum()

tree.contains(1)
tree.contains(7)

tree.delete(7)
tree.delete(9)
tree.delete(10)
tree.delete(2)
tree.delete(5)
tree.delete(3)
tree.delete(6)

var tree2 = AVLTree<Int>.init()

tree2.insert(7)
tree2.insert(6)
tree2.insert(5)
tree2.insert(4)
tree2.insert(3)
tree2.insert(2)
tree2.insert(1)