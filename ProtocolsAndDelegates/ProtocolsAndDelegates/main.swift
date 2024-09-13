// indique les methodes que pourront excecuter tous ceux qui se conforment au protocol, sans specifier ce que ces methodes feront en détails
protocol AdvancedLifeSupport {
    func performCPR()
}

// pour que la class suive le protocole, elle doit avoir une propriété qui est du type du protocol
class EmergencyCallHandler {
    var delegate : AdvancedLifeSupport?
    
    func assessSituation() {
        print("Can you telle ma what happened?")
    }
    
    func medicalEmergecy() {
        delegate?.performCPR()
    }
}
// on créé une struc qui se conforme au protocol, c'est ici qu'on definit précisement ce qu'effectue la methode du protocol
struct Paramedic : AdvancedLifeSupport {
    
    init(handler : EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The paramedic does chest compression, 30 per second.")
    }
}

class Doctor :AdvancedLifeSupport{
    
    init(handler : EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The doctor does chest compression, 30 per second.")
    }
    
    func useStethoscope() {
        print("Listen to your heart")
    }
}

class Surgeon : Doctor {
    
    override func performCPR() {
        super.performCPR()
        print("Sing staying alive by the BeeGees")
    }
    func useElectricDrill() {
        print("vroom vroom")
    }
}

let emilio = EmergencyCallHandler()
let angela = Surgeon(handler: emilio)

emilio.assessSituation()
emilio.medicalEmergecy()
