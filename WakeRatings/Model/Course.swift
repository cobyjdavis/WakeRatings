//
//  Course.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/18/20.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Course: Decodable, Hashable {
    var courseId: String
    var courseName: String
    var accronym: String
    var courseNum: String
    var hours: String
    var avgRate: [Int]
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case courseId
        case courseName
        case accronym
        case courseNum
        case hours
        case avgRate
        case type
    }
}
