import Foundation

// Enum for Event Zone
enum EventZone {
    case general
    case vipLounge
    case backstagePass
}

// Struct for Event Ticket
struct EventTicket {
    var eventName: String
    var eventDate: String
    var zone: EventZone
    var price: Int
}

// Struct for Event Booking
struct EventBooking {
    static var currentID = 0
    
    var bookingID: Int
    var attendeeName: String
    var tickets: [EventTicket]
    
    var totalAmount: Int {
        return tickets.reduce(0) { $0 + $1.price }
    }
    
    init(attendeeName: String) {
        EventBooking.currentID += 1
        self.bookingID = EventBooking.currentID
        self.attendeeName = attendeeName
        self.tickets = []
    }
}

// MARK: - Main Program

print("Enter Attendee Name:")
let name = readLine() ?? "Guest"

var booking = EventBooking(attendeeName: name)

var continueBooking = true

while continueBooking {
    
    print("\nEnter Event Name:")
    let eventName = readLine() ?? ""
    
    print("Enter Event Date:")
    let eventDate = readLine() ?? ""
    
    print("Choose Zone: 1. General  2. VIP Lounge  3. Backstage Pass")
    let zoneInput = Int(readLine() ?? "1") ?? 1
    
    var selectedZone: EventZone
    var price = 0
    
    switch zoneInput {
    case 1:
        selectedZone = .general
        price = 500
    case 2:
        selectedZone = .vipLounge
        price = 1500
    case 3:
        selectedZone = .backstagePass
        price = 3000
    default:
        selectedZone = .general
        price = 500
    }
    
    let ticket = EventTicket(
        eventName: eventName,
        eventDate: eventDate,
        zone: selectedZone,
        price: price
    )
    
    booking.tickets.append(ticket)
    
    // Print all tickets
    print("\n--- Booked Tickets ---")
    for t in booking.tickets {
        print("\(t.eventName) | Date: \(t.eventDate) | Price: ₹\(t.price)")
    }
    
    print("Current Total Amount: ₹\(booking.totalAmount)")
    
    print("\nAdd more tickets? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueBooking = false
    }
}

// Final Confirmation
print("\n===== BOOKING CONFIRMED =====")
print("Booking ID: \(booking.bookingID)")
print("Attendee Name: \(booking.attendeeName)")
print("Total Amount: ₹\(booking.totalAmount)")
