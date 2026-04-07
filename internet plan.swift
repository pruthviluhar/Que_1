import Foundation

// Enum for Plan Type
enum PlanType {
    case basic
    case fiber
    case enterprise
}

// Struct for Internet Plan
struct InternetPlan {
    var planName: String
    var planType: PlanType
    var months: Int
    var monthlyCharge: Int
    
    var planTotal: Int {
        return monthlyCharge * months
    }
}

// Struct for Subscription
struct Subscription {
    static var currentID = 0
    
    var subscriptionID: Int
    var subscriberName: String
    var address: String
    var plans: [InternetPlan]
    
    var totalAmount: Int {
        return plans.reduce(0) { $0 + $1.planTotal }
    }
    
    init(subscriberName: String, address: String) {
        Subscription.currentID += 1
        self.subscriptionID = Subscription.currentID
        self.subscriberName = subscriberName
        self.address = address
        self.plans = []
    }
}

// MARK: - Main Program

print("Enter Subscriber Name:")
let name = readLine() ?? "User"

print("Enter Address:")
let address = readLine() ?? "Address"

var subscription = Subscription(subscriberName: name, address: address)

var continueSubscription = true

while continueSubscription {
    
    print("\nEnter Plan Name:")
    let planName = readLine() ?? ""
    
    print("Choose Plan Type: 1. Basic  2. Fiber  3. Enterprise")
    let typeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedType: PlanType
    var charge = 0
    
    switch typeInput {
    case 1:
        selectedType = .basic
        charge = 399
    case 2:
        selectedType = .fiber
        charge = 799
    case 3:
        selectedType = .enterprise
        charge = 1999
    default:
        selectedType = .basic
        charge = 399
    }
    
    print("Enter Number of Months:")
    let months = Int(readLine() ?? "1") ?? 1
    
    let plan = InternetPlan(
        planName: planName,
        planType: selectedType,
        months: months,
        monthlyCharge: charge
    )
    
    subscription.plans.append(plan)
    
    // Print active subscriptions
    print("\n--- Active Plans ---")
    for p in subscription.plans {
        print("\(p.planName) | Months: \(p.months) | Total: ₹\(p.planTotal)")
    }
    
    print("Current Total Amount: ₹\(subscription.totalAmount)")
    
    print("\nAdd more plans? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueSubscription = false
    }
}

// Final Confirmation
print("\n===== SUBSCRIPTION CONFIRMED =====")
print("Subscription ID: \(subscription.subscriptionID)")
print("Subscriber Name: \(subscription.subscriberName)")
print("Total Amount: ₹\(subscription.totalAmount)")
