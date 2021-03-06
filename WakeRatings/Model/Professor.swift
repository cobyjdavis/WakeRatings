//
//  Professor.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/18/20.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Professor: Decodable, Hashable {
    var professorId: String
    var professorName: String
    var courses: [String]
    var avgRate: Float
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case professorId
        case professorName
        case courses
        case avgRate
        case type
    }
}

