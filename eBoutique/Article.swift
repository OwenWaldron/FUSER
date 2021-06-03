
//
//  Article.swift
//  eBoutique
//
//  Created by Janvier Rugomoka Zagabe on 2021-05-03.
//
import Foundation
import SwiftUI
// Catégories
enum Category: String,CaseIterable,Codable,Hashable
{
    case mouse
    case keyboard
    case headphones
}
// caractéristiques de chaque article
struct Article: Identifiable,Hashable
{
    var id: String
    var name: String
    var imageName: String
    var category: Category
    var description: String
    var price: Double
}

//convertir les donnes sous forme de clé-valeur
func articleDictionnaryFrom(article: Article) -> [String : Any] {
    return NSDictionary(objects: [article.id,
                               article.name,
                               article.imageName,
                               article.category.rawValue,
                               article.description,
                               article.price
                                ], forKeys: [kID as NSCopying,
                                             kNAME as NSCopying,
                                             kIMAGENAME as NSCopying,
                                             kCATEGORY as NSCopying,
                                             kDESCRIPTION as NSCopying,
                                             kPRICE as NSCopying
    ]) as! [String : Any]
}


