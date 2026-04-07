import Foundation

// Enum for Shoot Type
enum ShootType {
    case portrait
    case wedding
    case commercial
}

// Struct for Photo Session
struct PhotoSession {
    var clientName: String
    var shootType: ShootType
    var hours: Int
    var hourlyRate: Int
    
    var sessionCost: Int {
        return hourlyRate * hours
    }
}

// Struct for Photography Booking
struct PhotographyBooking {
    static var currentID = 0
    
    var bookingID: Int
    var photographerName: String
    var sessions: [PhotoSession]
    
    var totalEarnings: Int {
        return sessions.reduce(0) { $0 + $1.sessionCost }
    }
    
    init(photographerName: String) {
        PhotographyBooking.currentID += 1
        self.bookingID = PhotographyBooking.currentID
        self.photographerName = photographerName
        self.sessions = []
    }
}

// MARK: - Main Program

print("Enter Photographer Name:")
let photographer = readLine() ?? "Photographer"

var booking = PhotographyBooking(photographerName: photographer)

var continueBooking = true

while continueBooking {
    
    print("\nEnter Client Name:")
    let client = readLine() ?? ""
    
    print("Choose Shoot Type: 1. Portrait  2. Wedding  3. Commercial")
    let typeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedType: ShootType
    var rate = 0
    
    switch typeInput {
    case 1:
        selectedType = .portrait
        rate = 1500
    case 2:
        selectedType = .wedding
        rate = 3000
    case 3:
        selectedType = .commercial
        rate = 5000
    default:
        selectedType = .portrait
        rate = 1500
    }
    
    print("Enter Number of Hours:")
    let hours = Int(readLine() ?? "1") ?? 1
    
    let session = PhotoSession(
        clientName: client,
        shootType: selectedType,
        hours: hours,
        hourlyRate: rate
    )
    
    booking.sessions.append(session)
    
    // Print session list
    print("\n--- Session List ---")
    for s in booking.sessions {
        print("\(s.clientName) | Hours: \(s.hours) | Cost: ₹\(s.sessionCost)")
    }
    
    print("Current Total Earnings: ₹\(booking.totalEarnings)")
    
    print("\nAdd more sessions? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueBooking = false
    }
}

// Final Output
print("\n===== BOOKING CLOSED =====")
print("Booking ID: \(booking.bookingID)")
print("Photographer Name: \(booking.photographerName)")
print("Total Earnings: ₹\(booking.totalEarnings)")
