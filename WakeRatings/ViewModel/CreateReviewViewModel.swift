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
        
        let reviewId = ref.collection("Reviews").document().documentID // Generate a document ID
        
        let review = Review(id: reviewId, timestamp: timestamp, type: type, professorId: professorId, professorName: professorName, courseId: courseId, courseName: courseName, review: review, rating: rating, likeCount: likeCount, dislikeCount: dislikeCount)
        
        /* Add review to 'Reviews' collection */
        let _ = try! db.collection("Reviews").document(reviewId).setData(from: review) { (error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
        }
        
        /* Add review to myReviews collection */
        let _ = try! db.collection("myReviews").document(professorId).collection("reviews").document(reviewId).setData(from: review) { (error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
        }
        
        /* Update and add rating to average ratings */
        db.collection("Professors").document(professorId).updateData(["avgRate" : FieldValue.arrayUnion([rating])])
    }
}
