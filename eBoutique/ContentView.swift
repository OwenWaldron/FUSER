//
//  ContentView.swift
//  eBoutique
//
//  Created by Janvier Rugomoka Zagabe on 2021-05-03.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var articleListener = ArticleListener()
    @State private var showingBasket = false
    @State private var showingAlert = false
    @State private var alertMessage = "Unknown Error"
    
    var categories: [String : [Article]]
    {
        .init(grouping: articleListener.articles,
              by: {$0.category.rawValue})
    }
    
    
    var body: some View {
        NavigationView {
            List(categories.keys.sorted(),id: \String.self){
                key in
                ArticleRow(categoryName: "\(key)", articles: self.categories[key]!)
                    .frame(height:320)
            }
                .navigationBarTitle(Text("FUSER Store"))
                .navigationBarItems(leading:
                Button(action: {
                    if FUser.currentUser() == nil {
                        self.alertMessage = "You are not logged in"
                        self.showingAlert.toggle()
                    }
                    else
                    {
                        FUser.logOutCurrentUser{(error) in
                            if error != nil {
                                self.alertMessage = "Error logging out:" + error!.localizedDescription
                                self.showingAlert.toggle()
                            }
                            else
                            {
                                self.alertMessage = "You have been succesfully logged out"
                                self.showingAlert.toggle()
                            }
                        }
                    }
                }, label: {
                    Text("Log out")
                }), trailing: Button(action: {
                    //code
                    self.showingBasket.toggle()
                   // print("basket")
                }, label: {
                    Image("basket")
                })
                .sheet(isPresented: $showingBasket)
                {
                    if FUser.currentUser() != nil &&
                        FUser.currentUser()!.onBoarding
                    {
                        OrderBasketView()
                    }
                        else if FUser.currentUser() != nil
                    {
                        FinishRegistrationView()
                    }
                        else
                    {
                        LoginView()
                    }
                }
                    
            )
        }//Fin de navigationView
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
