//
//  TeacherRankings.swift
//  WakeRatings
//
//  Created by Andrew S on 12/2/20.
//

import SwiftUI

struct TeacherRankings: View {
    var body: some View {
        VStack{
        VStack {
            
            List(contacts) { contact in
                NavigationLink(destination: ProfessorDetailView11(data11: AllData(professorName: contact.name, professorId: "00ebw", courseName: "Computer Science 391", courseId: "XcCtF", accronym: contact.address, courseNum: "119", hours: "3"))) {
                    ContactRow(contact: contact)
                }
            }
        }
        
        }.navigationBarTitle(Text("Top 10 Teachers"), displayMode: .inline)
    }
}

struct TeacherRankings_Previews: PreviewProvider {
    static var previews: some View {
        TeacherRankings()
    }
}
struct ContactRow: View {
    
    let contact: Contacts
    
    var body: some View {
        HStack {
            Image(contact.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(50)
            VStack(alignment: .leading) {
                Text(contact.name)
                    .font(.system(size: 21, weight: .medium, design: .default))
                Text("Average Rating: "+contact.phone)
            }
        }
    }
}

struct ProfessorDetailView11: View {
    
    @Environment(\.presentationMode) var present: Binding<PresentationMode>
    @StateObject var prof11view = ProfileViewModel()
    @State var openReviewCreate = false
    var data11: AllData
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                /* Profile View Header */
                HStack {
                    Button(action: { self.present.wrappedValue.dismiss() }, label: {
                        Image(systemName: "chevron.backward").foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).font(Font.largeTitle.weight(.semibold))
                    })
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis").foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).font(Font.largeTitle.weight(.semibold)).rotationEffect(Angle(degrees: 90))
                    })
                }.padding(.bottom, 30)
                
                /* Profile Information and Stats */
                HStack(spacing: 30) {
                    Image("who").resizable().frame(width: 80, height: 80, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(data11.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(.system(size: 25, weight: .semibold, design: .default)).foregroundColor(.white)
                        HStack {
                            Image(systemName: "building.columns.fill").font(Font.callout.bold()).foregroundColor(.white)
                            Text(data11.accronym).font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    VStack {
                        Text("3").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(.white)
                        Text("Courses").font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.white)
                    }
                    Spacer()
                    VStack {
                        Text("4.7").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(.white)
                        Text("Grade").font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.white)
                    }
                    Spacer()
                    Button(action: { self.openReviewCreate = true }, label: {
                        Text("Review").font(.title3).fontWeight(.semibold).foregroundColor(.white).shadow(radius: 4).padding().padding(.horizontal, 18).background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)).clipShape(Capsule())
                    })
                }.padding(.top)
            }.padding().padding(.bottom, 5)
            
            /* List of Reviews */
            VStack(spacing: 0) {
                HStack {
                    Text(self.prof11view.myReviews.count == 0 ? "Reviews ": "Reviews (\(prof11view.myReviews.count))").font(.largeTitle).fontWeight(.bold)
                    Spacer()
                }.padding([.leading, .top])
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        if prof11view.myReviews.count != 0 {
                            ForEach(prof11view.myReviews, id: \.id) { review in
                                ReviewCell(image: "who", review: review)
                            }
                        } else {
                            Image("empty").resizable().frame(width: 300, height: 250, alignment: .center).padding(.top, 50)
                            Text("Currently has no reviews...").font(Font.custom("", size: 23)).foregroundColor(.gray)
                            //Text("Be the first to Review!").font(Font.custom("", size: 30)).foregroundColor(.black).padding(.top)
                        }
                    }
                }).background(Color.white
                                .clipShape(RoundedCorners(tl: 40, tr: 40, bl: 0, br: 0))
                                .edgesIgnoringSafeArea(.bottom))
            }.background(Color.white
                            .clipShape(RoundedCorners(tl: 40, tr: 40, bl: 0, br: 0))
                            .edgesIgnoringSafeArea(.bottom))
        }.background(Color.black.opacity(1).edgesIgnoringSafeArea(.top)).navigationBarTitle("").navigationBarHidden(true)
        .fullScreenCover(isPresented: $openReviewCreate) {
            CreateReview(createReviewOpen: $openReviewCreate, subject: data11)
        }
        .onAppear {
            prof11view.fetchReviews(professorId: data11.professorId)
        }
    }
}

struct CourseDetailView11: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var prof11view = ProfileViewModel()
    @State var openReviewcreate1 = false
    var dataTest1: AllData
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                /* Profile View Header */
                HStack {
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                        Image(systemName: "chevron.backward").foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).font(Font.largeTitle.weight(.semibold))
                    })
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis").foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).font(Font.largeTitle.weight(.semibold)).rotationEffect(Angle(degrees: 90))
                    })
                }.padding(.bottom, 30)
                
                /* Profile Information and Stats */
                HStack(spacing: 30) {
                    Image("who").resizable().frame(width: 80, height: 80, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(dataTest1.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(.system(size: 25, weight: .semibold, design: .default)).foregroundColor(.white)
                        HStack {
                            Image(systemName: "building.columns.fill").font(Font.callout.bold()).foregroundColor(.white)
                            Text(dataTest1.accronym).font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    VStack {
                        Text("3").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(.white)
                        Text("Courses").font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.white)
                    }
                    Spacer()
                    VStack {
                        Text("4.7").font(.system(size: 40, weight: .bold, design: .default)).foregroundColor(.white)
                        Text("Grade").font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.white)
                    }
                    Spacer()
                    Button(action: { self.openReviewcreate1 = true }, label: {
                        Text("Review").font(.title3).fontWeight(.semibold).foregroundColor(.white).shadow(radius: 4).padding().padding(.horizontal, 18).background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)).clipShape(Capsule())
                    })
                }.padding(.top)
            }.padding().padding(.bottom, 5)
            
            /* List of Reviews */
            VStack(spacing: 0) {
                HStack {
                    Text(self.prof11view.myReviews.count == 0 ? "Reviews ": "Reviews (\(prof11view.myReviews.count))").font(.largeTitle).fontWeight(.bold)
                    Spacer()
                }.padding([.leading, .top])
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        if prof11view.myReviews.count != 0 {
                            ForEach(prof11view.myReviews, id: \.id) { review in
                                ReviewCell(image: "who", review: review)
                            }
                        } else {
                            Image("empty").resizable().frame(width: 300, height: 250, alignment: .center).padding(.top, 50)
                            Text("Currently has no reviews...").font(Font.custom("", size: 23)).foregroundColor(.gray)
                            //Text("Be the first to Review!").font(Font.custom("", size: 30)).foregroundColor(.black).padding(.top)
                        }
                    }
                }).background(Color.white
                                .clipShape(RoundedCorners(tl: 40, tr: 40, bl: 0, br: 0))
                                .edgesIgnoringSafeArea(.bottom))
            }.background(Color.white
                            .clipShape(RoundedCorners(tl: 40, tr: 40, bl: 0, br: 0))
                            .edgesIgnoringSafeArea(.bottom))
        }.background(Color.black.opacity(1).edgesIgnoringSafeArea(.top)).navigationBarTitle("").navigationBarHidden(true)
        .fullScreenCover(isPresented: $openReviewcreate1) {
            CreateReview(createReviewOpen: $openReviewcreate1, subject: dataTest1)
        }
        .onAppear {
            prof11view.fetchReviews(professorId: dataTest1.professorId)
        }
    }
}

