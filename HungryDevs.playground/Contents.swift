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
        spoon.remove(at: 0)
    }
    
    func putDown() {
        spoon = spoonCopy
        lock.unlock()
    }
}

class Developer {
    
    let leftSpoon: Spoon
    let rightSpoon: Spoon
    
    init(leftSpoon: Spoon, rightSpoon: Spoon) {
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    
    func think() {
        leftSpoon.pickUp()
        rightSpoon.pickUp()
        return
    }
    
    func run() {
        think()
        eat()
    }
    
    func eat() {
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

let developer1 = Developer(leftSpoon: spoon1, rightSpoon: spoon5)
let developer2 = Developer(leftSpoon: spoon2, rightSpoon: spoon1)
let developer3 = Developer(leftSpoon: spoon3, rightSpoon: spoon2)
let developer4 = Developer(leftSpoon: spoon4, rightSpoon: spoon3)
let developer5 = Developer(leftSpoon: spoon5, rightSpoon: spoon1)

let developers: [Developer] = [developer1, developer2, developer3, developer4, developer5]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
