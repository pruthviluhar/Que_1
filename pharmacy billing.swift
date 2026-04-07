import Foundation

// Enum for Medicine Type
enum MedicineType {
    case generic
    case branded
    case imported
}

// Struct for Medicine
struct Medicine {
    var medicineName: String
    var medicineType: MedicineType
    var quantity: Int
    var pricePerUnit: Int
    
    var totalPrice: Int {
        return pricePerUnit * quantity
    }
}

// Struct for Pharmacy Bill
struct PharmacyBill {
    static var currentID = 0
    
    var billID: Int
    var patientName: String
    var medicines: [Medicine]
    
    var totalBill: Int {
        return medicines.reduce(0) { $0 + $1.totalPrice }
    }
    
    init(patientName: String) {
        PharmacyBill.currentID += 1
        self.billID = PharmacyBill.currentID
        self.patientName = patientName
        self.medicines = []
    }
}

// MARK: - Main Program

print("Enter Patient Name:")
let name = readLine() ?? "Patient"

var bill = PharmacyBill(patientName: name)

var continueBilling = true

while continueBilling {
    
    print("\nEnter Medicine Name:")
    let medName = readLine() ?? ""
    
    print("Choose Medicine Type: 1. Generic  2. Branded  3. Imported")
    let typeInput = Int(readLine() ?? "1") ?? 1
    
    var selectedType: MedicineType
    var price = 0
    
    switch typeInput {
    case 1:
        selectedType = .generic
        price = 10
    case 2:
        selectedType = .branded
        price = 45
    case 3:
        selectedType = .imported
        price = 120
    default:
        selectedType = .generic
        price = 10
    }
    
    print("Enter Quantity:")
    let qty = Int(readLine() ?? "1") ?? 1
    
    let medicine = Medicine(
        medicineName: medName,
        medicineType: selectedType,
        quantity: qty,
        pricePerUnit: price
    )
    
    bill.medicines.append(medicine)
    
    // Print updated bill
    print("\n--- Current Bill ---")
    for m in bill.medicines {
        print("\(m.medicineName) | Qty: \(m.quantity) | Total: ₹\(m.totalPrice)")
    }
    
    print("Current Total Bill: ₹\(bill.totalBill)")
    
    print("\nAdd more medicines? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueBilling = false
    }
}

// Final Bill
print("\n===== BILL GENERATED =====")
print("Bill ID: \(bill.billID)")
print("Patient Name: \(bill.patientName)")
print("Total Bill: ₹\(bill.totalBill)")
