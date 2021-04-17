//
//  NewProfileView.swift
//  TACKtical
//
//
import SwiftUI
import SDWebImageSwiftUI
import Firebase


struct NewProfileView: View {
//    @State private var editProfile = false
//    var horse = Horse(DOB: "2021", height: 16, horseID: 1, name: "Haha", weight: 200)
    var id: String
    
    @ObservedObject private var viewModel = HorseViewModel()
    var colorChoices = ["Bay", "Chestnut", "Gray", "Dun"]
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["10", "11", "12", "13", "14", "15", "16"]
    var feedChoices = ["Pasture Grass", "Hay", "Grains", "Salt & Minerals", "Bran", "Garden Refuse", "Fruit & Veggie"]
    //var horse = viewModel.horses[0]
    //let formatter1 = DateFormatter()
    @State var url = ""
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(){
                VStack {
                    if url != ""{
                        
                        AnimatedImage(url:URL(string: url)!).resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                    }
                    else{
                        
                        Loader()
                    }
                }
                .onAppear() {
                    let storage = Storage.storage().reference()
                    storage.child(id).downloadURL { (url, err) in
                        
                        if err != nil{
                            
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        self.url = "\(url!)"
                    }
                }
                
                //Image("Horse").resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                Text(viewModel.horse.name).fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                NavigationLink(destination: EditProfileView(id: id, horse: viewModel.horse)) {
                    Text("Edit Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Text("Date of Birth: " + date_to_string(d: viewModel.horse.birth)).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Gender: " + genderChoices[viewModel.horse.gender]).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Color: " + colorChoices[viewModel.horse.color]).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Height: " + heightChoices[viewModel.horse.height]).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Owner: " + viewModel.horse.owner).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Arrival Date: " + date_to_string(d: viewModel.horse.arrivalDate)).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Feed: " + feedChoices[viewModel.horse.feed]).font(.system(size:UIScreen.main.bounds.height*0.025))
                }.padding(UIScreen.main.bounds.height*0.005)
            
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Button(action: {
                        print("Going to upcoming Training Rides")
                    }) {
                        Text("Upcoming Training Rides").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                    NavigationLink(destination: RiderView()) {
                        Text("Rider Profiles").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                }.padding(UIScreen.main.bounds.height*0.005)
            }
            .padding(EdgeInsets(top: UIScreen.main.bounds.height*0.05, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Horse Profile", displayMode: .inline)
        }.onAppear() {
            self.viewModel.fetchData(id: id)
        }
    }
    
    func date_to_string(d:Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        return formatter1.string(from: d)
    }
}

struct Loader: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
}

struct NewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NewProfileView(id:"Horse1")
            .preferredColorScheme(.light)
    }
}
