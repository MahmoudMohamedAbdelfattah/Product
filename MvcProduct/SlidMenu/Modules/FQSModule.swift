//
//  FQSModule.swift
//  MvcProduct
//
//  Created by Mahmoud on 18/08/2022.
//

import Foundation

struct FaqsModule : Codable {
    var status: Bool?
   // let message: nill
    var data: Information?
}
struct Information : Codable {
    var current_page: Int?
    var data: [ALLData]?
    var first_page_url: String?
    var from, last_page: Int?
    var last_page_url: String?
    var path: String?
    var per_page: Int?
    var to, total: Int?
}
struct ALLData : Codable {
    var id: Int?
    var question, answer: String?
}
