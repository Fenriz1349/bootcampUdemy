import UIKit

// lorsque l'on crée un sigleton, quelque soit son nom on fait toujours référence à la même copie unique
class Car {
    var color = "Red"
    
    static let singletonCar = Car()
}

let myCar = Car.singletonCar
myCar.color = "Blue"

let yourCar = Car.singletonCar
print(yourCar.color)

