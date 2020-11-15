//
//  Review.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/13/20.
//

import Firebase
import FirebaseFirestoreSwift

struct Review: Codable {
    var id: String
    var timestamp: String
    var type: String
    var professorId: String
    var professorName: String
    var courseId: String
    var courseName: String
    var review: String
    var rating: Int
    var likeCount: Int
    var dislikeCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case type
        case professorId
        case professorName
        case courseId
        case courseName
        case review
        case rating
        case likeCount
        case dislikeCount
    }
}
