//
//  Rater.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

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

//struct Rater_Previews: PreviewProvider {
//    static var previews: some View {
//        Rater()
//    }
//}
