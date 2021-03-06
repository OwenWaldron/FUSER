//
//  LoginView.swift
//  eBoutique
//
//  Created by Janvier Rugomoka Zagabe on 2021-05-23.
//

import SwiftUI
struct LoginView: View {
    @State var showingSignup = false // pour alterner entre sign in et sign up
    @State var showingFinishReg = false
    @Environment(\.presentationMode) var presentationMode
    @State var showingAlert = false
    @State var alertMessage = "Unknown Error"
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    var body: some View {
        ZStack() {
        ContentView.Colors.primary.edgesIgnoringSafeArea(.all)
        VStack {
            Text("Sign In")
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(ContentView.Colors.secondary)
                        .opacity(0.75)
                    ZStack (alignment: .leading) {
                        if email.isEmpty {
                            Text("Enter your email").foregroundColor(ContentView.Colors.tertiary)
                        }
                        TextField("", text: $email)
                    }.foregroundColor(.white)
                    Divider().background(ContentView.Colors.tertiary)
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(ContentView.Colors.secondary)
                        .opacity(0.75)
                    ZStack (alignment: .leading) {
                        if password.isEmpty {
                            Text("Enter your password").foregroundColor(ContentView.Colors.tertiary)
                        }
                        SecureField("", text: $password)
                    }.foregroundColor(.white)
                    Divider().background(ContentView.Colors.tertiary)
                    
                    if showingSignup {
                        Text("Repeat Password")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(ContentView.Colors.secondary)
                            .opacity(0.75)
                        ZStack (alignment: .leading) {
                            if repeatPassword.isEmpty {
                                Text("Repeeat password").foregroundColor(ContentView.Colors.tertiary)
                            }
                            SecureField("", text: $repeatPassword)
                        }.foregroundColor(.white)
                        Divider().background(ContentView.Colors.tertiary)
                    }
                }
                .padding(.bottom, 15)
                .animation(.easeOut(duration: 0.1))
                //Fin du VStack
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.resetPassword()
                    }, label: {
                        Text("Forgot Password?")
                            .foregroundColor(showingSignup ? ContentView.Colors.primary : ContentView.Colors.tertiary)
                    })
                    .disabled(showingSignup)
                }//Fin du HStack
                
            } .padding(.horizontal, 6)
            //Fin du VStack
            Button(action: {
                self.showingSignup ? self.signUpUser() : self.loginUser()
            }, label: {
                Text(showingSignup ? "Sign Up" : "Login")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            }) //Fin du  Button
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 45)
            
            SignUpView(showingSignup: $showingSignup)
        }//Fin du VStack
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showingFinishReg)
        {
            FinishRegistrationView()
        }
        }
    }//Fin du body

    private func loginUser()
    {// ?? compl??ter
        if email != "" && password != "" {
            if true {
                FUser.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                    
                    if error != nil {
                        self.alertMessage = "Error loging in the user: " + error!.localizedDescription
                        self.showingAlert.toggle()
                        return
                    }
                    //permettre d'ouvrir la fen??tre pour finaliser l'enregistrement si ce n'est pas encore fait
                    if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                        self.presentationMode.wrappedValue.dismiss()
                        // fermer la fen??tre qui est en mode pr??sentation
                    } else {
                        self.showingFinishReg.toggle()
                    }
                }
            }
        }
    }
    private func signUpUser()
    {
        if email != "" && password != "" && repeatPassword != "" {
            if password == repeatPassword {
                
                FUser.registerUserWith(email: email, password: password) { (error) in
                    
                    if error != nil {
                        self.alertMessage = "Error registering user: " + error!.localizedDescription
                        self.showingAlert.toggle()
                        return
                    }
                    Thread.sleep(forTimeInterval: 1)
                    self.showingSignup.toggle()
                    self.alertMessage = "User succesfully created, please confirm your email before logging in"
                    self.showingAlert.toggle()
                    //retourner ?? l'application
                    //v??rifier si onBoard a ??t?? fait
                }

                
            } else {
                self.alertMessage = "Passwords do not match"
                self.showingAlert.toggle()
            }
            
            
        } else {
            self.alertMessage = "Email and password must be set"
            self.showingAlert.toggle()
        }
        
        
    }
    private func resetPassword()
    {
        if email != ""
        {
            FUser.resetPassword(email: email)
            {(error) in
                if error != nil
                {
                    self.alertMessage = "Error sending reset password: "+error!.localizedDescription
                    self.showingAlert.toggle()
                    return
                }
                self.alertMessage = "Please check your email"
                self.showingAlert.toggle()
            }
        }
        else
        {
            self.alertMessage = "Email is empty"
            self.showingAlert.toggle()
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SignUpView : View {
    @Binding var showingSignup: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 8) {
                Text(showingSignup ? "Already have an account?" : "Don't have an account?").foregroundColor(.white)
                Button(action: {
                    self.showingSignup.toggle()
                }, label: {
                    Text(showingSignup ? "Login" : "Sign Up")
                })
                    .foregroundColor(.blue)
            }//Fin de HStack
                .padding(.top, 25)
        } //Fin de VStack
    }
}
