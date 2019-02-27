import Foundation

class Spoon {
    
    private var lock = NSLock()
    
    var spoon: [Int]
    var spoonCopy: [Int]
    
    init(spoon: [Int]) {
        self.spoon = spoon
        self.spoonCopy = spoon
    }
    
    func pickUp() {
        lock.lock()
    }
    
    func putDown() {
        lock.unlock()
    }
}

class Developer {
    
    let name: String
    let leftSpoon: Spoon
    let rightSpoon: Spoon
    
    private var lock = NSLock()
    
    init(name: String, leftSpoon: Spoon, rightSpoon: Spoon) {
        self.name = name
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    
    func think() {
        print("\(name) is thinking")
        if leftSpoon.spoon[0] < rightSpoon.spoon[0] {
            leftSpoon.pickUp()
        } else {
            rightSpoon.pickUp()
        }
    }
    
    func run() {
        while true {
            think()
            eat()
        }
    }
    
    func eat() {
        print("\(name) is eating")
        usleep(1000)
        rightSpoon.putDown()
        leftSpoon.putDown()
    }
}

let spoon1 = Spoon(spoon: [1])
let spoon2 = Spoon(spoon: [2])
let spoon3 = Spoon(spoon: [3])
let spoon4 = Spoon(spoon: [4])
let spoon5 = Spoon(spoon: [5])

let developer1 = Developer(name: "developer 1", leftSpoon: spoon1, rightSpoon: spoon5)
let developer2 = Developer(name: "developer 2", leftSpoon: spoon2, rightSpoon: spoon1)
let developer3 = Developer(name: "developer 3", leftSpoon: spoon3, rightSpoon: spoon2)
let developer4 = Developer(name: "developer 4", leftSpoon: spoon4, rightSpoon: spoon3)
let developer5 = Developer(name: "developer 5", leftSpoon: spoon5, rightSpoon: spoon4)

let developers: [Developer] = [developer1, developer2, developer3, developer4, developer5]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
