//
//  ContentView.swift
//  WakeRatings
//
//  Created by CJ Davis on 9/23/20.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var departmentData = [
    Department(id: "business", color1: Color.orange, color2: Color.yellow, courseName: "Business", image: "business", imageWidth: 230, imageHeight: 180),
    Department(id: "lit", color1: Color.blue, color2: Color.purple, courseName: "Literature", image: "lit1", imageWidth: 210, imageHeight: 180),
    Department(id: "math", color1: Color.red, color2: Color.red, courseName: "Mathematics", image: "math", imageWidth: 210, imageHeight: 180),
    Department(id: "bio", color1: Color.blue, color2: Color.green, courseName: "Biology", image: "bio", imageWidth: 210, imageHeight: 180),
    Department(id: "cs", color1: Color.black, color2: Color.white, courseName: "Computer Science", image: "cs", imageWidth: 230, imageHeight: 180),
    Department(id: "sports", color1: Color.yellow, color2: Color.red, courseName: "Sports", image: "sports", imageWidth: 230, imageHeight: 180),
    Department(id: "pit", color1: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)), color2: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), courseName: "The Pit", image: "food", imageWidth: 230, imageHeight: 140)
]

