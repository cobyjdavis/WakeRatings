//
//  Search.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct Search: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var searchViewModel = SearchViewModel()
    @State private var searchText = ""
    @State var index = 0
    var allData: [AllData] = load("WRData.json")
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                        Image(systemName: "arrow.backward").foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))).font(Font.largeTitle.weight(.semibold)).padding().background(Color.white).clipShape(Circle()).shadow(radius: 5)
                    })
                    Spacer()
                    Image("mobile").resizable().frame(width: 160, height: 140, alignment: .center).shadow(radius: 5)
                    
                }.padding(.bottom, -80)
                HStack {
                    Text("Explore!").font(Font.custom("RockoFLF-Bold", size: 30)).foregroundColor(.white).shadow(radius: 5)
                    Spacer()
                }.padding(.leading).padding(.bottom, 5)
                HStack {
                    Text("Search for your favorite courses, professors, places & more!").font(Font.custom("RockoFLF-Bold", size: 18)).foregroundColor(.white).shadow(radius: 5).padding(.bottom)
                    Spacer()
                }.padding(.leading)
                
                CustomSearchBar(searchText: $searchText)
                
                GridViewHeader(activeIdx: $index)
            }.padding(.horizontal).padding(.vertical).background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]), startPoint: .leading, endPoint: .trailing).clipShape(RoundedCorners(tl: 0, tr: 0, bl: 20, br: 20))
                                                .edgesIgnoringSafeArea(.top))
            
            VStack {
                if searchText == "" {
//                    HStack {
//                        Text("Popular").font(Font.largeTitle.bold())
//                        Spacer()
//                    }.padding()
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                    })
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: true, content: {
                        LazyVStack {
                            if index == 0 {
                                ForEach(allData.filter{$0.professorName.lowercased().contains(self.searchText.lowercased())
                                    //||$0.courseName.lowercased().contains(self.searchText.lowercased())
                                }, id:\.self) { professor in
                                    NavigationLink(destination: ProfessorDetailView(data: professor)) {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(professor.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(.title3).fontWeight(.semibold).foregroundColor(.black)
                                                
                                                Text("Department: \(professor.accronym)").font(.body).fontWeight(.semibold).foregroundColor(.gray)
                                            }
                                            Spacer()
                                            Image("who").resizable().frame(width: 50, height: 50, alignment: .center)
                                        }.padding([.bottom])
                                    }
                                }
                            } else {
                                ForEach(allData.filter{$0.courseName.lowercased().contains(self.searchText.lowercased())
                                    //||$0.courseName.lowercased().contains(self.searchText.lowercased())
                                }, id:\.self) { course in
                                    NavigationLink(destination: CourseDetailView(data: course)) {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(course.courseName.replacingOccurrences(of: ("(Primary)"), with: "").replacingOccurrences(of: ("(Online)"), with: "").replacingOccurrences(of: ("(Blended-Traditional)"), with: "").replacingOccurrences(of: ("(Blended-Online Pathway)"), with: "").replacingOccurrences(of: ("(Face to Face)"), with: "").replacingOccurrences(of: ("(Blended - With Online Pathway)"), with: "").replacingOccurrences(of: ("(Face-to-Face)"), with: "")).font(.title3).fontWeight(.semibold).foregroundColor(.black)
                                                
                                                Text("Department: \(course.accronym)").font(.body).fontWeight(.semibold).foregroundColor(.gray)
                                            }
                                            Spacer()
                                            Image("who").resizable().frame(width: 50, height: 50, alignment: .center)
                                        }.padding([.bottom])
                                    }
                                }
                            }
                        }.padding()
                    }).gesture(DragGesture().onChanged { _ in
                        UIApplication.shared.endEditing(true)
                    })
                }
            }.background(Color.white)
        }.navigationBarTitle("").navigationBarHidden(true)
    }
}

// 1
func load<T:Decodable>(_ filename:String, as type:T.Type = T.self) -> T {
    let data:Data
    // 2
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn’t find file")
    }
    // 3
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn’t data")
    }
    //4
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn’t decode")
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        //Search()
        //DetailView(data: AllData(professorName: "Raina Haque", professorId: "00ebw", courseName: "Intermediate Breathing", courseId: "vfR43", accronym: "ENT", courseNum: "119", hours: "3.5"))
        CourseDetailView(data: AllData(professorName: "Raina Haque", professorId: "00ebw", courseName: "Intermediate Breathing", courseId: "vfR43", accronym: "ENT", courseNum: "119", hours: "3.5"))
    }
}

struct ProfessorDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var profileViewModel = ProfileViewModel()
    @State var createReviewOpen = false
    var data: AllData
    
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
                        Text(data.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(.system(size: 25, weight: .semibold, design: .default)).foregroundColor(.white)
                        HStack {
                            Image(systemName: "building.columns.fill").font(Font.callout.bold()).foregroundColor(.white)
                            Text(data.accronym).font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.white)
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
                    Button(action: { self.createReviewOpen = true }, label: {
                        Text("Review").font(.title3).fontWeight(.semibold).foregroundColor(.white).shadow(radius: 4).padding().padding(.horizontal, 18).background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)).clipShape(Capsule())
                    })
                }.padding(.top)
            }.padding().padding(.bottom, 5)
            
            /* List of Reviews */
            VStack(spacing: 0) {
                HStack {
                    Text(self.profileViewModel.myReviews.count == 0 ? "Reviews ": "Reviews (\(profileViewModel.myReviews.count))").font(.largeTitle).fontWeight(.bold)
                    Spacer()
                }.padding([.leading, .top])
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        if profileViewModel.myReviews.count != 0 {
                            ForEach(profileViewModel.myReviews, id: \.id) { review in
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
        .fullScreenCover(isPresented: $createReviewOpen) {
            CreateReview(createReviewOpen: $createReviewOpen, subject: data)
        }
        .onAppear {
            profileViewModel.fetchReviews(professorId: data.professorId)
        }
    }
}

struct CourseDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var profileViewModel = ProfileViewModel()
    @State var createReviewOpen = false
    var data: AllData
    
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
                        Text(data.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(.system(size: 25, weight: .semibold, design: .default)).foregroundColor(.white)
                        HStack {
                            Image(systemName: "building.columns.fill").font(Font.callout.bold()).foregroundColor(.white)
                            Text(data.accronym).font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.white)
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
                    Button(action: { self.createReviewOpen = true }, label: {
                        Text("Review").font(.title3).fontWeight(.semibold).foregroundColor(.white).shadow(radius: 4).padding().padding(.horizontal, 18).background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)).clipShape(Capsule())
                    })
                }.padding(.top)
            }.padding().padding(.bottom, 5)
            
            /* List of Reviews */
            VStack(spacing: 0) {
                HStack {
                    Text(self.profileViewModel.myReviews.count == 0 ? "Reviews ": "Reviews (\(profileViewModel.myReviews.count))").font(.largeTitle).fontWeight(.bold)
                    Spacer()
                }.padding([.leading, .top])
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        if profileViewModel.myReviews.count != 0 {
                            ForEach(profileViewModel.myReviews, id: \.id) { review in
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
        .fullScreenCover(isPresented: $createReviewOpen) {
            CreateReview(createReviewOpen: $createReviewOpen, subject: data)
        }
        .onAppear {
            profileViewModel.fetchReviews(professorId: data.professorId)
        }
    }
}
