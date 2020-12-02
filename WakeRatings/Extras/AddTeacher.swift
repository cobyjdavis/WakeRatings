//
import SwiftUI
import Firebase
let lightGrey =  Color(red: 239/255, green: 243/255, blue: 244/255)


struct AddTeacher: View {
    @State var teacherName:String = ""
    @State var className:String = ""
    
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 10) {
            Text("Request New Teacher or Class!").font(Font.custom("RockoFLF-Bold", size: 30)).foregroundColor(.black).shadow(radius: 5)
            
        TextField("Enter Name Of Teacher", text: $teacherName)
            .padding()
            .background(lightGrey)
            .cornerRadius(20)
            .padding(.bottom, 20)
        TextField("Enter Class Assoicated With Teacher", text: $className)
            .padding()
            .background(lightGrey)
            .cornerRadius(20)
            .padding(.bottom, 20)
        NavigationLink(
                destination: Home()
                    .navigationBarTitle("")
                    .navigationBarHidden(true),
                label: {
                    Text("Request New Teacher").padding(5)
                }).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    //send request to firebase
                    
                })
                .foregroundColor(.black)
                .background(Color.orange)
                .clipShape(RoundedCorners(tl: 10, tr: 10, bl: 10, br: 10))
            }}
        
    }
}

struct AddTeacher_Previews: PreviewProvider {
    static var previews: some View {
        AddTeacher()
    }
}
