//
//  Course.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/14/20.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct AllData: Decodable, Hashable {
    var professorName: String
    var professorId: String
    var courseName: String
    var courseId: String
    var accronym: String
    var courseNum: String
    var hours: String
    
    enum CodingKeys: String, CodingKey {
        case professorName
        case professorId
        case courseName
        case courseId
        case accronym
        case courseNum
        case hours
    }
}
