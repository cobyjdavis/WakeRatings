//
//  CreateReview.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct CreateReview: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var createReviewViewModel = CreateReviewViewModel()
    @Binding var createReviewOpen: Bool
    @State private var review = "Write your review"
    @State private var emptyReviewError = false
    @State var ratings = 0
    @State var showingRater = false
    @State var submitted = false
    @State var maxWidth = UIScreen.main.bounds.width - 100
    @State var offset: CGFloat = 0

    let currentDateTime = Date()
    let formatter = DateFormatter()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Create a Review").font(Font.custom("RockoFLF-Bold", size: 38))
                Spacer()
                Button(action: {self.createReviewOpen = false}, label: {
                    Image(systemName: "xmark").foregroundColor(.white).font(Font.body.bold()).padding().background(Color.red.opacity(0.6)).clipShape(Circle())
                })
            }.padding(.bottom)

            // Choose a person, place or thing to rate
            HStack {
                Text("1. What are you rating?").font(Font.custom("RockoFLF-Bold", size: 27))
                Image("who").resizable().frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
            }.padding(.bottom)

            HStack {
                Text("2. Give a rating").font(Font.custom("RockoFLF-Bold", size: 27))
                Image("review").resizable().frame(width: 140, height: 100, alignment: .center)
                Spacer()
            }

            // Feedback Display
            if self.showingRater {
                Rater(ratings: $ratings, showingRater: $showingRater, sumbitted: $submitted)
                    .padding(.top, 10)
                    .animation(.spring())
            } else {

                Button(action: {
                    self.showingRater.toggle()
                }) {

                    HStack(spacing: 3) {
                        Text(submitted ? "You Rated Dr. Canas: \(self.ratings)" : "Add More Stars: 0")
                            .foregroundColor(.white)
                            .font(Font.custom("RockoFLF-Bold", size: 16))

                        Image(systemName: "star.fill").foregroundColor(.yellow)
                            //.shadow(radius: 3)
                    }.padding()
                    .background(Color.black)
                        .font(.headline)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                }.padding(.top, 10)
            }

            HStack {
                Text("3. Add further thoughts").font(Font.custom("RockoFLF-Bold", size: 27))
                Spacer()
            }.padding(.top, 5)

            multilineTextField(txt: $review)

            Spacer()

            HStack {
                
                Button(action: {
                    
                    // Get current time and date
                    self.formatter.dateStyle = .medium
                    self.formatter.timeStyle = .short
                    
                    self.createReviewViewModel.createReview(timestamp: self.formatter.string(from: self.currentDateTime), type: "PROF", professorId: "01512", professorName: "Dr. Canas", courseId: "40295", courseName: "CSC 321", review: review, rating: ratings, likeCount: 0, dislikeCount: 0)
                    
                    self.createReviewOpen = false
                }, label: {
                    Text("Post Review").font(Font.custom("RockoFLF-Bold", size: 20)).foregroundColor(.white).padding(20).background(Color.black).clipShape(Capsule())
                })
            }
        }.padding().navigationBarTitle("", displayMode: .inline).navigationBarHidden(true).accentColor(.black)
    }
    
    func calculateWidth()-> CGFloat {
        let percent = offset / maxWidth
        return percent * maxWidth
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width > 0 && offset <= maxWidth - 65 {
            offset = value.translation.width
        }
        
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(Animation.easeOut(duration: 0.3)) {
            if offset > 180 {
                offset = maxWidth - 65
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                }
            } else {
                offset = 0
            }
        }
    }
}


struct CreateReview_Previews2: PreviewProvider {
    static var previews: some View {
        CreateReview(createReviewOpen: .constant(true))
    }
}
