import Foundation

// Enum for Membership Plan
enum MembershipPlan {
    case basic
    case standard
    case premium
}

// Struct for Membership
struct Membership {
    var memberName: String
    var plan: MembershipPlan
    var months: Int
    var monthlyFee: Int
    
    var totalFee: Int {
        return monthlyFee * months
    }
}

// Struct for Gym Registration
struct GymRegistration {
    static var currentID = 0
    
    var registrationID: Int
    var gymBranch: String
    var memberships: [Membership]
    
    var totalRevenue: Int {
        return memberships.reduce(0) { $0 + $1.totalFee }
    }
    
    init(gymBranch: String) {
        GymRegistration.currentID += 1
        self.registrationID = GymRegistration.currentID
        self.gymBranch = gymBranch
        self.memberships = []
    }
}

// MARK: - Main Program

print("Enter Gym Branch:")
let branch = readLine() ?? "Default Branch"

var registration = GymRegistration(gymBranch: branch)

var continueEntry = true

while continueEntry {
    
    print("\nEnter Member Name:")
    let name = readLine() ?? ""
    
    print("Choose Plan: 1. Basic  2. Standard  3. Premium")
    let planInput = Int(readLine() ?? "1") ?? 1
    
    var selectedPlan: MembershipPlan
    var fee = 0
    
    switch planInput {
    case 1:
        selectedPlan = .basic
        fee = 500
    case 2:
        selectedPlan = .standard
        fee = 900
    case 3:
        selectedPlan = .premium
        fee = 1500
    default:
        selectedPlan = .basic
        fee = 500
    }
    
    print("Enter Number of Months:")
    let months = Int(readLine() ?? "1") ?? 1
    
    let membership = Membership(
        memberName: name,
        plan: selectedPlan,
        months: months,
        monthlyFee: fee
    )
    
    registration.memberships.append(membership)
    
    // Print all memberships
    print("\n--- Current Memberships ---")
    for m in registration.memberships {
        print("\(m.memberName) | Months: \(m.months) | Total: ₹\(m.totalFee)")
    }
    
    print("Current Revenue: ₹\(registration.totalRevenue)")
    
    print("\nAdd more members? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueEntry = false
    }
}

// Final Output
print("\n===== REGISTRATION CLOSED =====")
print("Registration ID: \(registration.registrationID)")
print("Gym Branch: \(registration.gymBranch)")
print("Total Revenue: ₹\(registration.totalRevenue)")
