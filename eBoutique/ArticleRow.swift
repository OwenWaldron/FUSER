//
//  ArticleRow.swift
//  eBoutique
//
//  Created by Janvier Rugomoka Zagabe on 2021-05-11.
//

import SwiftUI

struct ArticleRow: View {
    var categoryName: String
    var articles: [Article]
    var body: some View {
        VStack(alignment: .leading)
        {
            Text(self.categoryName.uppercased())
                .font(.title)
               
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack
                {
                    ForEach(self.articles) {article in
                        ArticleItem(article: article)
                            .frame(width: 300)
                            .padding(.trailing,30)
                        
                    }
                    
                }//Fin Hstack
                
            }//Fin scrollView
            
        }//Fin Vstack
        
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(categoryName: "bague", articles: articleData)
    }
}
