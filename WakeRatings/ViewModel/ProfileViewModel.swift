//
//  ProfileViewModel.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/24/20.
//

import Firebase
import FirebaseFirestoreSwift

class ProfileViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var allReviews: [Review] = []
    @Published var myReviews: [Review] = []
    
    var courses: [Course] = []
    var myCourseIDs: [String] = []
    
    @Published var myGrades: [Grade] = []
    @Published var professorGrade: Float = 0.0
    var sum: Float = 0.0
    
    func fetchReviews(professorId: String) {
        db.collection("myReviews").document(professorId).collection("reviews").addSnapshotListener { (snap, error) in
            guard let reviewData = snap else { return }
            self.allReviews = reviewData.documents.compactMap({ (document) -> Review? in
                return try! document.data(as: Review.self)
            })
        }
        
        for review in allReviews {
            if review.review != "" {
                myReviews.append(review)
            }
        }
    }
    
    func getCourses(professorId: String) {
        db.collection("Professors").document(professorId).getDocument { (document, error) in
            if let document = document, document.exists {
                
                // Get the professor's data -- we specifically want the course IDs
                let professor = try! document.data(as: Professor.self)
                
                // Add the professor's course IDs to an array
                for course in professor!.courses {
                    self.myCourseIDs.append(course)
                    
                    // Add the courses to an array
                    self.fetchCourses(courseId: course)
                }
            } else {
                print("Error: Professor does not exist!")
            }
        }
    }
    
    func fetchCourses(courseId: String) {
        db.collection("Courses").document(courseId).getDocument { (document, error) in
            if let document = document, document.exists {
                let course = try! document.data(as: Course.self)
                self.courses.append(course!)
            } else {
                print("Error: Course does not exist!")
            }
        }
    }
    
    func getGrades(professorId: String) {
        db.collection("myGrades").document(professorId).collection("ratings").getDocuments { (snap, error) in
            guard let grades = snap else { return }
            self.myGrades = grades.documents.compactMap({ (document) -> Grade? in
                return try! document.data(as: Grade.self)
            })
            
            if self.myGrades.count != 0 {
                // Add the professor's course IDs to an array
                for grade in self.myGrades {
                    self.sum += Float(grade.rating)
                }
                
                self.professorGrade = self.sum / Float(self.myGrades.count)
                
                /* Update and add rating to average rating */
                self.db.collection("Professors").document(professorId).updateData(["avgRate" : self.professorGrade])
            }
        }
    }
}
