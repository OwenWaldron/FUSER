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
        VStack {
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    TextField("Enter your email", text: $email)
                    Divider()
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter your password", text: $password)
                    Divider()
                    
                    if showingSignup {
                        Text("Repeat Password")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                        
                        SecureField("Repeat password", text: $repeatPassword)
                        Divider()
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
                            .foregroundColor(showingSignup ? .white : Color.gray.opacity(0.5))
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
        
    }//Fin du body

    private func loginUser()
    {// à compléter
        if email != "" && password != "" {
            if true {
                FUser.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                    
                    if error != nil {
                        self.alertMessage = "Error loging in the user: " + error!.localizedDescription
                        self.showingAlert.toggle()
                        return
                    }
                    //permettre d'ouvrir la fenêtre pour finaliser l'enregistrement si ce n'est pas encore fait
                    if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                        self.presentationMode.wrappedValue.dismiss()
                        // fermer la fenêtre qui est en mode présentation
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
                    //retourner à l'application
                    //vérifier si onBoard a été fait
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
                Text(showingSignup ? "Already have an account?" : "Don't have an account?")
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
