//
//  GetFavoriteModule.swift
//  MvcProduct
//
//  Created by Mahmoud on 06/08/2022.
//

import Foundation

struct ModuleFavoriteData:Codable {
    var status: Bool?
    var message: String?
    var data:allData?
}

struct allData:Codable {
    var currentPage: Int?
    var data: [Datum]?
}
struct Datum:Codable {
    var id: Int?
    var product:product?
}

struct product: Codable {
    var id: Int?
    var price, oldPrice: Double?
    var discount: Int?
    var image: String?
    var name, description: String?
}
