//
//  DeleteProfileView.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/13/21.
//

import SwiftUI
import Firebase

struct PopUpWindow: View {
    var title: String
    var message: String
    var buttonText1: String
    var buttonText2: String
    var horse: Horse
    @Binding var show: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)

                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.white)

                    HStack() {
                        Button(action: {
                            // Dismiss the PopUp
                            deleteProfile(horse: horse)
                            deleteImage(horse: horse)
                            presentationMode.wrappedValue.dismiss()
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            // Dismiss the PopUp
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
            }
        }
    }
    func deleteProfile(horse: Horse) {
        let db = Firestore.firestore()
        db.collection("HorseProfiles").document(horse.id).delete()
        if horse.owner != ""{
            db.collection("RiderProfiles").document(horse.owner).updateData(["Owner": "", "Owner Name": ""])
        }
    }
    func deleteImage(horse: Horse) {
        let storage = Storage.storage()
        // Create a reference to the file to delete
        let desertRef = storage.reference().child("\(horse.id)/\(horse.id)")

        // Delete the file
        desertRef.delete { error in
            if let error = error {
                print("an error has occured - \(error.localizedDescription)")
            } else {
                print("Image deleted successfully!")
          }
        }
    }
}

struct PopUpWindowforRider: View {
    var title: String
    var message: String
    var buttonText1: String
    var buttonText2: String
    var rider: Rider
    @Binding var show: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)

                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.white)

                    HStack() {
                        Button(action: {
                            // Dismiss the PopUp
                            deleteProfile(rider: rider)
                            deleteImage(rider: rider)
                            presentationMode.wrappedValue.dismiss()
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            // Dismiss the PopUp
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
            }
        }
    }
    func deleteProfile(rider: Rider) {
        let db = Firestore.firestore()
        db.collection("RiderProfiles").document(rider.id).delete()
        if rider.horse != ""{
            db.collection("HorseProfiles").document(rider.horse).updateData(["Owner": "", "Owner Name": ""])
        }
        if rider.instructor != ""{
            db.collection("InstructorProfiles").document(rider.instructor).updateData(["Student": "", "Student Name": ""])
        }
    }
    func deleteImage(rider: Rider) {
        let storage = Storage.storage()
        // Create a reference to the file to delete
        let desertRef = storage.reference().child("\(rider.id)/\(rider.id)")

        // Delete the file
        desertRef.delete { error in
            if let error = error {
                print("an error has occured - \(error.localizedDescription)")
            } else {
                print("Image deleted successfully!")
          }
        }
    }
}

struct PopUpWindowforInstructor: View {
    var title: String
    var message: String
    var buttonText1: String
    var buttonText2: String
    var instructor: Instructor
    @Binding var show: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)

                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.white)

                    HStack() {
                        Button(action: {
                            // Dismiss the PopUp
                            deleteProfile(instructor: instructor)
                            deleteImage(instructor: instructor)
                            presentationMode.wrappedValue.dismiss()
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            // Dismiss the PopUp
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
            }
        }
    }
    func deleteProfile(instructor: Instructor) {
        let db = Firestore.firestore()
        db.collection("InstructorProfiles").document(instructor.id).delete()
        if instructor.student != ""{
            db.collection("RiderProfiles").document(instructor.student).updateData(["Instructor": "", "Instructor Name": ""])
        }
    }
    func deleteImage(instructor: Instructor) {
        let storage = Storage.storage()
        // Create a reference to the file to delete
        let desertRef = storage.reference().child("\(instructor.id)/\(instructor.id)")

        // Delete the file
        desertRef.delete { error in
            if let error = error {
                print("an error has occured - \(error.localizedDescription)")
            } else {
                print("Image deleted successfully!")
          }
        }
    }
}
