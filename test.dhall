let Name : Type = Text
let Age : Type = < String : Text | Number : Natural >

let User
    : Type
    = { name : Name, age : Age }

let myName : Name = "hello"
let myAge : Age = Age.Number 32

let myUser
    : User
    = { name = myName, age = myAge }

in myUser
