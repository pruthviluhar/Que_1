import Foundation

// Enum for Subject Level
enum SubjectLevel {
    case school
    case undergraduate
    case competitive
}

// Struct for Tutoring Session
struct TutoringSession {
    var subjectName: String
    var tutorName: String
    var subjectLevel: SubjectLevel
    var sessions: Int
    var feePerSession: Int
    
    var totalFee: Int {
        return feePerSession * sessions
    }
}

// Struct for Tutoring Enrollment
struct TutoringEnrollment {
    static var currentID = 0
    
    var enrollmentID: Int
    var studentName: String
    var subjects: [TutoringSession]
    
    var grandTotal: Int {
        return subjects.reduce(0) { $0 + $1.totalFee }
    }
    
    init(studentName: String) {
        TutoringEnrollment.currentID += 1
        self.enrollmentID = TutoringEnrollment.currentID
        self.studentName = studentName
        self.subjects = []
    }
}

// MARK: - Main Program

print("Enter Student Name:")
let name = readLine() ?? "Student"

var enrollment = TutoringEnrollment(studentName: name)

var continueEnrollment = true

while continueEnrollment {
    
    print("\nEnter Subject Name:")
    let subject = readLine() ?? ""
    
    print("Enter Tutor Name:")
    let tutor = readLine() ?? ""
    
    print("Choose Level: 1. School  2. Undergraduate  3. Competitive")
    let levelInput = Int(readLine() ?? "1") ?? 1
    
    var selectedLevel: SubjectLevel
    var fee = 0
    
    switch levelInput {
    case 1:
        selectedLevel = .school
        fee = 200
    case 2:
        selectedLevel = .undergraduate
        fee = 500
    case 3:
        selectedLevel = .competitive
        fee = 900
    default:
        selectedLevel = .school
        fee = 200
    }
    
    print("Enter Number of Sessions:")
    let sessionCount = Int(readLine() ?? "1") ?? 1
    
    let tutoring = TutoringSession(
        subjectName: subject,
        tutorName: tutor,
        subjectLevel: selectedLevel,
        sessions: sessionCount,
        feePerSession: fee
    )
    
    enrollment.subjects.append(tutoring)
    
    // Print enrolled subjects
    print("\n--- Enrolled Subjects ---")
    for s in enrollment.subjects {
        print("\(s.subjectName) (Tutor: \(s.tutorName)) | Sessions: \(s.sessions) | Fee: ₹\(s.totalFee)")
    }
    
    print("Current Grand Total: ₹\(enrollment.grandTotal)")
    
    print("\nAdd more subjects? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueEnrollment = false
    }
}

// Final Output
print("\n===== ENROLLMENT CONFIRMED =====")
print("Enrollment ID: \(enrollment.enrollmentID)")
print("Student Name: \(enrollment.studentName)")
print("Grand Total: ₹\(enrollment.grandTotal)")
