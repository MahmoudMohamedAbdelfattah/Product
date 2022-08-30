//
//  AllCategory.swift
//  MvcProduct
//
//  Created by Mahmoud on 20/07/2022.
//

import Foundation



struct DeatialCategoriesModule: Decodable  {
    var status: Bool?
    var message:String?
    var data: DeatialData?
}

struct DeatialData: Decodable {
    var currentPage: Int?
    var first_page_url: String?
    var from: Int?
    var last_page : Int?
    var last_page_url: String?
    var path:String?
    var per_page: Int?
    var to: Int?
    var total: Int?
   // var sub_total : Int?
    var data : [DataAll]?
}
struct DataAll :Decodable  {
    
    var id: Int?
    var price: Double?
    var old_price: Double?
    var discount: Int?
    var image: String?
    var name:String?
    var description: String?
    var images: [String]?
//    var in_favorites: Bool?
//    var in_cart: Bool?

}
