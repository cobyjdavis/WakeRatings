//
//  CreateReview.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct CreateReview: View {
    
    @ObservedObject var review = TextLimiter(limit: 500)
    @StateObject var createReviewViewModel = CreateReviewViewModel()
    @Binding var createReviewOpen: Bool
    @State var choosingSubject = false
    @State var rating = 0
    @State var reviewSubject = false
    @State var blankFieldError = false
    @State var subject = AllData(professorName: "", professorId: "", courseName: "", courseId: "", accronym: "", courseNum: "", hours: "")
    
    let currentDateTime = Date()
    let formatter = DateFormatter()
    
    func postReview() {
        // Get current time and date
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .short
        
        /* Check all fields are filled before posting */
        if rating != 0 && subject.professorName != "" && !review.hasReachedLimit {
            self.createReviewViewModel.createReview(timestamp: self.formatter.string(from: self.currentDateTime), type: "PROFESSOR", professorId: subject.professorId, professorName: subject.professorName, courseId: subject.courseId, courseName: subject.courseName, review: review.value, rating: rating, likeCount: 0, dislikeCount: 0)
            
            closeReviewCreator() // Close the review creator
        } else { // Field is blank
            self.blankFieldError = true // Alert error
        }
    }
    
    func closeReviewCreator() {
        self.createReviewOpen = false
    }
    
    func chooseSubject() {
        self.choosingSubject.toggle()
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Rate & Review").font(Font.custom("RockoFLF-Bold", size: 28)).foregroundColor(.white).shadow(radius: 5)
                Spacer()
                Button(action: { closeReviewCreator() }, label: {
                    Image(systemName: "xmark").foregroundColor(.white).font(Font.title.bold()).shadow(radius: 5)
                    //Text("Cancel").font(Font.custom("RockoFLF-Bold", size: 18)).foregroundColor(Color.white.opacity(0.7)).shadow(radius: 5)
                }).padding(.trailing)
            }.padding()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    
                    // Name of chosen course or professor
                    CreateReviewHeader(sectionName: "Reviewing...(Click icon to select)")
                    
                    HStack {
                        if subject.professorName == "" {
                            HStack(alignment: .top) {
                                Button(action: { chooseSubject() }, label: {
                                    Image("who").resizable().frame(width: 60, height: 60, alignment: .center)
                                })
                                Text("Choose a course, professor, place etc...").font(Font.custom("RockoFLF-Bold", size: 25)).foregroundColor(.black).fontWeight(.bold).lineLimit(2).frame(height: 80)
                            }
                        } else {
                            HStack {
                                Button(action: { chooseSubject() }, label: {
                                    Image("who").resizable().frame(width: 60, height: 60, alignment: .center)
                                })
                                Text(subject.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(Font.custom("RockoFLF-Bold", size: 35)).foregroundColor(.black).fontWeight(.bold)
                            }
                        }
                        Spacer()
                    }
                    
                    Divider()
                    
                    // Give a rating
                    CreateReviewHeader(sectionName: "What's your rating?")
                    
                    Rater2(rating: $rating)
                    
                    Divider().padding(.top)
                    
                    // Add comments and further thoughts
                    CreateReviewHeader(sectionName: "Add comments (Optional)")
                    
                    VStack {
                        TextEditor(text: $review.value).frame(width: UIScreen.main.bounds.width - 40, height: 300, alignment: .topLeading).padding(5)
                        HStack {
                            Text("\(review.value.count)/500").foregroundColor(.gray).font(.callout)
                        }
                    }.overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke($review.hasReachedLimit.wrappedValue ? Color.red : Color.black.opacity(0.1), lineWidth: 1.5)
                    )
                    
                    HStack {
                        Button(action: { postReview() }, label: {
                            Text("Post Review").font(Font.custom("RockoFLF-Bold", size: 20)).foregroundColor(.white).shadow(radius: 3).padding(20).background(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))).clipShape(Capsule())
                        })
                    }.padding(.top, 30)
                }.padding().padding(.top, 10)
            }).background(Color.white
                            .clipShape(RoundedCorners(tl: 30, tr: 40, bl: 0, br: 0))
                            .edgesIgnoringSafeArea(.bottom))
        }.background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
        .dismissKeyboardOnTap()
        .sheet(isPresented: $choosingSubject) {
            ChooseSubjectModal(subject: $subject, choosingSubject: $choosingSubject)
        }
        .alert(isPresented: $blankFieldError, content: {
            Alert(title: Text("Error: Blank Field"), message: Text("Must fill in all required fields in order to post review"), dismissButton: .default(Text("Ok")))
        })
    }
}

struct CreateReview_Previews2: PreviewProvider {
    static var previews: some View {
        //CreateReview(createReviewOpen: .constant(true))
        ChooseSubjectModal(subject: .constant(AllData(professorName: "", professorId: "", courseName: "", courseId: "", accronym: "", courseNum: "", hours: "")), choosingSubject: .constant(true))
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
    
    @Binding var subject: AllData
    @Binding var choosingSubject: Bool
    @State var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 20).fill(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).frame(width: 45, height: 7, alignment: .center).padding(.vertical)
            
            CustomSearchBar(searchText: $searchText).shadow(radius: 3).padding([.horizontal, .top])
            ScrollView(.vertical, showsIndicators: true, content: {
                if searchText == "" {
                    Text("Search & choose the suject of your review").font(.largeTitle).fontWeight(.bold).foregroundColor(.black)
                    Image("mobile").resizable().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2).padding(.top, 50)
                    Spacer()
                } else {
                    
                    VStack {
                        ForEach(allData.filter{$0.professorName.lowercased().contains(self.searchText.lowercased())
                            //||$0.courseName.lowercased().contains(self.searchText.lowercased())
                        }, id:\.self) { professor in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(professor.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(.title3).fontWeight(.semibold).foregroundColor(.black)
                                    
                                    Text("Department: \(professor.accronym.replacingOccurrences(of: ("(Primary)"), with: ""))").font(.body).fontWeight(.semibold).foregroundColor(.gray)
                                }
                                Spacer()
                                Image("who").resizable().frame(width: 50, height: 50, alignment: .center)
                            }.padding([.bottom])
                            .onTapGesture {
                                self.subject = professor
                                self.choosingSubject = false
                            }
                        }
                        
                    }.padding()
                }
            }).gesture(DragGesture().onChanged { _ in
                UIApplication.shared.endEditing(true)
            })
            
        }.background(Color("BGColor").edgesIgnoringSafeArea(.all))
    }
}
