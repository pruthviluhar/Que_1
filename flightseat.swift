import Foundation

// Enum for Cabin Class
enum CabinClass {
    case economy
    case business
    case firstClass
}

// Struct for Flight Seat
struct FlightSeat {
    var passengerName: String
    var cabinClass: CabinClass
    var seatNumber: String
    var fare: Int
}

// Struct for Flight Booking
struct FlightBooking {
    static var currentID = 0
    
    var bookingID: Int
    var flightNumber: String
    var seats: [FlightSeat]
    
    var totalFare: Int {
        return seats.reduce(0) { $0 + $1.fare }
    }
    
    init(flightNumber: String) {
        FlightBooking.currentID += 1
        self.bookingID = FlightBooking.currentID
        self.flightNumber = flightNumber
        self.seats = []
    }
}

// MARK: - Main Program

print("Enter Flight Number:")
let flightNo = readLine() ?? "Unknown"

var booking = FlightBooking(flightNumber: flightNo)

var continueBooking = true

while continueBooking {
    
    print("\nEnter Passenger Name:")
    let name = readLine() ?? ""
    
    print("Choose Cabin Class: 1. Economy  2. Business  3. First Class")
    let classInput = Int(readLine() ?? "1") ?? 1
    
    var selectedClass: CabinClass
    var fare = 0
    
    switch classInput {
    case 1:
        selectedClass = .economy
        fare = 4500
    case 2:
        selectedClass = .business
        fare = 12000
    case 3:
        selectedClass = .firstClass
        fare = 25000
    default:
        selectedClass = .economy
        fare = 4500
    }
    
    print("Enter Seat Number:")
    let seatNo = readLine() ?? ""
    
    let seat = FlightSeat(
        passengerName: name,
        cabinClass: selectedClass,
        seatNumber: seatNo,
        fare: fare
    )
    
    booking.seats.append(seat)
    
    // Print full passenger list (manifest)
    print("\n--- Passenger Manifest ---")
    for s in booking.seats {
        print("\(s.passengerName) | Seat: \(s.seatNumber) | Fare: ₹\(s.fare)")
    }
    
    print("Current Total Fare: ₹\(booking.totalFare)")
    
    print("\nAdd more passengers? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueBooking = false
    }
}

// Final Confirmation
print("\n===== BOOKING CONFIRMED =====")
print("Booking ID: \(booking.bookingID)")
print("Flight Number: \(booking.flightNumber)")
print("Total Fare: ₹\(booking.totalFare)")
