import Foundation

// Enum for Cup Size
enum CupSize {
    case small
    case medium
    case large
}

// Struct for Coffee Order
struct CoffeeOrder {
    var drinkName: String
    var cupSize: CupSize
    var quantity: Int
    var price: Int
    
    var itemTotal: Int {
        return price * quantity
    }
}

// Struct for Cafe Order
struct CafeOrder {
    static var currentID = 0
    
    var orderID: Int
    var customerName: String
    var orders: [CoffeeOrder]
    
    var totalBill: Int {
        return orders.reduce(0) { $0 + $1.itemTotal }
    }
    
    init(customerName: String) {
        CafeOrder.currentID += 1
        self.orderID = CafeOrder.currentID
        self.customerName = customerName
        self.orders = []
    }
}

// MARK: - Main Program

print("Enter Customer Name:")
let name = readLine() ?? "Guest"

var cafeOrder = CafeOrder(customerName: name)

var continueOrdering = true

while continueOrdering {
    
    print("\nEnter Drink Name:")
    let drink = readLine() ?? ""
    
    print("Choose Size: 1. Small  2. Medium  3. Large")
    let sizeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedSize: CupSize
    var price = 0
    
    switch sizeInput {
    case 1:
        selectedSize = .small
        price = 80
    case 2:
        selectedSize = .medium
        price = 140
    case 3:
        selectedSize = .large
        price = 200
    default:
        selectedSize = .small
        price = 80
    }
    
    print("Enter Quantity:")
    let qty = Int(readLine() ?? "1") ?? 1
    
    let order = CoffeeOrder(
        drinkName: drink,
        cupSize: selectedSize,
        quantity: qty,
        price: price
    )
    
    cafeOrder.orders.append(order)
    
    // Print updated order
    print("\n--- Current Order ---")
    for item in cafeOrder.orders {
        print("\(item.drinkName) | Qty: \(item.quantity) | Total: ₹\(item.itemTotal)")
    }
    
    print("Current Bill: ₹\(cafeOrder.totalBill)")
    
    print("\nAdd more? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueOrdering = false
    }
}

// Checkout
print("\n===== FINAL BILL =====")
print("Order ID: \(cafeOrder.orderID)")
print("Customer: \(cafeOrder.customerName)")
print("Total Bill: ₹\(cafeOrder.totalBill)")
