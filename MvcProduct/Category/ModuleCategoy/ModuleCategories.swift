//
//  ModuleCategories.swift
//  MvcProduct
//
//  Created by Mahmoud on 17/07/2022.
//

import Foundation

struct categoriesmodule : Decodable {
    var status : Bool?
 //   var message : null
    var data : AllData?
}

struct AllData : Decodable {
    var data : [DataInfo]?
    var first_page_url: String?
    var from: Int?
    var last_page: Int?
    var last_page_url: String?
  //  var next_page_ur: null
    var path: String?
    var per_page: Int?
//    var prev_page_url: null
    var to: Int?
    var total: Int?
}

struct DataInfo : Decodable {
    var id: Int?
    var name: String?
    var image: String?
}
