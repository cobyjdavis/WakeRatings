//
//  CustomSearchBar.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/24/20.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        HStack {
            if searchText == "" {
                Image(systemName: "magnifyingglass").foregroundColor(.black).font(Font.body.bold())
            }
            TextField("Search Professors, Courses, Places & More", text: $searchText, onEditingChanged: { focused in
                if focused {
                    searching = true
                } else {
                    searching = false
                }
            })
            if searchText != "" {
                Button(action: { self.searchText = "" }, label: {
                    Image(systemName: "xmark").foregroundColor(.black).font(Font.body.bold())
                })
            }
        }.padding().background(Color.white).clipShape(Capsule()).padding(.horizontal, 5).padding(.bottom)
    }
}

//struct CustomSearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSearchBar()
//    }
//}
