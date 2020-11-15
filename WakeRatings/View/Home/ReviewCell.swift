//
//  ReviewCell.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI
import Firebase

struct ReviewCell: View {
    
    @StateObject var reviewViewModel = ReviewViewModel()
    @ObservedObject var reviewLikes = ReviewLikes()
    var image: String
    var review: Review
    
    func starColor(rating: Int) -> Color {
        if rating == 1 {
            return Color.red
        } else if rating > 3 {
            return Color.green
        } else if rating == 2 {
            return Color.orange
        } else {
            return Color.yellow
        }
    }
    
    func likeReview() {
        reviewLikes.isLiked.toggle()
        
        if reviewLikes.isLiked {
            reviewViewModel.likeReview(reviewId: review.id, updateLikeCount: review.likeCount + 1)
        } else {
            reviewViewModel.likeReview(reviewId: review.id, updateLikeCount: review.likeCount - 1)
        }
    }
    
    func dislikeReview() {
        reviewLikes.isDisliked.toggle()
        
        if reviewLikes.isDisliked {
            reviewViewModel.dislikeReview(reviewId: review.id, updateDislikeCount: review.dislikeCount + 1)
        } else {
            reviewViewModel.dislikeReview(reviewId: review.id, updateDislikeCount: review.dislikeCount - 1)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(image).resizable().renderingMode(.original).frame(width: 40, height: 40).clipShape(Circle())
                Text(review.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).foregroundColor(.black).font(Font.title.bold())
                Spacer()
                
                // Rating(Stars)
                HStack(spacing: 2) {
                    ForEach(0..<review.rating) {_ in
                        Image(systemName: "star.fill").foregroundColor(starColor(rating: review.rating)).font(Font.callout.bold())
                    }
                }
            }
            
            // The user's review
            HStack {
                Text(review.review).foregroundColor(.black).font(Font.custom("RockoFLF-Bold", size: 18)).lineLimit(nil)
                Spacer()
            }
            
            // Review information - Date submitted and Popularity
            HStack {
                // Date
                Text(review.timestamp).font(Font.custom("RockoFLF-Bold", size: 14)).foregroundColor(.gray)
                Spacer()
                // Like Button
                Button(action: { }, label: {
                    Image(systemName: "hand.thumbsup.fill").foregroundColor(self.reviewLikes.isLiked ? Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)) : .gray).font(Font.callout.bold())
                })
                Text("\(review.likeCount)").foregroundColor(.black).font(Font.custom("RockoFLF-Bold", size: 14))
                
                // Dislike Button
                Button(action: { }, label: {
                    Image(systemName: "hand.thumbsdown.fill").foregroundColor(self.reviewLikes.isDisliked ? Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)) : .gray).font(Font.callout.bold())
                })
                Text("\(review.dislikeCount)").foregroundColor(.black).font(Font.custom("RockoFLF-Bold", size: 14))
            }.padding(.top, 5)
        }.padding(.horizontal).padding(.top)
    }
}

struct ReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCell(image: "who", review: Review(id: "", timestamp: "Oct. 27, 2020 at 7: 23 pm", type: "PROFESSOR", professorId: "", professorName: "Rachel Conway", courseId: "", courseName: "", review: "This is a review", rating: 2, likeCount: 0, dislikeCount: 0))
    }
}

class ReviewLikes: ObservableObject {
    
    @Published var isLiked: Bool {
        didSet {
            UserDefaults.standard.set(isLiked, forKey: "isReviewLiked")
        }
    }
    
    @Published var isDisliked: Bool {
        didSet {
            UserDefaults.standard.set(isDisliked, forKey: "isReviewDisliked")
        }
    }
    
    init() {
        self.isLiked = UserDefaults.standard.object(forKey: "isReviewLiked") as? Bool ?? false
        self.isDisliked = UserDefaults.standard.object(forKey: "isReviewDisliked") as? Bool ?? false
    }
}
