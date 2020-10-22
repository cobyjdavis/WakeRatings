//
//  Search.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct Search: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchText = ""
    var allData: [AllData] = load("WRData.json")
    
    var body: some View {
        VStack(spacing: 5) {
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                        Image(systemName: "arrow.backward").foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))).font(Font.largeTitle.weight(.semibold)).padding().background(Color.white).clipShape(Circle()).shadow(radius: 5)
                    })
                    Spacer()
                    Image("mobile").resizable().frame(width: 180, height: 160, alignment: .center).shadow(radius: 5)
                    
                }.padding(.bottom, -50)
                HStack {
                    Text("Search for your favorite courses & professors!").font(Font.custom("RockoFLF-Bold", size: 23)).foregroundColor(.white).frame(width: 290).shadow(radius: 5).padding(.bottom)
                    Spacer()
                }
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
                                NavigationLink(destination: Text("Detail View")) {
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
        Search()
    }
}

struct CustomSearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            if searchText == "" {
                Image(systemName: "magnifyingglass").foregroundColor(.black).font(Font.body.bold())
            }
            TextField("Search Professors, Courses, Places & More", text: $searchText)
            if searchText != "" {
                Button(action: { self.searchText = "" }, label: {
                    Image(systemName: "xmark").foregroundColor(.black).font(Font.body.bold())
                })
            }
        }.padding().background(Color.white).clipShape(Capsule()).padding(.horizontal, 5).padding(.bottom)
    }
}
