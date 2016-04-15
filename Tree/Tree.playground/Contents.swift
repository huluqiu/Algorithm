//: Playground - noun: a place where people can play

let tree = TreeNode<String>(value: "Nico")

let azusaNode = TreeNode<String>(value: "Azusa")

let mikuNode = TreeNode<String>(value: "Miku")

tree.addChild(azusaNode)
tree.addChild(mikuNode)

azusaNode.addChild("Cristina")
azusaNode.addChild("Solar")

tree
