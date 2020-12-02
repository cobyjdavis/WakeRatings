//
//  Contact.swift
//  WakeRatings
//
//  Created by Andrew S on 11/2/20.
//

import Foundation
import SwiftUI

struct Contacts: Identifiable {
    let imageName: String
    let name: String
    let phone: String
    let email: String
    let address: String
    let id = UUID()
}
struct ClassListRank: Identifiable {
    let imageName: String
    let name: String
    let averageRating: String
    let reviewNumber: String
    let id = UUID()
}



let contact2test = [
AllData(professorName: "Bill Yee", professorId: "YAX3t", courseName: "JIM", courseId: "3", accronym: "2", courseNum: "1", hours: "0")

]



let contacts = [
    Contacts(imageName: "who", name: "Raina Haque", phone: "4.92", email: "3", address: "ENT"),
    Contacts(imageName: "who", name: "Abby Wright", phone: "4.83", email: "1", address: "HES"),
    Contacts(imageName: "who", name: "John Clift", phone: "4.80", email: "2", address: "BEM"),
    Contacts(imageName: "who", name: "Ke Zhang", phone: "4.75", email: "1", address: "BMB"),
    Contacts(imageName: "who", name: "Meghan Belanger", phone: "4.66", email: "3", address: "HES"),
    Contacts(imageName: "who", name: "Melissa Jenkins", phone: "4.5", email: "2", address: "ENG"),
    Contacts(imageName: "who", name: "Paul Anderson", phone: "4.5", email: "1", address: "PHY"),
    Contacts(imageName: "who", name: "Rebecca Morrow", phone: "4.5", email: "1", address: "LAW"),
    Contacts(imageName: "who", name: "Paul Garber", phone: "4.42", email: "1", address: "COM"),
    Contacts(imageName: "who", name: "Rebecca Thomas", phone: "4.40", email: "2", address: "GES"),
]

let classRankingList = [
    ClassListRank(imageName: "who", name: "Computer Science 111", averageRating: "Average Rating: 5", reviewNumber: "CSC"),
    ClassListRank(imageName: "who", name: "Accounting 212", averageRating: "Average Rating: 4.88", reviewNumber: "ACC"),
    ClassListRank(imageName: "who", name: "HES 101", averageRating: "Average Rating: 4.62", reviewNumber: "HES"),
    ClassListRank(imageName: "who", name: "Finance 335", averageRating: "Average Rating: 4.61", reviewNumber: "FIN"),
    ClassListRank(imageName: "who", name: "Chemistry 204", averageRating: "Average Rating: 4.25", reviewNumber: "CHE"),
    ClassListRank(imageName: "who", name: "Introduction to statistics", averageRating: "Average Rating: 4.20", reviewNumber: "MST"),
    ClassListRank(imageName: "who", name: "Biology 111", averageRating: "Average Rating: 4.20", reviewNumber: "BIO"),
    ClassListRank(imageName: "who", name: "Finance 111", averageRating: "Average Rating: 4.12", reviewNumber: "FIN"),
    ClassListRank(imageName: "who", name: "Mathematics 111", averageRating: "Average Rating: 3.9", reviewNumber: "MST"),
    ClassListRank(imageName: "who", name: "English 111", averageRating: "Average Rating: 3.87", reviewNumber: "ENG")
]

