import Foundation

// Enum for Equipment Grade
enum EquipmentGrade {
    case amateur
    case semiPro
    case professional
}

// Struct for Equipment
struct Equipment {
    var equipmentName: String
    var sport: String
    var grade: EquipmentGrade
    var rentalHours: Int
    var hourlyRate: Int
    
    var rentalCost: Int {
        return hourlyRate * rentalHours
    }
}

// Struct for Equipment Rental
struct EquipmentRental {
    static var currentID = 0
    
    var rentalID: Int
    var playerName: String
    var items: [Equipment]
    
    var totalCost: Int {
        return items.reduce(0) { $0 + $1.rentalCost }
    }
    
    init(playerName: String) {
        EquipmentRental.currentID += 1
        self.rentalID = EquipmentRental.currentID
        self.playerName = playerName
        self.items = []
    }
}

// MARK: - Main Program

print("Enter Player Name:")
let name = readLine() ?? "Player"

var rental = EquipmentRental(playerName: name)

var continueRental = true

while continueRental {
    
    print("\nEnter Equipment Name:")
    let eqName = readLine() ?? ""
    
    print("Enter Sport:")
    let sport = readLine() ?? ""
    
    print("Choose Grade: 1. Amateur  2. Semi-Pro  3. Professional")
    let gradeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedGrade: EquipmentGrade
    var rate = 0
    
    switch gradeInput {
    case 1:
        selectedGrade = .amateur
        rate = 50
    case 2:
        selectedGrade = .semiPro
        rate = 120
    case 3:
        selectedGrade = .professional
        rate = 250
    default:
        selectedGrade = .amateur
        rate = 50
    }
    
    print("Enter Rental Hours:")
    let hours = Int(readLine() ?? "1") ?? 1
    
    let item = Equipment(
        equipmentName: eqName,
        sport: sport,
        grade: selectedGrade,
        rentalHours: hours,
        hourlyRate: rate
    )
    
    rental.items.append(item)
    
    // Print rental cart
    print("\n--- Rental Cart ---")
    for i in rental.items {
        print("\(i.equipmentName) (\(i.sport)) | Hours: \(i.rentalHours) | Cost: ₹\(i.rentalCost)")
    }
    
    print("Current Total Cost: ₹\(rental.totalCost)")
    
    print("\nAdd more equipment? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueRental = false
    }
}

// Final Checkout
print("\n===== CHECKOUT COMPLETE =====")
print("Rental ID: \(rental.rentalID)")
print("Player Name: \(rental.playerName)")
print("Total Cost: ₹\(rental.totalCost)")
