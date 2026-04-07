import Foundation

// Enum for Service Type
enum ServiceType {
    case basic
    case signature
    case luxury
}

// Struct for Spa Service
struct SpaService {
    var serviceName: String
    var serviceType: ServiceType
    var duration: Int   // in minutes
    var price: Int
}

// Struct for Spa Appointment
struct SpaAppointment {
    static var currentID = 0
    
    var appointmentID: Int
    var clientName: String
    var services: [SpaService]
    
    var totalAmount: Int {
        return services.reduce(0) { $0 + $1.price }
    }
    
    init(clientName: String) {
        SpaAppointment.currentID += 1
        self.appointmentID = SpaAppointment.currentID
        self.clientName = clientName
        self.services = []
    }
}

// MARK: - Main Program

print("Enter Client Name:")
let name = readLine() ?? "Client"

var appointment = SpaAppointment(clientName: name)

var continueBooking = true

while continueBooking {
    
    print("\nEnter Service Name:")
    let serviceName = readLine() ?? ""
    
    print("Choose Service Type: 1. Basic  2. Signature  3. Luxury")
    let typeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedType: ServiceType
    var price = 0
    
    switch typeInput {
    case 1:
        selectedType = .basic
        price = 600
    case 2:
        selectedType = .signature
        price = 1200
    case 3:
        selectedType = .luxury
        price = 2200
    default:
        selectedType = .basic
        price = 600
    }
    
    print("Enter Duration (in minutes):")
    let duration = Int(readLine() ?? "30") ?? 30
    
    let service = SpaService(
        serviceName: serviceName,
        serviceType: selectedType,
        duration: duration,
        price: price
    )
    
    appointment.services.append(service)
    
    // Print appointment details
    print("\n--- Appointment Details ---")
    for s in appointment.services {
        print("\(s.serviceName) | Duration: \(s.duration) mins | Price: ₹\(s.price)")
    }
    
    print("Current Total Amount: ₹\(appointment.totalAmount)")
    
    print("\nAdd more services? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueBooking = false
    }
}

// Final Booking
print("\n===== APPOINTMENT BOOKED =====")
print("Appointment ID: \(appointment.appointmentID)")
print("Client Name: \(appointment.clientName)")
print("Total Amount: ₹\(appointment.totalAmount)")
