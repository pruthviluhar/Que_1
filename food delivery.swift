import Foundation

// Enum for Delivery Speed
enum DeliverySpeed {
    case standard
    case express
    case instant
}

// Struct for Food Item
struct FoodItem {
    var itemName: String
    var restaurant: String
    var quantity: Int
    var basePrice: Int
    var deliveryCharge: Int
    
    var itemTotal: Int {
        return (basePrice * quantity) + deliveryCharge
    }
}

// Struct for Delivery Order
struct DeliveryOrder {
    static var currentID = 0
    
    var orderID: Int
    var customerName: String
    var deliveryAddress: String
    var items: [FoodItem]
    
    var grandTotal: Int {
        return items.reduce(0) { $0 + $1.itemTotal }
    }
    
    init(customerName: String, deliveryAddress: String) {
        DeliveryOrder.currentID += 1
        self.orderID = DeliveryOrder.currentID
        self.customerName = customerName
        self.deliveryAddress = deliveryAddress
        self.items = []
    }
}

// MARK: - Main Program

print("Enter Customer Name:")
let name = readLine() ?? "Customer"

print("Enter Delivery Address:")
let address = readLine() ?? "Address"

var order = DeliveryOrder(customerName: name, deliveryAddress: address)

var continueOrder = true

while continueOrder {
    
    print("\nEnter Item Name:")
    let itemName = readLine() ?? ""
    
    print("Enter Restaurant Name:")
    let restaurant = readLine() ?? ""
    
    print("Enter Quantity:")
    let qty = Int(readLine() ?? "1") ?? 1
    
    print("Enter Base Price:")
    let base = Int(readLine() ?? "0") ?? 0
    
    print("Choose Delivery Speed: 1. Standard  2. Express  3. Instant")
    let speedInput = Int(readLine() ?? "1") ?? 1
    
    var deliveryCharge = 0
    
    switch speedInput {
    case 1:
        deliveryCharge = 30
    case 2:
        deliveryCharge = 60
    case 3:
        deliveryCharge = 100
    default:
        deliveryCharge = 30
    }
    
    let item = FoodItem(
        itemName: itemName,
        restaurant: restaurant,
        quantity: qty,
        basePrice: base,
        deliveryCharge: deliveryCharge
    )
    
    order.items.append(item)
    
    // Print cart
    print("\n--- Cart ---")
    for i in order.items {
        print("\(i.itemName) (\(i.restaurant)) | Qty: \(i.quantity) | Total: ₹\(i.itemTotal)")
    }
    
    print("Current Grand Total: ₹\(order.grandTotal)")
    
    print("\nAdd more items? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueOrder = false
    }
}

// Final Order
print("\n===== ORDER PLACED =====")
print("Order ID: \(order.orderID)")
print("Customer: \(order.customerName)")
print("Delivery Address: \(order.deliveryAddress)")
print("Grand Total: ₹\(order.grandTotal)")
