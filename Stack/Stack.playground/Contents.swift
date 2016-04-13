//: Playground - noun: a place where people can play

var stack = Stack<String>()
stack.isEmpty

stack.push("Nico")
stack.push("Azusa")
stack.push("Miku")
stack.isEmpty

stack.pop()
stack.pop()
stack.pop()
stack.isEmpty

stack.push("Nico")
stack.push("Azusa")
stack.push("Miku")

stack.removeAll()
stack.isEmpty
