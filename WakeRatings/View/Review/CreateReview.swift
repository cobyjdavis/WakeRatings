//
//  CreateReview.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct CreateReview: View {
    
    @StateObject var createReviewViewModel = CreateReviewViewModel()
    @Binding var createReviewOpen: Bool
    @State var searching = false
    @State var rating = 0
    @State var review = ""
    @State var reviewSubject = false
    
    let currentDateTime = Date()
    let formatter = DateFormatter()
    
    func closeReviewCreator() {
        self.createReviewOpen = false
    }
    
    func chooseSubject() {
        self.searching.toggle()
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Create a Review").font(Font.custom("RockoFLF-Bold", size: 28)).foregroundColor(.white).shadow(radius: 5)
                Spacer()
                Button(action: { closeReviewCreator() }, label: {
                    Image(systemName: "xmark").foregroundColor(.white).font(Font.title.bold()).shadow(radius: 5)
                    //Text("Cancel").font(Font.custom("RockoFLF-Bold", size: 18)).foregroundColor(Color.white.opacity(0.7)).shadow(radius: 5)
                }).padding(.trailing)
            }.padding()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    
                    // Name of chosen course or professor
                    CreateReviewHeader(sectionName: "Review For...(Click icon to select)")
                    
                    HStack {
                        if !reviewSubject {
                            HStack(alignment: .top) {
                                Button(action: { chooseSubject() }, label: {
                                    Image("who").resizable().frame(width: 80, height: 80, alignment: .center)
                                })
                                Text("Choose a course, professor, place etc...").font(Font.custom("RockoFLF-Bold", size: 25)).foregroundColor(.black).fontWeight(.bold).lineLimit(2).frame(height: 80)
                            }
                        } else {
                            Text("Dr. Professor").font(Font.custom("RockoFLF-Bold", size: 44)).foregroundColor(.black).fontWeight(.bold)
                        }
                        Spacer()
                    }
                    
                    Divider()
                    
                    // Give a rating
                    CreateReviewHeader(sectionName: "What's your rating?")
                    
                    Rater2(rating: $rating)
                    
                    Divider().padding(.top)
                    
                    // Add comments and further thoughts
                    CreateReviewHeader(sectionName: "Add comments")
                    
                    multilineTextField(txt: $review).frame(width: UIScreen.main.bounds.width - 40, height: 300, alignment: .topLeading).padding(5).overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(0.1), lineWidth: 1.5)
                    )
                    
                    HStack {
                        Button(action: {
                            
                            // Get current time and date
                            self.formatter.dateStyle = .medium
                            self.formatter.timeStyle = .short
                            
                            self.createReviewViewModel.createReview(timestamp: self.formatter.string(from: self.currentDateTime), type: "PROF", professorId: "01512", professorName: "Dr. Canas", courseId: "40295", courseName: "CSC 321", review: review, rating: rating, likeCount: 0, dislikeCount: 0)
                            
                            self.createReviewOpen = false
                        }, label: {
                            Text("Post Review").font(Font.custom("RockoFLF-Bold", size: 20)).foregroundColor(.white).shadow(radius: 3).padding(20).background(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))).clipShape(Capsule())
                        })
                    }.padding(.top, 30)
                }.padding().padding(.top, 10)
            }).background(Color.white
                            .clipShape(RoundedCorners(tl: 30, tr: 40, bl: 0, br: 0))
                            .edgesIgnoringSafeArea(.bottom))
        }.background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $searching) {
            ChooseSubjectModal()
        }
    }
}


struct CreateReview_Previews2: PreviewProvider {
    static var previews: some View {
        //CreateReview3(createReviewOpen: .constant(true))
        //CreateReview2()
        CreateReview(createReviewOpen: .constant(true))
        //ChooseSubjectModal()
    }
}

struct CreateReviewHeader: View {
    
    var sectionName: String
    
    var body: some View {
        HStack {
            Text(sectionName).font(Font.custom("RockoFLF-Bold", size: 22)).foregroundColor(.gray).fontWeight(.bold)
            Spacer()
        }
    }
}

struct ChooseSubjectModal: View {
    
    @State var search = ""
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20).fill(Color.gray).frame(width: 45, height: 7, alignment: .center)
            
            SearchBar(text: $search)
            
            Spacer()
        }.padding()
    }
}
