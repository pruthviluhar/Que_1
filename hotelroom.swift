import Foundation

// Enum for Room Type
enum RoomType {
    case standard
    case deluxe
    case suite
}

// Struct for Room
struct Room {
    var roomNumber: Int
    var roomType: RoomType
    var nights: Int
    var pricePerNight: Int
    
    var roomTotal: Int {
        return pricePerNight * nights
    }
}

// Struct for Hotel Booking
struct HotelBooking {
    static var currentID = 0
    
    var bookingID: Int
    var guestName: String
    var rooms: [Room]
    
    var totalAmount: Int {
        return rooms.reduce(0) { $0 + $1.roomTotal }
    }
    
    init(guestName: String) {
        HotelBooking.currentID += 1
        self.bookingID = HotelBooking.currentID
        self.guestName = guestName
        self.rooms = []
    }
}

// MARK: - Main Program

print("Enter Guest Name:")
let name = readLine() ?? "Guest"

var booking = HotelBooking(guestName: name)

var continueBooking = true

while continueBooking {
    
    print("\nEnter Room Number:")
    let roomNo = Int(readLine() ?? "0") ?? 0
    
    print("Choose Room Type: 1. Standard  2. Deluxe  3. Suite")
    let typeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedType: RoomType
    var price = 0
    
    switch typeInput {
    case 1:
        selectedType = .standard
        price = 2000
    case 2:
        selectedType = .deluxe
        price = 4500
    case 3:
        selectedType = .suite
        price = 9000
    default:
        selectedType = .standard
        price = 2000
    }
    
    print("Enter Number of Nights:")
    let nights = Int(readLine() ?? "1") ?? 1
    
    let room = Room(
        roomNumber: roomNo,
        roomType: selectedType,
        nights: nights,
        pricePerNight: price
    )
    
    booking.rooms.append(room)
    
    // Print current booking
    print("\n--- Current Booking ---")
    for r in booking.rooms {
        print("Room \(r.roomNumber) | Nights: \(r.nights) | Total: ₹\(r.roomTotal)")
    }
    
    print("Current Total: ₹\(booking.totalAmount)")
    
    print("\nAdd more rooms? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueBooking = false
    }
}

// Final Confirmation
print("\n===== BOOKING CONFIRMED =====")
print("Booking ID: \(booking.bookingID)")
print("Guest Name: \(booking.guestName)")
print("Total Amount: ₹\(booking.totalAmount)")
