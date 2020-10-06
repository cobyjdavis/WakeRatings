//
//  ReviewCell.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct ReviewCell: View {
    
    var image: String
    var name: String
    var rating: Int
    var review: String
    var date: String
    var likeCount: String
    var dislikeCount: String
    
    func starColor(rating: Int) -> Color {
        if rating < 3 {
            return Color.red
        } else if rating > 3 {
            return Color.green
        } else {
            return Color.yellow
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(image).resizable().renderingMode(.original).frame(width: 40, height: 40).clipShape(Circle()).shadow(radius: 10)
                Text(name).foregroundColor(.black).font(Font.title.bold())
                Spacer()
                
                // Rating(Stars)
                HStack(spacing: 2) {
                    ForEach(0..<rating) {_ in
                        Image(systemName: "star.fill").foregroundColor(starColor(rating: rating)).font(Font.callout.bold())
                    }
                }
            }
            
            // The user's review
            HStack {
                Text(review).foregroundColor(.black).font(Font.custom("RockoFLF-Bold", size: 18)).lineLimit(nil)
                Spacer()
            }
            
            // Review information - Date submitted and Popularity
            HStack {
                // Date
                Text(date).font(Font.custom("RockoFLF-Bold", size: 14)).foregroundColor(.gray)
                Spacer()
                // Like Button
                Button(action: {}, label: {
                    Image(systemName: "hand.thumbsup.fill").foregroundColor(.gray).font(Font.callout.bold())
                })
                Text(likeCount).foregroundColor(.black).font(Font.custom("RockoFLF-Bold", size: 14))
                
                // Dislike Button
                Button(action: {}, label: {
                    Image(systemName: "hand.thumbsdown.fill").foregroundColor(.gray).font(Font.callout.bold())
                })
                Text(dislikeCount).foregroundColor(.black).font(Font.custom("RockoFLF-Bold", size: 14))
            }.padding(.top, 5)
        }.padding(.horizontal).padding(.top)
    }
}

//struct ReviewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewCell()
//    }
//}
