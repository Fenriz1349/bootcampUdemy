import UIKit
// il ne faut stocker que des petites données dans UserDefaults

let defaults = UserDefaults.standard

//il vaut mieux utiliser des constantes pour eviter les typos
let volumeKey = "Volume"
let musicOnKey = "MusicOn"
let playerNameKey = "PlayerName"
let appLastOpenedKey = "AppLastOpenedByUser"
let myArrayKey = "MyArray"
let myDictionaryKey = "MyDictonary"
//on peut definir des valeurs par defauts pour les utiliser plus tard
defaults.set(0.24, forKey: volumeKey)
defaults.set(true,forKey: musicOnKey)
defaults.setValue("Fen", forKey: playerNameKey)
defaults.set(Date(), forKey: appLastOpenedKey)

let array = [1,2,3]
defaults.set(array,forKey: myArrayKey)
let dictionary = ["name":"Fen"]
defaults.set(dictionary, forKey: myDictionaryKey)

//on utilise après la clé pour récuperer la valeur
let volume = defaults.float(forKey: volumeKey)
let appLastOpen = defaults.object(forKey: appLastOpenedKey)
let myArray = defaults.array(forKey: myArrayKey) as! [Int]
let myDictionary = defaults.dictionary(forKey: myDictionaryKey)
