//: Playground - noun: a place where people can play
var hash = HashTable<Int, String>.init(capacity: 5)

hash[0] = "Nico"
hash[1] = "Azusa"
hash[4] = "Miku"

hash[0] = "Luyisi"
hash[0]
hash

hash[5] = "Yui"
hash[2] = "Solar"

hash[2]
hash[5]
hash

//表已满，无法插入
hash[6] = "test"
hash

hash.removeValueForKey(0)
hash.removeAll()