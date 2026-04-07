import Foundation

// Enum for Course Level
enum CourseLevel {
    case beginner
    case intermediate
    case advanced
}

// Struct for Course
struct Course {
    var courseName: String
    var instructor: String
    var level: CourseLevel
    var fee: Int
}

// Struct for Enrollment
struct Enrollment {
    static var currentID = 0
    
    var enrollmentID: Int
    var studentName: String
    var courses: [Course]
    
    var totalFee: Int {
        return courses.reduce(0) { $0 + $1.fee }
    }
    
    init(studentName: String) {
        Enrollment.currentID += 1
        self.enrollmentID = Enrollment.currentID
        self.studentName = studentName
        self.courses = []
    }
}

// MARK: - Main Program

print("Enter Student Name:")
let student = readLine() ?? "Student"

var enrollment = Enrollment(studentName: student)

var continueEnrollment = true

while continueEnrollment {
    
    print("\nEnter Course Name:")
    let courseName = readLine() ?? ""
    
    print("Enter Instructor Name:")
    let instructor = readLine() ?? ""
    
    print("Choose Level: 1. Beginner  2. Intermediate  3. Advanced")
    let levelInput = Int(readLine() ?? "1") ?? 1
    
    var selectedLevel: CourseLevel
    var fee = 0
    
    switch levelInput {
    case 1:
        selectedLevel = .beginner
        fee = 999
    case 2:
        selectedLevel = .intermediate
        fee = 1999
    case 3:
        selectedLevel = .advanced
        fee = 3499
    default:
        selectedLevel = .beginner
        fee = 999
    }
    
    let course = Course(
        courseName: courseName,
        instructor: instructor,
        level: selectedLevel,
        fee: fee
    )
    
    enrollment.courses.append(course)
    
    // Print enrolled courses
    print("\n--- Enrolled Courses ---")
    for c in enrollment.courses {
        print("\(c.courseName) | Instructor: \(c.instructor) | Fee: ₹\(c.fee)")
    }
    
    print("Current Total Fee: ₹\(enrollment.totalFee)")
    
    print("\nEnroll in more courses? (yes/no)")
    let choice = readLine()?.lowercased()
    
    if choice != "yes" {
        continueEnrollment = false
    }
}

// Final Output
print("\n===== ENROLLMENT COMPLETE =====")
print("Enrollment ID: \(enrollment.enrollmentID)")
print("Student Name: \(enrollment.studentName)")
print("Total Fee: ₹\(enrollment.totalFee)")
