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
        //Search()
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

struct ReviewPage: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Reviews & Ratings").font(Font.custom("RockoFLF-Bold", size: 32))
                Spacer()
            }.padding(.horizontal).padding(.top, 40).cornerRadius(25)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: -10) {
                    ReviewCard(color: Color.green)
                    ReviewCard(color: Color.orange)
                    ReviewCard(color: Color.red)
                }
            }
        }.padding(.top).edgesIgnoringSafeArea(.all)
    }
}
struct ReviewCard: View {
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Review header - Who or what is the review of and the rating provided
            HStack {
                Image("profImg").resizable().renderingMode(.original).frame(width: 40, height: 40).clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 2.5)).shadow(radius: 5)
                Text("Dr. Canas").foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 24)).shadow(radius: 5)
                Spacer()
                
                // Rating(Stars)
                HStack(spacing: 2) {
                    ForEach(0..<5) {_ in
                        Image(systemName: "star.fill").foregroundColor(.yellow).font(Font.callout.bold()).shadow(radius: 5)
                    }
                }
            }
            
            // The user's review
            Text("The best professor you can have! Everyone gets an A+. My average test score was 57 but Dr. Canas still gave me an A.").foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 18)).lineLimit(5).frame(height: 110, alignment: .top).shadow(radius: 5)
            
            // Review information - Date submitted and Popularity
            HStack {
                // Date
                Text("Feb 12, 2020").font(Font.custom("RockoFLF-Bold", size: 14)).foregroundColor(.white).shadow(radius: 5)
                Spacer()
                // Like Button
                Button(action: {}, label: {
                    Image(systemName: "hand.thumbsup.fill").foregroundColor(.white).font(Font.callout.bold())
                }).shadow(radius: 5)
                Text("370").foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 14)).shadow(radius: 5)
                
                // Dislike Button
                Button(action: {}, label: {
                    Image(systemName: "hand.thumbsdown.fill").foregroundColor(.white).font(Font.callout.bold())
                }).shadow(radius: 5)
                Text("2").foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 14)).shadow(radius: 5)
            }
        }.padding().background(LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(25).padding()
    }
}

