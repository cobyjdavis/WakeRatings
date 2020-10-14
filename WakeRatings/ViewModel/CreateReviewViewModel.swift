//
//  CreateReviewViewModel.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/13/20.
//

import Firebase
import FirebaseFirestoreSwift

class CreateReviewViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    func createReview(timestamp: String, type: String, professorId: String, professorName: String, courseId: String, courseName: String, review: String, rating: Int, likeCount: Int, dislikeCount: Int) {
        
        let review = Review(timestamp: timestamp, type: type, professorId: professorId, professorName: professorName, courseId: courseId, courseName: courseName, review: review, rating: rating, likeCount: likeCount, dislikeCount: dislikeCount)
        
        let _ = try! db.collection("Reviews").addDocument(from: review) { (error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            
        }
    }
}
