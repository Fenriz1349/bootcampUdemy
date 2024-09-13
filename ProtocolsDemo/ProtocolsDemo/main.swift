protocol CanFly {
    func fly()
}
// ajouter une extention à un protocol permet de donner une valeur par defaut
extension CanFly {
    func fly() {
        print("The object takes off into the air")
    }
}

class Bird {
    
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("the bird make an egg.")
        }
    }
}

class Eagle:Bird, CanFly {
    
    func fly() {
        print("the eagle fly.")
    }
    
    func soar() {
        print("the eagle glides in the air using air currents.")
    }
}

class Penguin :Bird {
    
    func swim() {
        print("the penguin swim.")
    }
}

struct Airplane : CanFly {
    
    func fly() {
        print("the airplane fly")
    }
}
struct FlyingMuseum {

    func flyingDemo(flyingobject: CanFly) {
        flyingobject.fly()
    }
}

let myEagle = Eagle()
let myPenguin = Penguin()
let myPlane = Airplane()

let myMuseum = FlyingMuseum()

myMuseum.flyingDemo(flyingobject: myPlane)

