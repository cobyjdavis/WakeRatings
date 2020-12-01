//
//  Grade.swift
//  WakeRatings
//
//  Created by CJ Davis on 11/18/20.
//

import Firebase
import FirebaseFirestoreSwift

struct Grade: Codable {
    var rating: Int
    
    enum CodingKeys: String, CodingKey {
        case rating 
    }
}
