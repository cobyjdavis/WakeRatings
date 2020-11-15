//
//  ReviewViewModel.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/27/20.
//
import Firebase
import FirebaseFirestoreSwift

class ReviewViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    func likeReview(reviewId: String, updateLikeCount: Int) {
       db.collection("Reviews").document(reviewId).updateData(["likeCount" : updateLikeCount])
    }
    
    func dislikeReview(reviewId: String, updateDislikeCount: Int) {
        db.collection("Reviews").document(reviewId).updateData(["dislikeCount" : updateDislikeCount])
    }
}
