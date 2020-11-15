//
//  Home.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    @State var createReviewOpen = false
    
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
                            if self.homeViewModel.recentReviews.count == 0 {
                                HStack {
                                    Spacer()
                                    Image("empty").resizable().frame(width: 270, height: 220, alignment: .center).shadow(radius: 1)
                                    Spacer()
                                }.padding(.top)
                                HStack {
                                    Spacer()
                                    Text("No recent reviews!").font(.title2).foregroundColor(Color.black.opacity(0.5))
                                    Spacer()
                                }
                                
                            } else {
                                ForEach(self.homeViewModel.recentReviews, id: \.id) { review in
                                    ReviewCell(image: "who", review: review)
                                }
                            }
                        }.padding(.bottom, 35)
                    }
                }.edgesIgnoringSafeArea(.bottom)
                
                // Write a review(Make a rating) button
                Image(systemName: "pencil").resizable().frame(width: 30, height: 30).foregroundColor(.white).padding(24).background(Color.black.opacity(0.7)).cornerRadius(50).padding()
                    .onTapGesture {
                        self.createReviewOpen = true
                    }
                
            }.fullScreenCover(isPresented: $createReviewOpen) {
                CreateReview(createReviewOpen: $createReviewOpen)
            }
            .edgesIgnoringSafeArea(.bottom).navigationBarTitle("").navigationBarHidden(true).accentColor(.black)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
