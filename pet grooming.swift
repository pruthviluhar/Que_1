import Foundation

// Enum for Grooming Package
enum GroomingPackage {
    case basic
    case standard
    case deluxe
}

// Struct for Grooming Service
struct GroomingService {
    var petName: String
    var petType: String
    var groomingPackage: GroomingPackage
    var price: Int
}

// Struct for Grooming Appointment
struct GroomingAppointment {
    static var currentID = 0
    
    var appointmentID: Int
    var ownerName: String
    var services: [GroomingService]
    
    var totalAmount: Int {
        return services.reduce(0) { $0 + $1.price }
    }
    
    init(ownerName: String) {
        GroomingAppointment.currentID += 1
        self.appointmentID = GroomingAppointment.currentID
        self.ownerName = ownerName
        self.services = []
    }
}

// MARK: - Main Program

print("Enter Owner Name:")
let owner = readLine() ?? "Owner"

var appointment = GroomingAppointment(ownerName: owner)

var continueBooking = true

while continueBooking {
    
    print("\nEnter Pet Name:")
    let petName = readLine() ?? ""
    
    print("Enter Pet Type:")
    let petType = readLine() ?? ""
    
    print("Choose Package: 1. Basic  2. Standard  3. Deluxe")
    let packageInput = Int(readLine() ?? "1") ?? 1
    
    var selectedPackage: GroomingPackage
    var price = 0
    
    switch packageInput {
    case 1:
        selectedPackage = .basic
        price = 300
    case 2:
        selectedPackage = .standard
        price = 600
    case 3:
        selectedPackage = .deluxe
        price = 1000
    default:
        selectedPackage = .basic
        price = 300
    }
    
    let service = GroomingService(
        petName: petName,
        petType: petType,
        groomingPackage: selectedPackage,
        price: price
    )
    
    appointment.services.append(service)
    
    // Print all pets booked
    print("\n--- Grooming Appointments ---")
    for s in appointment.services {
        print("\(s.petName) (\(s.petType)) | Price: ₹\(s.price)")
    }
    
    print("Current Total Amount: ₹\(appointment.totalAmount)")
    
    print("\nAdd more pets? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueBooking = false
    }
}

// Final Confirmation
print("\n===== APPOINTMENT CONFIRMED =====")
print("Appointment ID: \(appointment.appointmentID)")
print("Owner Name: \(appointment.ownerName)")
print("Total Amount: ₹\(appointment.totalAmount)")
