import Foundation

// Enum for Membership Tier
enum MembershipTier {
    case regular
    case silver
    case gold
}

// Struct for Book Issue
struct BookIssue {
    var bookTitle: String
    var author: String
    var issueDays: Int   // overdue days
    var dailyFine: Int
    
    var totalFine: Int {
        return issueDays * dailyFine
    }
}

// Struct for Library Account
struct LibraryAccount {
    static var currentID = 0
    
    var accountID: Int
    var memberName: String
    var tier: MembershipTier
    var issuedBooks: [BookIssue]
    
    var totalFine: Int {
        return issuedBooks.reduce(0) { $0 + $1.totalFine }
    }
    
    init(memberName: String, tier: MembershipTier) {
        LibraryAccount.currentID += 1
        self.accountID = LibraryAccount.currentID
        self.memberName = memberName
        self.tier = tier
        self.issuedBooks = []
    }
}

// MARK: - Main Program

print("Enter Member Name:")
let name = readLine() ?? "Member"

print("Choose Membership Tier: 1. Regular  2. Silver  3. Gold")
let tierInput = Int(readLine() ?? "1") ?? 1

var selectedTier: MembershipTier
var finePerDay = 0

switch tierInput {
case 1:
    selectedTier = .regular
    finePerDay = 5
case 2:
    selectedTier = .silver
    finePerDay = 3
case 3:
    selectedTier = .gold
    finePerDay = 1
default:
    selectedTier = .regular
    finePerDay = 5
}

var account = LibraryAccount(memberName: name, tier: selectedTier)

var continueIssue = true

while continueIssue {
    
    print("\nEnter Book Title:")
    let title = readLine() ?? ""
    
    print("Enter Author Name:")
    let author = readLine() ?? ""
    
    print("Enter Overdue Days:")
    let days = Int(readLine() ?? "0") ?? 0
    
    let book = BookIssue(
        bookTitle: title,
        author: author,
        issueDays: days,
        dailyFine: finePerDay
    )
    
    account.issuedBooks.append(book)
    
    // Print issued books
    print("\n--- Issued Books ---")
    for b in account.issuedBooks {
        print("\(b.bookTitle) by \(b.author) | Days: \(b.issueDays) | Fine: ₹\(b.totalFine)")
    }
    
    print("Current Total Fine: ₹\(account.totalFine)")
    
    print("\nIssue another book? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueIssue = false
    }
}

// Final Output
print("\n===== ACCOUNT SUMMARY =====")
print("Account ID: \(account.accountID)")
print("Member Name: \(account.memberName)")
print("Tier: \(account.tier)")
print("Total Fine Due: ₹\(account.totalFine)")
