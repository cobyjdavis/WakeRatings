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
    var allData: [AllData] = load("WRData.json")
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                        Image(systemName: "arrow.backward").foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))).font(Font.largeTitle.weight(.semibold)).padding().background(Color.white).clipShape(Circle()).shadow(radius: 5)
                    })
                    Spacer()
                    Image("mobile").resizable().frame(width: 180, height: 160, alignment: .center).shadow(radius: 5)
                    
                }.padding(.bottom, -80)
                HStack {
                    Text("Explore!").font(Font.custom("RockoFLF-Bold", size: 35)).foregroundColor(.white).shadow(radius: 5)
                    Spacer()
                }.padding(.leading).padding(.bottom, 5)
                HStack {
                    Text("Search for your favorite courses, professors, places & more!").font(Font.custom("RockoFLF-Bold", size: 22)).foregroundColor(.white).shadow(radius: 5).padding(.bottom)
                    Spacer()
                }.padding(.leading)
                CustomSearchBar(searchText: $searchText)
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
                        VStack {
                            ForEach(allData.filter{$0.professorName.lowercased().contains(self.searchText.lowercased())
                                //||$0.courseName.lowercased().contains(self.searchText.lowercased())
                            }, id:\.self) { professor in
                                NavigationLink(destination: DetailView2(data: professor)) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(professor.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(.title3).fontWeight(.semibold).foregroundColor(.black)
                                            
                                            
                                            Text("Department: \(professor.accronym.replacingOccurrences(of: ("(Primary)"), with: ""))").font(.body).fontWeight(.semibold).foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image("who").resizable().frame(width: 50, height: 50, alignment: .center)
                                    }.padding([.bottom])
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
        DetailView2(data: AllData(professorName: "Raina Haque", professorId: "00ebw", courseName: "Intermediate Breathing", courseId: "vfR43", accronym: "ENT", courseNum: "119", hours: "3.5"))
    }
}

struct DetailView2: View {
    
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
                        Text("Review").font(.title3).fontWeight(.semibold).foregroundColor(.white).shadow(radius: 4).padding().padding(.horizontal, 27).background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)).clipShape(Capsule())
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
                                ReviewCell(image: "who", name: review.professorName, rating: review.rating, review: review.review, timestamp: review.timestamp, likeCount: review.likeCount, dislikeCount: review.dislikeCount)
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

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var profileViewModel = ProfileViewModel()
    @State var showHeader = false
    var data: AllData
    let maxHeight = UIScreen.main.bounds.height / 4
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    GeometryReader { reader -> AnyView in
                        
                        let y = reader.frame(in: .global).minY + maxHeight
                        DispatchQueue.main.async {
                            if y < 0 {
                                withAnimation(.linear) { showHeader = true }
                            } else {
                                withAnimation(.linear) { showHeader = false }
                            }
                        }
                        return AnyView(
                            VStack(spacing: 0) {
                                HStack {
                                    Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                                        Image(systemName: "arrow.backward").foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).font(Font.largeTitle.weight(.semibold)).padding().background(Color.black.opacity(0.8)).clipShape(Circle()).shadow(radius: 5)
                                    })
                                    Spacer()
                                }.padding(.leading)
                                Image("who").resizable().frame(width: 150, height: 150, alignment: .center).shadow(radius: 1).padding(.bottom)
                                
                            }.frame(width: UIScreen.main.bounds.width, height: maxHeight + 100, alignment: .center)
                        )
                    }.frame(width: UIScreen.main.bounds.width, height: maxHeight + 30, alignment: .center)
                    Text(data.professorName.replacingOccurrences(of: ("(Primary)"), with: "")).font(Font.custom("RockoFLF-Bold", size: 38)).lineLimit(1).padding(.horizontal)
                    Text("Department: \(data.accronym)").font(Font.custom("RockoFLF-Bold", size: 24)).foregroundColor(.gray)
                    /* Stats */
                    //                HStack {
                    //                    VStack {
                    //                        Text("3").font(Font.custom("RockoFLF-Bold", size: 24))
                    //                        Text("Courses").font(Font.custom("RockoFLF-Bold", size: 24)).foregroundColor(.gray)
                    //                    }
                    //
                    //                    Divider().frame(height: 30)
                    //
                    //                    VStack {
                    //                        Text("4.6").font(Font.custom("RockoFLF-Bold", size: 24))
                    //                        Text("Grade").font(Font.custom("RockoFLF-Bold", size: 24)).foregroundColor(.gray)
                    //                    }
                    //
                    //                    Divider().frame(height: 30)
                    //
                    //                    VStack {
                    //                        Text("15").font(Font.custom("RockoFLF-Bold", size: 24))
                    //                        Text("Reviews").font(Font.custom("RockoFLF-Bold", size: 24)).foregroundColor(.gray)
                    //                    }
                    //                }
                    HStack {
                        Text("My Reviews").font(.largeTitle).fontWeight(.bold)
                        Spacer()
                    }.padding(.leading).padding(.bottom, -20).padding(.top)
                    ForEach(profileViewModel.myReviews, id: \.id) { review in
                        ReviewCell(image: "who", name: review.professorName, rating: review.rating, review: review.review, timestamp: review.timestamp, likeCount: review.likeCount, dislikeCount: review.dislikeCount)
                    }
                }
            })
            
            /* Sticky Header */
            HStack(spacing: 15) {
                Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                    Image(systemName: "arrow.backward").foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).font(Font.largeTitle.weight(.semibold)).padding().background(Color.black.opacity(0.8)).clipShape(Circle()).shadow(radius: 5)
                })
                Spacer()
                VStack {
                    Image("who").resizable().frame(width: 70, height: 70, alignment: .center).padding(.top, 5)
                    //Text("4.6").font(Font.custom("RockoFLF-Bold", size: 25)).lineLimit(1).padding(.top)
                    //Text("Grade").font(Font.custom("RockoFLF-Bold", size: 20)).lineLimit(1)
                }
                Spacer()
                Spacer()
            }.padding().padding(.top).background(Blur(style: .systemChromeMaterial)).edgesIgnoringSafeArea(.top).opacity(self.showHeader ? 1: 0)
        }).edgesIgnoringSafeArea(.all).navigationBarTitle("").navigationBarHidden(true)
        .onAppear {
            profileViewModel.fetchReviews(professorId: data.professorId)
        }
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
