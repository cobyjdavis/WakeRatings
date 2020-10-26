//
//  SearchViewModel.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/22/20.
//

import Firebase
import FirebaseFirestoreSwift

class SearchViewModel: ObservableObject {
    
    @Published var data: [Any] = []
    
    let db = Firestore.firestore()
    
    init() {
        searchCourses()
        searchProfessors()
    }
    
    func searchCourses() {
        db.collection("Courses").getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                print("Error fetching data")
                return
            }
            
            for document in snap.documents {
                guard let course = try! document.data(as: Course.self) else { return }
                self.data.append(course)
            }
        }
    }
    
    func searchProfessors() {
        db.collection("Professors").getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                print("Error fetching data")
                return
            }
            
            for document in snap.documents {
                guard let professor = try! document.data(as: Professor.self) else { return }
                self.data.append(professor)
            }
        }
    }
}

