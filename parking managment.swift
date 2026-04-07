import Foundation

// Enum for Vehicle Type
enum VehicleType {
    case twoWheeler
    case car
    case heavyVehicle
}

// Struct for Parking Slot
struct ParkingSlot {
    var vehicleNumber: String
    var vehicleType: VehicleType
    var hoursParked: Int
    var hourlyCharge: Int
    
    var parkingFee: Int {
        return hourlyCharge * hoursParked
    }
}

// Struct for Parking Session
struct ParkingSession {
    static var currentID = 0
    
    var sessionID: Int
    var parkingLotName: String
    var slots: [ParkingSlot]
    
    var totalCollection: Int {
        return slots.reduce(0) { $0 + $1.parkingFee }
    }
    
    init(parkingLotName: String) {
        ParkingSession.currentID += 1
        self.sessionID = ParkingSession.currentID
        self.parkingLotName = parkingLotName
        self.slots = []
    }
}

// MARK: - Main Program

print("Enter Parking Lot Name:")
let lotName = readLine() ?? "Parking Lot"

var session = ParkingSession(parkingLotName: lotName)

var continueParking = true

while continueParking {
    
    print("\nEnter Vehicle Number:")
    let vehicleNo = readLine() ?? ""
    
    print("Choose Vehicle Type: 1. Two-Wheeler  2. Car  3. Heavy Vehicle")
    let typeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedType: VehicleType
    var charge = 0
    
    switch typeInput {
    case 1:
        selectedType = .twoWheeler
        charge = 10
    case 2:
        selectedType = .car
        charge = 30
    case 3:
        selectedType = .heavyVehicle
        charge = 60
    default:
        selectedType = .twoWheeler
        charge = 10
    }
    
    print("Enter Hours Parked:")
    let hours = Int(readLine() ?? "1") ?? 1
    
    let slot = ParkingSlot(
        vehicleNumber: vehicleNo,
        vehicleType: selectedType,
        hoursParked: hours,
        hourlyCharge: charge
    )
    
    session.slots.append(slot)
    
    // Print parked vehicles
    print("\n--- Parked Vehicles ---")
    for s in session.slots {
        print("\(s.vehicleNumber) | Hours: \(s.hoursParked) | Fee: ₹\(s.parkingFee)")
    }
    
    print("Current Total Collection: ₹\(session.totalCollection)")
    
    print("\nAdd more vehicles? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueParking = false
    }
}

// Final Output
print("\n===== SESSION CLOSED =====")
print("Session ID: \(session.sessionID)")
print("Parking Lot: \(session.parkingLotName)")
print("Total Collection: ₹\(session.totalCollection)")
