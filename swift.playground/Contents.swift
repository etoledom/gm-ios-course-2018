

// Swift is a general-purpose, multi-paradigm, compiled, strongly-typed programming language

print("Hello, swift")

//- Variables (and constants)

var int = 1 // Variable
let string = "string" // Constant

// ===========================================================================================

//- Type system (inferance)

var int_02 = 4 // int_02 is infered as an Int by the type of the assigned value
//int_02 = "str" // This fails!!
type(of: int_02)

// ===========================================================================================

// Some other types

let float: Float = 0.1
let double = 0.1 // Any decimal will be infered as Double

// ===========================================================================================

//- More types (collections…)

let anArray = [1, 2, 3, 4] // Arrays are genericlty typed
let strArray = ["a", "b", "b"]

let emptyArray = [Int]() // Compiler needs to know the array type to create an empty one
let emptyStrArray: [String] = []

anArray[0]
//anArray.append(3) // -> This fails because `anArray` is constant.

var variableArray = [Int]() // variable or "mutable" array
variableArray.append(1)
variableArray.append(contentsOf: [2, 3, 4])
variableArray.reverse()


let dictionary = ["key": "value"]
dictionary["key"]

var variableDictionary = [Int: Double]()
variableDictionary[0] = 2.1


// ===========================================================================================

//- Branching (`if`, `switch`)

if anArray.isEmpty {
    print("isEmpty")
} else {
    print("is not empty")
}

switch float {
case 0:
    print("float is zero")
case 0.1:
    print("float is 0.1")
default:
    print("float is not zero nor 0.1")
}

// ===========================================================================================

//- Iterators (`for in`, `while` ,`do while`)

for i in anArray {
    print(i)
}

while variableArray.count < 10 {
    variableArray.append(0)
}

variableArray

var i = 0
repeat {   // also known as do-while
    i += 1
} while i < 5


// ===========================================================================================

//- Functions

func printSomething() {
    print("something")
}

printSomething()

// ---- argument

func say(this: String) {
    print(this)
}

say(this: "something else")

// ---- return value (_ label)

func add(_ rhs: Int, to lhs: Int) -> Int {
    return lhs + rhs
}

add(4, to: 5)

func add(_ rhs: String, to lhs: String) -> String {
    return lhs + rhs
}

add(" second", to: "first")

// ---- function as argument

func stringify(_ number: Int) -> String {
    return String(number)
}

stringify(5)

func apply(_ function: (Int) -> (String), to number: Int) -> String {
    return function(number)
}

apply(stringify, to: 6)

// ---- special case: function as last argument

func applyToValue(_ value: Int, thisFunction function: (Int) -> Void) {
    function(value)
}

applyToValue(10) { (number) in
    let plusOne = number + 1
    print(plusOne)
}

// ---- function as return

func createAdder(_ numberToAdd: Int) -> (Int) -> Int {
    return { number in
        return number + numberToAdd
    }
}

let addFive = createAdder(5)
addFive(4)

// ===========================================================================================

//- `struct` and `class`

struct Person {  // Value type
    let name: String
    var age: Int
}

let john = Person(name: "John", age: 10)
//john.age = 12 // -> Fails

var petter = Person(name: "Petter", age: 20)
petter.age = 21

var petter2 = petter
petter2.age = 50

petter.age
petter2.age

class Dog {  // Reference type
    let name: String
    let numberOfTails = 1
    var years: Int

    init(name: String, years: Int) {
        self.name = name
        self.years = years
    }
}

let doge = Dog(name: "Doge", years: 2)
doge.years = 3
//doge.name = "No Doge" // -> Fails

let olderDoge = doge
olderDoge.years = 5

doge.years
olderDoge.years

// --- subclassing

class Chihuahua: Dog {
    func bark() -> String {
        return "Chichichi"
    }
}

let littleDog = Chihuahua(name: "Fifi", years: 1)
littleDog.bark()

// ===========================================================================================

//- Protocols

protocol Damagable {
    mutating func getDamage(_ damage: Int) -> Bool
}

protocol Talkable {
    func say(_ phrase: String) -> String
}

struct Wall: Damagable {
    var hitPoints: Int

    mutating func getDamage(_ damage: Int) -> Bool {
        hitPoints -= damage
        return hitPoints <= 0
    }
}

struct Citizen: Damagable, Talkable {
    let name: String
    var hitPoints: Int

    mutating func getDamage(_ damage: Int) -> Bool {
        hitPoints -= damage
        return hitPoints <= 0
    }

    func say(_ phrase: String) -> String {
        return "\(name) says: \(phrase)"
    }
}

var wall = Wall(hitPoints: 500)
let isDestroid = wall.getDamage(300)

var citizen = Citizen(name: "Paul", hitPoints: 20)
citizen.say("Such a nice day to live!")
let isDead = citizen.getDamage(30)

func hit(_ target: Damagable) -> Bool {
    var mutableTarget = target
    let randomDamage = Int.random(in: 2...20)
    return mutableTarget.getDamage(randomDamage)
}

hit(wall)
hit(citizen)


// ===========================================================================================

//- `nil` and optionals

let maybeANumber: Int? = Int("3")

if maybeANumber == nil {
    print("Is not a number")
} else {
    print(maybeANumber)
}

// ===========================================================================================

//- Optionals magic (chaining, unwrapping)

let value = dictionary["key"]
value?.count

if let theActualValue = value {
    print(theActualValue)
} else {
    print("Not value found")
}

func doSomething(to number: Int?) {
    guard let number = number else {
        print("Error: No number found")
        return
    }

    print(number)
}


doSomething(to: 4)
doSomething(to: nil)
