//
//  FinishRegistrationView.swift
//  eBoutique
//
//  Created by Janvier Rugomoka Zagabe on 2021-05-23.
//

import SwiftUI
struct FinishRegistrationView: View {
    @State var name = ""
    @State var surname = ""
    @State var telephone = ""
    @State var address = ""
    @State private var showingAlert = true
    @State private var alertMessage = "Please complete your profile before continuing. Email confirmation must be done before completting this form. If you have not confirmed your email, this form will not be submitted and you will be asked to fill it in again upon confirmation."
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section() {
                
                Text("Finish Registration")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 20)
                
                //To make the placeholder text more visible
                ZStack (alignment: .leading) {
                    if name.isEmpty {
                        Text("Name").foregroundColor(ContentView.Colors.tertiary)
                    }
                    TextField("", text: $name)
                }
                ZStack (alignment: .leading) {
                    if surname.isEmpty {
                        Text("Surname").foregroundColor(ContentView.Colors.tertiary)
                    }
                    TextField("", text: $surname)
                }
                ZStack (alignment: .leading) {
                    if telephone.isEmpty {
                        Text("Telephone").foregroundColor(ContentView.Colors.tertiary)
                    }
                    TextField("", text: $telephone)
                }
                ZStack (alignment: .leading) {
                    if address.isEmpty {
                        Text("Address").foregroundColor(ContentView.Colors.tertiary)
                    }
                    TextField("", text: $address)
                }
            } //Fin de Section
                .foregroundColor(.white)
            Section() {
                Button(action: {
                    self.finishRegistration()
                }, label: {
                    Text("Finish Registration").foregroundColor(ContentView.Colors.secondary)
                })
            }.disabled(!self.fieldsCompleted())
            //Fin de Section
        }//Fin de Form
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }//Fin de Body
    
    private func fieldsCompleted() -> Bool {
        
        return self.name != "" && self.surname != "" && self.telephone != "" && self.address != ""
    }
    private func finishRegistration()
    {
        let fullName = name + " " + surname
        
        updateCurrentUser(withValues: [kFIRSTNAME : name, kLASTNAME : surname, kFULLNAME: fullName, kFULLADDRESS : address, kPHONENUMBER : telephone, kONBOARD : true]) { (error) in

            if error != nil {
                self.alertMessage = "Error updating user: " + error!.localizedDescription
                self.showingAlert.toggle()
                print("Adding error: ", error!.localizedDescription)
                return
            }
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}


struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}
