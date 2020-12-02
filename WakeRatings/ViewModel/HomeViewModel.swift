//
//  HomeViewModel.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/13/20.
//

import Firebase
import FirebaseFirestoreSwift

class HomeViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    @Published var allReviews: [Review] = []
    @Published var recentReviews: [Review] = []
    @Published var topReviews: [Review] = []
    
    init() {
        fetchReviews()
    }
    
    func fetchReviews() {
        db.collection("Reviews").order(by: "timestamp", descending: true).addSnapshotListener { (snap, error) in
            guard let reviewData = snap else { return }
            self.allReviews = reviewData.documents.compactMap({ (document) -> Review? in
                return try! document.data(as: Review.self)
            })
        }
        
        for review in allReviews {
            if review.review != "" {
                recentReviews.append(review)
            }
        }
    }
}
