//
//  CreateReview.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct CreateReview3: View {

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
                    Image(systemName: "xmark").foregroundColor(.white).font(Font.body.bold()).padding().background(Color.red.opacity(0.9)).clipShape(Circle())
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
                .onTapGesture {
                    self.hideKeyboard()
                }

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

struct CreateReview2: View {
    
    @State var searching = false
    @State var rating = 0
    @State var review = "Write your review"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Create a Review").font(Font.custom("RockoFLF-Bold", size: 38)).foregroundColor(.black)
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "xmark").foregroundColor(.white).font(Font.title3.bold()).padding(12).background(Color.red.opacity(0.9)).clipShape(Circle())
                    })
                }.padding(.bottom)
                
                // Choose course or professor to rate and give rating
                HStack(alignment: .top) {
                    VStack {
                        Button(action: {}, label: {
                            Image("who").resizable().frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        })
                        //Text("Dr. Professor").font(Font.custom("RockoFLF-Bold", size: 14)).foregroundColor(.black)
                    }
                    
                    VStack(alignment: .leading) {
                        Rater2(rating: $rating)
                        multilineTextField(txt: $review)
                    }
                    
                    Spacer()
                }.padding(.bottom)
                Spacer()
            }.padding()
        }
    }
}

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
                    CreateReviewHeader(sectionName: "Review Title (Click icon to select)")
                    
                    HStack {
                        if !reviewSubject {
                            HStack(alignment: .top) {
                                Button(action: { chooseSubject() }, label: {
                                    Image("who").resizable().frame(width: 80, height: 80, alignment: .center)
                                })
                                Text("Choose a course, professor, etc...").font(Font.custom("RockoFLF-Bold", size: 25)).foregroundColor(.black).fontWeight(.bold).lineLimit(2).frame(height: 80)
                            }
                        } else {
                            Text("Dr. Professor").font(Font.custom("RockoFLF-Bold", size: 44)).foregroundColor(.black).fontWeight(.bold)
                        }
                        Spacer()
                    }
                    
                    Divider()
                    
                    // Give a rating
                    CreateReviewHeader(sectionName: "What's your Rate?")
                    
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
