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
    @Published var myReviews: [Review] = []
    @Published var grades: [Int] = []
    @Published var avgRating: Int = 0
    
    func fetchReviews(professorId: String) {
        db.collection("myReviews").document(professorId).collection("reviews").addSnapshotListener { (snap, error) in
            guard let reviewData = snap else { return }
            self.myReviews = reviewData.documents.compactMap({ (document) -> Review? in
                return try! document.data(as: Review.self)
            })
        }
    }
    
    func calcuateGrade()-> Int {
        for review in myReviews {
            self.grades.append(review.rating)
        }
        
        if grades.count != 0 {
            for grade in grades {
                avgRating += grade
            }
        }
        return avgRating
    }
}
