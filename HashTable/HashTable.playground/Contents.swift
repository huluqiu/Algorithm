//: Playground - noun: a place where people can play

var hash = HashTable<Int, String>.init(capacity: 5)

hash[1] = "Nico"
hash[0] = "Miku"
hash[6] = "Azusa"

hash

hash[1]
hash[6]

hash[1] = "Luyisi"
hash

hash.removeValueForKey(1)

hash.removeAll()