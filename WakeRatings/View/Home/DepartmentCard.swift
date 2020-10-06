//
//  DepartmentCard.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct DepartmentCard: View {
    
    var department: Department
    var minX: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [department.color1, department.color2.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 230, height: 270).cornerRadius(20)
            
            VStack {
                HStack {
                    Text(department.courseName).foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 30)).shadow(radius: 5).lineLimit(2).fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding()
                Spacer()
                Image(department.image).resizable().renderingMode(.original).frame(width: department.imageWidth, height: department.imageHeight).clipped().shadow(radius: 10)
            }
        }.frame(width: 230, height: 270)
        .scaleEffect(minX < 0 ? minX / 1000 + 1 : 1)
        .offset(x: minX < 16 ? -minX + 16 : 1)
        .opacity(minX < 0 ? Double(minX / 200 + 1) : 1)
    }
}

struct DepartmentCard_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentCard(department: Department(id: "science", color1: Color.blue, color2: Color.green, courseName: "Science", image: "bio", imageWidth: 230, imageHeight: 270), minX: 30)
    }
}
