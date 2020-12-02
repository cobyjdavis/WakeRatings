//
//  ClassRankings.swift
//  WakeRatings
//
//  Created by Andrew S on 12/2/20.
//

import SwiftUI

struct ClassRankings: View {
    var body: some View {
        VStack{
        VStack {
            
            List(classRankingList) { classRankingList in
                NavigationLink(destination: ProfessorDetailView11(data11: AllData(professorName: classRankingList.name, professorId: "00ebw", courseName: "Computer Science 391", courseId: "XcCtF", accronym: classRankingList.reviewNumber, courseNum: "119", hours: "3"))) {
                    classRankRow(classRank1: classRankingList)
                }
            }
        }
        
        }.navigationBarTitle(Text("Top 10 Teachers"), displayMode: .inline)
    }
}

struct ClassRankings_Previews: PreviewProvider {
    static var previews: some View {
        ClassRankings()
    }
}

struct classRankRow: View {
    
    let classRank1: ClassListRank
    
    var body: some View {
        HStack {
            Image(classRank1.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(50)
            VStack(alignment: .leading) {
                Text(classRank1.name)
                    .font(.system(size: 21, weight: .medium, design: .default))
                Text(classRank1.averageRating)
            }
        }
    }
}
