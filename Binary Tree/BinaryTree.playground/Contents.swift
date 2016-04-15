//: Playground - noun: a place where people can play
let tree = BinaryTree<String>.init(value: "Nico")

let azusaNode = BinaryTree<String>.init(value: "Azusa")
let mikunode = BinaryTree<String>.init(value: "Miku")

tree.left = azusaNode
tree.right = mikunode

tree