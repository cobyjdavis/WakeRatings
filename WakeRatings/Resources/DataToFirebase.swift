//
//  DataToFirebase.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/18/20.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

let ref = Firestore.firestore()
var allData: [AllData] = load("WakeRatingsData.json")

func uploadData() {
    for (index, data) in allData.enumerated() {
        if index == 0 {
            print("First data ignored.")
        }
        else if data.professorId == allData[index - 1].professorId {
            // Add courseId to courses array
            ref.collection("Professors").document(data.professorId).updateData(["courses" : FieldValue.arrayUnion([data.courseId])])
        } else {
            // Make a professors collection on the database
            ref.collection("Professors").document(data.professorId).setData(["professorName" : data.professorName, "professorId" : data.professorId, "courses" : [data.courseId]])
        }
        
        if index > 0 {
            // Make a courses collection on the database
            ref.collection("Courses").document(data.courseId).setData(["courseName" : data.courseName, "accronym" : data.accronym, "courseNum" : data.courseNum, "courseId" : data.courseId, "hours" : data.hours, "professorId" : data.professorId])
        }
    }
}

//func jsonParser() -> [AllData] {
//    let url = Bundle.main.url(forResource: "WakeRatingsData", withExtension: "json")!
//    let data = try! Data(contentsOf: url)
//    let decoder = JSONDecoder()
//    let allData = try? decoder.decode([AllData].self, from: data)
//    print(allData!)
//    return allData!
//}



