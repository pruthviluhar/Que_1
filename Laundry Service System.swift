import Foundation

// Enum for Wash Type
enum WashType {
    case normal
    case dryClean
    case premium
}

// Struct for Laundry Item
struct LaundryItem {
    var clothingItem: String
    var washType: WashType
    var quantity: Int
    var pricePerPiece: Int
    
    var itemTotal: Int {
        return pricePerPiece * quantity
    }
}

// Struct for Laundry Order
struct LaundryOrder {
    static var currentID = 0
    
    var orderID: Int
    var customerName: String
    var deliveryDate: String
    var items: [LaundryItem]
    
    var totalBill: Int {
        return items.reduce(0) { $0 + $1.itemTotal }
    }
    
    init(customerName: String, deliveryDate: String) {
        LaundryOrder.currentID += 1
        self.orderID = LaundryOrder.currentID
        self.customerName = customerName
        self.deliveryDate = deliveryDate
        self.items = []
    }
}

// MARK: - Main Program

print("Enter Customer Name:")
let name = readLine() ?? "Customer"

print("Enter Delivery Date:")
let date = readLine() ?? "Tomorrow"

var order = LaundryOrder(customerName: name, deliveryDate: date)

var continueOrder = true

while continueOrder {
    
    print("\nEnter Clothing Item:")
    let itemName = readLine() ?? ""
    
    print("Choose Wash Type: 1. Normal  2. Dry Clean  3. Premium")
    let typeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedType: WashType
    var price = 0
    
    switch typeInput {
    case 1:
        selectedType = .normal
        price = 20
    case 2:
        selectedType = .dryClean
        price = 80
    case 3:
        selectedType = .premium
        price = 150
    default:
        selectedType = .normal
        price = 20
    }
    
    print("Enter Quantity:")
    let qty = Int(readLine() ?? "1") ?? 1
    
    let laundryItem = LaundryItem(
        clothingItem: itemName,
        washType: selectedType,
        quantity: qty,
        pricePerPiece: price
    )
    
    order.items.append(laundryItem)
    
    // Print updated laundry list
    print("\n--- Laundry Items ---")
    for i in order.items {
        print("\(i.clothingItem) | Qty: \(i.quantity) | Total: ₹\(i.itemTotal)")
    }
    
    print("Current Total Bill: ₹\(order.totalBill)")
    
    print("\nAdd more items? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueOrder = false
    }
}

// Final Output
print("\n===== ORDER PLACED =====")
print("Order ID: \(order.orderID)")
print("Customer Name: \(order.customerName)")
print("Delivery Date: \(order.deliveryDate)")
print("Total Bill: ₹\(order.totalBill)")
