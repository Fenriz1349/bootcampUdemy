import UIKit
// ici le 3eme paramètre est une fonction,
func calculator (n1:Int, n2:Int,operation: (Int,Int)->Int) -> Int {
    return operation(n1, n2)
}

func add (n1:Int, n2:Int) -> Int {
    return n1 + n2
}

func multiply (n1:Int, n2:Int) -> Int {
    return n1 * n2
}

calculator(n1: 2, n2: 3, operation: add)
calculator(n1: 2, n2: 3, operation: multiply)
// pour faire une closure, on supprime le mot clé func et le nom, on deplace le { au début, et on ajoute in avant le corps de la fonction, avec l'inference de type, on n'est pas obligé de les declarer dans la closure
calculator(n1: 2, n2: 3, operation: {(n1, n2) in n1 * n2 })
// on peut encore simplifier en utiliser $n pour chaque paramètre
calculator(n1: 2, n2: 3, operation: {$0 * $1})
//en swift si le dernier paramètre est une closure, on peut le retirer des parametre lors de l'appel
calculator(n1: 2, n2: 3) {$0 * $1}

var array = [6,2,3,9,4,1]
print(array)
let new = array.map{"\($0)"}
print(new)

