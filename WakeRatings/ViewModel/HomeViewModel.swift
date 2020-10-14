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
    @Published var recentReviews: [Review] = []
    
    init() {
        fetchReviews()
    }
    
    func fetchReviews() {
        db.collection("Reviews").order(by: "timestamp", descending: true).addSnapshotListener { (snap, error) in
            guard let reviewData = snap else { return }
            self.recentReviews = reviewData.documents.compactMap({ (document) -> Review? in
                return try! document.data(as: Review.self)
            })
        }
    }
}
