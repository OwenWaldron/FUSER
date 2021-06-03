//
//  ArticleItem.swift
//  eBoutique
//
//  Created by Janvier Rugomoka Zagabe on 2021-05-11.
//

import SwiftUI

struct ArticleItem: View {
    var article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16)
        {
            Image(article.imageName)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 170)
                            .cornerRadius(10)
                            .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 5) {
                            Text(article.name)
                                .foregroundColor(ContentView.Colors.secondary)
                                .font(.headline)
                            Text(article.description)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .frame(height:40)
                        }
        }
        .background(ContentView.Colors.primary)
    }
}
