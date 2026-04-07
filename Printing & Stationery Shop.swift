import Foundation

// Enum for Print Quality
enum PrintQuality {
    case draft
    case standard
    case highRes
}

// Struct for Print Job
struct PrintJob {
    var documentName: String
    var printQuality: PrintQuality
    var pages: Int
    var pricePerPage: Int
    
    var jobCost: Int {
        return pricePerPage * pages
    }
}

// Struct for Print Order
struct PrintOrder {
    static var currentID = 0
    
    var orderID: Int
    var customerName: String
    var jobs: [PrintJob]
    
    var totalCost: Int {
        return jobs.reduce(0) { $0 + $1.jobCost }
    }
    
    init(customerName: String) {
        PrintOrder.currentID += 1
        self.orderID = PrintOrder.currentID
        self.customerName = customerName
        self.jobs = []
    }
}

// MARK: - Main Program

print("Enter Customer Name:")
let name = readLine() ?? "Customer"

var order = PrintOrder(customerName: name)

var continuePrinting = true

while continuePrinting {
    
    print("\nEnter Document Name:")
    let docName = readLine() ?? ""
    
    print("Choose Print Quality: 1. Draft  2. Standard  3. High Resolution")
    let qualityInput = Int(readLine() ?? "1") ?? 1
    
    var selectedQuality: PrintQuality
    var price = 0
    
    switch qualityInput {
    case 1:
        selectedQuality = .draft
        price = 1
    case 2:
        selectedQuality = .standard
        price = 3
    case 3:
        selectedQuality = .highRes
        price = 7
    default:
        selectedQuality = .draft
        price = 1
    }
    
    print("Enter Number of Pages:")
    let pages = Int(readLine() ?? "1") ?? 1
    
    let job = PrintJob(
        documentName: docName,
        printQuality: selectedQuality,
        pages: pages,
        pricePerPage: price
    )
    
    order.jobs.append(job)
    
    // Print order summary
    print("\n--- Print Order Summary ---")
    for j in order.jobs {
        print("\(j.documentName) | Pages: \(j.pages) | Cost: ₹\(j.jobCost)")
    }
    
    print("Current Total Cost: ₹\(order.totalCost)")
    
    print("\nAdd more print jobs? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continuePrinting = false
    }
}

// Final Output
print("\n===== ORDER FINALIZED =====")
print("Order ID: \(order.orderID)")
print("Customer Name: \(order.customerName)")
print("Total Cost: ₹\(order.totalCost)")
