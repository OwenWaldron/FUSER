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
    
    // Color rgba constants for styling
    struct Colors {
        static let primary = Color(red: 0.086, green: 0.153, blue: 0.278)
        static let secondary = Color(red: 0.414, green: 0.796, blue: 0.987)
        static let uiprimary = UIColor(red: 0.086, green: 0.153, blue: 0.278, alpha: 1.0)
        static let uitertiary = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
    }
    
    init() {
        //Code pour changer le background du navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.uiprimary
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        //Code pour change le background du list:
        UITableViewCell.appearance().backgroundColor = Colors.uiprimary
        UITableView.appearance().backgroundColor = Colors.uiprimary
        UITableView.appearance().separatorColor = Colors.uitertiary
        
    }
    
    var body: some View {
        NavigationView {
            List(categories.keys.sorted(),id: \String.self){
                key in
                ZStack {
                Colors.primary.edgesIgnoringSafeArea(.all)
                ArticleRow(categoryName: "\(key)", articles: self.categories[key]!)
                    .frame(height:320)
                }
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
