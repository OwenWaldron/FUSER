//
//  ArticleDetail.swift
//  eBoutique
//
//  Created by Janvier Rugomoka Zagabe on 2021-05-12.
//

import SwiftUI

struct ArticleDetail: View {
    var article: Article
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: false)
        {
            ZStack(alignment: .bottom)
            {
                Image(article.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                HStack
                {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(article.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }//Fin Vstack
                    .padding(.leading)
                    .padding(.bottom)
                    Spacer()
                    
                }//Fin Hstack
                
            } // fin Zstack
            .listRowInsets(EdgeInsets())
            Text(article.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            HStack {
                Spacer()
                //Button
                OrderButton(article: self.article)
                Spacer()
            }.padding(.top,50)
            
        }// fin scrollview
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(article: articleData.first!)
    }
}

struct OrderButton:  View {
    var article: Article
    var body : some View {
        
        Button(action: {
            print("Add to basket, \(self.article.name)")
        })
        {
            Text("Add to basket")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(15)
        
    }
}
