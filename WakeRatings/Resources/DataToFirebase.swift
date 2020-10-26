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
var allData: [AllData] = load("WRData.json")

func uploadData() {
    for (index, data) in allData.enumerated() {
        /* Add the first object to the database */
        if index == 0 {
            // Make a professors collection on the database
            ref.collection("Professors").document(data.professorId).setData(
                ["professorName" : data.professorName,
                 "professorId" : data.professorId,
                 "courses" : [data.courseId],
                 "avgRate" : [], // Empty array and will append all ratings of a professor
                 "type" : "PROFESSOR"
                ])
        }
        
        /* Check if the current object's professor Id is equal to the previous. If so, uupdate tbe courses array by appending the course */
        else if data.professorId == allData[index - 1].professorId {
            /* Add courseId to courses array */
            ref.collection("Professors").document(data.professorId).updateData(["courses" : FieldValue.arrayUnion([data.courseId])])
        } else {
            // Make a professors collection on the database
            ref.collection("Professors").document(data.professorId).setData(
                ["professorName" : data.professorName,
                 "professorId" : data.professorId,
                 "courses" : [data.courseId],
                 "avgRate" : [], // Empty array and will append all ratings of a professor
                 "type" : "PROFESSOR"
                ])
        }
        
        // Make a courses collection on the database
        ref.collection("Courses").document(data.courseId).setData(
            ["courseName" : data.courseName,
             "accronym" : data.accronym,
             "courseNum" : data.courseNum,
             "courseId" : data.courseId,
             "hours" : data.hours,
             "professorId" : data.professorId,
             "avgRate" : [], // Empty array and will append all ratings of a course
             "type" : "COURSE"
            ])
    }
}



