//
//  getCartInfo.swift
//  MvcProduct
//
//  Created by Mahmoud on 07/08/2022.
//

import Foundation

struct GetCart: Codable {
    var status: Bool?
    var message: String?
    var data: Info?
}

struct Info: Codable {
    var cart_items: [AllItem]?
    var sub_total, total: Int?

}

struct AllItem: Codable {
    var id, quantity: Int?
    var product: CartProducts?
}

struct CartProducts: Codable {
    var id, price, old_price, discount: Int?
    var image: String?
    var name, description: String?
    var images: [String]?
    var in_favorites, in_cart: Bool?

 
}
