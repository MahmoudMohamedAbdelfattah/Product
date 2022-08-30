//
//  FavoriteModule.swift
//  MvcProduct
//
//  Created by Mahmoud on 04/08/2022.
//

import Foundation

struct moduleFavoriteCarts: Codable {
    var status: Bool?
    var message: String?
    var data: DataClass?
}
 
struct DataClass: Codable {
    var id: Int?
    var quantity : Int?
    var product: Product?
}
 
struct Product: Codable {
    var id, price, old_price, discount: Int?
    var image: String?
}
