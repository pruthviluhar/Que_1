import Foundation

// Enum for Car Category
enum CarCategory {
    case hatchback
    case sedan
    case suv
}

// Struct for Rental Car
struct RentalCar {
    var carModel: String
    var carCategory: CarCategory
    var rentalDays: Int
    var dailyRate: Int
    
    var rentalTotal: Int {
        return dailyRate * rentalDays
    }
}

// Struct for Rental Booking
struct RentalBooking {
    static var currentID = 0
    
    var bookingID: Int
    var renterName: String
    var cars: [RentalCar]
    
    var totalCost: Int {
        return cars.reduce(0) { $0 + $1.rentalTotal }
    }
    
    init(renterName: String) {
        RentalBooking.currentID += 1
        self.bookingID = RentalBooking.currentID
        self.renterName = renterName
        self.cars = []
    }
}

// MARK: - Main Program

print("Enter Renter Name:")
let name = readLine() ?? "Guest"

var booking = RentalBooking(renterName: name)

var continueBooking = true

while continueBooking {
    
    print("\nEnter Car Model:")
    let model = readLine() ?? ""
    
    print("Choose Category: 1. Hatchback  2. Sedan  3. SUV")
    let categoryInput = Int(readLine() ?? "1") ?? 1
    
    var selectedCategory: CarCategory
    var rate = 0
    
    switch categoryInput {
    case 1:
        selectedCategory = .hatchback
        rate = 800
    case 2:
        selectedCategory = .sedan
        rate = 1400
    case 3:
        selectedCategory = .suv
        rate = 2500
    default:
        selectedCategory = .hatchback
        rate = 800
    }
    
    print("Enter Rental Days:")
    let days = Int(readLine() ?? "1") ?? 1
    
    let car = RentalCar(
        carModel: model,
        carCategory: selectedCategory,
        rentalDays: days,
        dailyRate: rate
    )
    
    booking.cars.append(car)
    
    // Print rental summary
    print("\n--- Rental Summary ---")
    for c in booking.cars {
        print("\(c.carModel) | Days: \(c.rentalDays) | Total: ₹\(c.rentalTotal)")
    }
    
    print("Current Total Cost: ₹\(booking.totalCost)")
    
    print("\nAdd more cars? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueBooking = false
    }
}

// Final Confirmation
print("\n===== BOOKING CONFIRMED =====")
print("Booking ID: \(booking.bookingID)")
print("Renter Name: \(booking.renterName)")
print("Total Cost: ₹\(booking.totalCost)")
