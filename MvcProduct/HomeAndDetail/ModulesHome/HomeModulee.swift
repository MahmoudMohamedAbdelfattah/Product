//
//  HomeModule.swift
//  MvcProduct
//
//  Created by Mahmoud on 10/07/2022.
//

import Foundation


struct HomeModule : Decodable {
    
    var status : Bool?
    var message : String?
    var data: Alldata?
}

struct Alldata : Decodable {
    
    var banners : [AllBanners]?
    var products: [AllProducts]?
    var ad : String?

}

struct AllBanners : Decodable {
    var id : Int?
    var image:String?
  var category :AllCategoryy?
    
}
struct AllCategoryy: Decodable {
    var id: Int?
    var image: String?
    var name: String?
}
struct AllProducts:Decodable {
    var id: Int?
    var  price : Double?
    var old_price: Double?
    var discount: Int?
    var image: String?
    var name: String?
    var description: String?
    var images: [String]?
    var inFavorites :Bool?
    var inCart: Bool?
}
