import Foundation

// Enum for Streaming Plan
enum StreamingPlan {
    case free
    case individual
    case family
}

// Struct for Streaming Subscription
struct StreamingSubscription {
    var platformName: String
    var streamingPlan: StreamingPlan
    var months: Int
    var monthlyFee: Int
    
    var subscriptionTotal: Int {
        return monthlyFee * months
    }
}

// Struct for User Account
struct UserAccount {
    static var currentID = 0
    
    var accountID: Int
    var userName: String
    var email: String
    var subscriptions: [StreamingSubscription]
    
    var totalSpend: Int {
        return subscriptions.reduce(0) { $0 + $1.subscriptionTotal }
    }
    
    init(userName: String, email: String) {
        UserAccount.currentID += 1
        self.accountID = UserAccount.currentID
        self.userName = userName
        self.email = email
        self.subscriptions = []
    }
}

// MARK: - Main Program

print("Enter User Name:")
let name = readLine() ?? "User"

print("Enter Email:")
let email = readLine() ?? "email@example.com"

var account = UserAccount(userName: name, email: email)

var continueSubscription = true

while continueSubscription {
    
    print("\nEnter Platform Name:")
    let platform = readLine() ?? ""
    
    print("Choose Plan: 1. Free  2. Individual  3. Family")
    let planInput = Int(readLine() ?? "1") ?? 1
    
    var selectedPlan: StreamingPlan
    var fee = 0
    
    switch planInput {
    case 1:
        selectedPlan = .free
        fee = 0
    case 2:
        selectedPlan = .individual
        fee = 119
    case 3:
        selectedPlan = .family
        fee = 179
    default:
        selectedPlan = .free
        fee = 0
    }
    
    print("Enter Number of Months:")
    let months = Int(readLine() ?? "1") ?? 1
    
    let subscription = StreamingSubscription(
        platformName: platform,
        streamingPlan: selectedPlan,
        months: months,
        monthlyFee: fee
    )
    
    account.subscriptions.append(subscription)
    
    // Print all subscriptions
    print("\n--- Active Subscriptions ---")
    for s in account.subscriptions {
        print("\(s.platformName) | Months: \(s.months) | Cost: ₹\(s.subscriptionTotal)")
    }
    
    print("Current Total Spend: ₹\(account.totalSpend)")
    
    print("\nAdd more subscriptions? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueSubscription = false
    }
}

// Final Output
print("\n===== ACCOUNT SUMMARY =====")
print("Account ID: \(account.accountID)")
print("User Name: \(account.userName)")
print("Email: \(account.email)")
print("Total Spend: ₹\(account.totalSpend)")
