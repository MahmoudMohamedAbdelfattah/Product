//
//  GetCartsModule.swift
//  MvcProduct
//
//  Created by Mahmoud on 07/08/2022.
//

import Foundation

struct ModuleCartsData : Codable {
    var status: Bool?
    var message: String?
    var data : AllInfo?
}

struct AllInfo: Codable {
    var cart_items: [CartItem]?
    var sub_total, total: Int?
}

struct CartItem: Codable {
    var id, quantity: Int?
    var product: infoProduct?
}

struct infoProduct: Codable {
    var id, price, old_price, discount: Int?
    var image: String?
    var name, description: String?
    var images: [String]?
    var in_favorites, in_cart: Bool?
}
