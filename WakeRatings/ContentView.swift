//
//  ContentView.swift
//  WakeRatings
//
//  Created by CJ Davis on 9/23/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //Search()
    }
}

struct Home: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color("BGColor").edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Top Heeader - Menu and Search Icon
                        HStack {
                            Button(action: {}, label: {
                                Image(systemName: "line.horizontal.3").font(Font.title.bold()).padding(20).background(RoundedCorners(tl: 0, tr: 30, bl: 0, br: 30).fill(Color.white)).shadow(radius: 5)
                            })
                            
                            Spacer()
                            
                            NavigationLink(destination: Search()) {
                                Image(systemName: "magnifyingglass").font(Font.title.bold()).padding().background(Color.white).clipShape(Circle()).shadow(radius: 5)
                            }.padding(.trailing)
                            
                        }.padding(.vertical)
                        
                        // Courses Header - All courses
                        HStack() {
                            Text("Departments").font(Font.largeTitle.bold())
                            Spacer()
                            Button(action: {}, label: {
                                Text("Show all").foregroundColor(.gray)
                            })
                        }.padding(.horizontal)
                        
                        // Scrollable short list of courses
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            HStack(spacing: 25) {
                                ForEach(departmentData) { department in
                                    GeometryReader { geo in
                                        NavigationLink(destination: Text("Department: \(department.courseName)")) {
                                            DepartmentCard(department: department, minX: geo.frame(in: .global).minX)
                                        }
                                    }.frame(width: 230, height: 270)
                                }
                            }.padding(.leading)
                        }).frame(height: 270).padding(.top)
                        
                        // Recent Reviews and Ratings Header
                        HStack() {
                            Text("Reviews & Ratings").font(Font.largeTitle.bold())
                            Spacer()
                        }.padding(.horizontal).padding(.top)
                        
                        // Reviews
                        VStack {
                            ReviewCell(image: "profImg", name: "Dr. Canas", rating: 5, review: "The best professor you can have! Everyone gets an A+. My average test score was 57 but Dr. Canas still gave me an A.", date: "Feb 12, 2020", likeCount: "370", dislikeCount: "2")
                            ReviewCell(image: "profImg", name: "Professor Who", rating: 2, review: "ABSOLUTE WORST EVER! I highly recommend not taking this guy. I don't understand how he is still employed.", date: "Nov 3, 2019", likeCount: "45", dislikeCount: "119")
                            ReviewCell(image: "profImg", name: "First Last", rating: 3, review: "Generic review comment! Average rating.", date: "July 25, 2015", likeCount: "0", dislikeCount: "0")
                            
                        }.padding(.bottom, 35)
                    }
                }.edgesIgnoringSafeArea(.bottom)
                
                // Write a review(Make a rating) button
                NavigationLink(destination: CreateReview()) {
                    Image(systemName: "pencil").resizable().frame(width: 30, height: 30).foregroundColor(.white).padding(24).background(Color.black.opacity(0.7)).cornerRadius(50).padding()
                }
            }.edgesIgnoringSafeArea(.bottom).navigationBarTitle("").navigationBarHidden(true).accentColor(.black)
        }
    }
}

var departmentData = [
    DepartmentCardData(id: "business", color1: Color.orange, color2: Color.yellow, courseName: "Business", image: "business", imageWidth: 230, imageHeight: 180),
    DepartmentCardData(id: "lit", color1: Color.blue, color2: Color.purple, courseName: "Literature", image: "lit1", imageWidth: 210, imageHeight: 180),
    DepartmentCardData(id: "math", color1: Color.red, color2: Color.red, courseName: "Mathematics", image: "math", imageWidth: 210, imageHeight: 180),
    DepartmentCardData(id: "bio", color1: Color.blue, color2: Color.green, courseName: "Biology", image: "bio", imageWidth: 210, imageHeight: 180),
    DepartmentCardData(id: "cs", color1: Color.black, color2: Color.white, courseName: "Computer Science", image: "cs", imageWidth: 230, imageHeight: 180),
    DepartmentCardData(id: "sports", color1: Color.yellow, color2: Color.red, courseName: "Sports", image: "sports", imageWidth: 230, imageHeight: 180),
    DepartmentCardData(id: "pit", color1: Color(#colorLiteral(red: 1, green: 0, blue: 0.5710257888, alpha: 1)), color2: Color(#colorLiteral(red: 1, green: 0.7604560256, blue: 0, alpha: 1)), courseName: "The Pit", image: "food", imageWidth: 230, imageHeight: 140)
]


struct DepartmentCardData: Identifiable {
    var id: String
    var color1: Color
    var color2: Color
    var courseName: String
    var image: String
    var imageWidth: CGFloat
    var imageHeight: CGFloat
}

struct Search: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                            Image(systemName: "arrow.backward").foregroundColor(.black).font(Font.title3.bold()).padding().background(Color.white).clipShape(Circle()).shadow(radius: 5)
                        })
                        Text("Search").font(Font.largeTitle.bold())
                    }.padding(.leading)
                    SearchBar(text: $searchText).padding(.horizontal, 5)
                }
                Image("search2").resizable().frame(width: 110, height: 90, alignment: .center).padding(.trailing).shadow(radius: 5)
            }.padding(.top)
            
            Text("What's Trending").font(Font.largeTitle.bold()).padding(.leading)
            Text("Reviews, Courses, Professors and Sports").font(Font.title3.bold()).foregroundColor(.gray).padding(.leading)
            
            ReviewCard(color: .green)
            
            Text("Top Professors").font(Font.title3.bold()).foregroundColor(.gray).padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 15) {
                    ForEach(1..<10) { _ in
                        Image("profImg").resizable().frame(width: 70, height: 70, alignment: .center).clipShape(Circle()).shadow(radius: 3)
                    }
                }.padding(.leading)
            })
            
            Spacer()
        }.background(Color("BGColor").edgesIgnoringSafeArea(.all)).navigationBarTitle("").navigationBarHidden(true)
    }
}

struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct ReviewPage: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Reviews & Ratings").font(Font.custom("RockoFLF-Bold", size: 32))
                Spacer()
            }.padding(.horizontal).padding(.top, 40).cornerRadius(25)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: -10) {
                    ReviewCard(color: Color.green)
                    ReviewCard(color: Color.orange)
                    ReviewCard(color: Color.red)
                }
            }
        }.padding(.top).edgesIgnoringSafeArea(.all)
    }
}

struct ReviewCard: View {
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Review header - Who or what is the review of and the rating provided
            HStack {
                Image("profImg").resizable().renderingMode(.original).frame(width: 40, height: 40).clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 2.5)).shadow(radius: 5)
                Text("Dr. Canas").foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 24)).shadow(radius: 5)
                Spacer()
                
                // Rating(Stars)
                HStack(spacing: 2) {
                    ForEach(0..<5) {_ in
                        Image(systemName: "star.fill").foregroundColor(.yellow).font(Font.callout.bold()).shadow(radius: 5)
                    }
                }
            }
            
            // The user's review
            Text("The best professor you can have! Everyone gets an A+. My average test score was 57 but Dr. Canas still gave me an A.").foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 18)).lineLimit(5).frame(height: 110, alignment: .top).shadow(radius: 5)
            
            // Review information - Date submitted and Popularity
            HStack {
                // Date
                Text("Feb 12, 2020").font(Font.custom("RockoFLF-Bold", size: 14)).foregroundColor(.white).shadow(radius: 5)
                Spacer()
                // Like Button
                Button(action: {}, label: {
                    Image(systemName: "hand.thumbsup.fill").foregroundColor(.white).font(Font.callout.bold())
                }).shadow(radius: 5)
                Text("370").foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 14)).shadow(radius: 5)
                
                // Dislike Button
                Button(action: {}, label: {
                    Image(systemName: "hand.thumbsdown.fill").foregroundColor(.white).font(Font.callout.bold())
                }).shadow(radius: 5)
                Text("2").foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 14)).shadow(radius: 5)
            }
        }.padding().background(LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(25).padding()
    }
}

struct DepartmentCard: View {
    
    var department: DepartmentCardData
    var minX: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [department.color1, department.color2.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 230, height: 270).cornerRadius(20)
            
            VStack {
                HStack {
                    Text(department.courseName).foregroundColor(.white).font(Font.custom("RockoFLF-Bold", size: 30)).shadow(radius: 5).lineLimit(2).fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding()
                Spacer()
                Image(department.image).resizable().renderingMode(.original).frame(width: department.imageWidth, height: department.imageHeight).clipped().shadow(radius: 10)
            }
        }.frame(width: 230, height: 270)
        .scaleEffect(minX < 0 ? minX / 1000 + 1 : 1)
        .offset(x: minX < 16 ? -minX + 16 : 1)
        .opacity(minX < 0 ? Double(minX / 200 + 1) : 1)
    }
}

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

struct CreateReview: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var review = "Write your review"
    @State private var emptyReviewError = false
    @State var ratings = 0
    @State var showingRater = false
    @State var submitted = false
    
    let currentDateTime = Date()
    let formatter = DateFormatter()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Create a Review").font(Font.custom("RockoFLF-Bold", size: 38))
                Spacer()
                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
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
                
                Button(action: {}, label: {
                    Text("Post Review").font(Font.custom("RockoFLF-Bold", size: 20)).foregroundColor(.white).padding(20).background(Color.black).clipShape(Capsule())
                })
            }
        }.padding().edgesIgnoringSafeArea(.bottom).navigationBarTitle("", displayMode: .inline).navigationBarHidden(true).accentColor(.black)
    }
}

struct Rater : View {
    
    @Binding var ratings : Int
    @Binding var showingRater : Bool
    @Binding var sumbitted : Bool
    
    func foregroundColor(rating: Int) -> Color {
        if rating < 3 {
            return Color.red
        } else if rating > 3 {
            return Color.green
        } else {
            return Color.orange
        }
    }
    
    var body : some View {
        
        VStack {
            
            HStack {
                
                Text("How many stars do you rate Dr. Canas?")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Spacer()
                
            }.padding()
            .background(Color.black)
            
            VStack {
                if self.ratings != 0 {
                    
                    if self.ratings == 5 {
                        
                        Text("Excellent").fontWeight(.bold).foregroundColor(foregroundColor(rating: ratings))
                        
                    } else if self.ratings == 4 {
                        
                        Text("Good").fontWeight(.bold).foregroundColor(foregroundColor(rating: ratings))
                        
                    } else if self.ratings == 3 {
                        
                        Text("Average").fontWeight(.bold).foregroundColor(foregroundColor(rating: ratings))
                        
                    } else if self.ratings == 2 {
                        
                        Text("Okay").fontWeight(.bold).foregroundColor(foregroundColor(rating: ratings))
                        
                    } else {
                        
                        Text("Poor").fontWeight(.bold).foregroundColor(foregroundColor(rating: ratings))
                        
                    }
                }
            }.padding(.top, 20)
            
            // Custom picker that delegates the number of stars assigned
            HStack(spacing: 15) {
                ForEach(1...5, id: \.self) {i in
                    Image(systemName: self.ratings == 0 ? "star" : "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(i <= self.ratings ? .yellow : Color.black.opacity(0.2))
                        .onTapGesture {
                            
                            self.ratings = i
                    }
                }
                
            }.padding()
            
            // Button horizontal stack
            HStack {
                Spacer()
                
                // Cancel Button--Cancel assignment of stars
                Button(action: {
                    
                    self.ratings = 0
                    self.showingRater.toggle()
                    self.sumbitted = false
                    
                }) {
                    Text("Cancel")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                
                // Sumbit button--Assign stars to person
                Button(action: {
                    self.showingRater.toggle()
                    self.sumbitted = true
                }) {
                    Text("Submit")
                        .foregroundColor(self.ratings != 0 ? .white : Color.black.opacity(0.2))
                        .fontWeight(.bold)
                        .padding(self.ratings != 0 ? 10 : 0)
                        .background(self.ratings != 0 ? Color.black : Color.clear)
                        .clipShape(Capsule())
                }.padding(.leading, 20)
                .disabled(self.ratings != 0 ? false : true)
                
            }.padding()
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct multilineTextField : UIViewRepresentable {
    
    @Binding var txt : String
    
    func makeCoordinator() -> multilineTextField.Coordinator {
        return multilineTextField.Coordinator(parent1 : self)
    }
    func makeUIView(context: UIViewRepresentableContext<multilineTextField>) -> UITextView {
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = "Write your review..."
        text.textColor = .gray
        text.font = .systemFont(ofSize: 20)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: multilineTextField.UIViewType, context: UIViewRepresentableContext<multilineTextField>) {
        
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent : multilineTextField
        
        init(parent1 : multilineTextField) {
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
        }
    }
}

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
