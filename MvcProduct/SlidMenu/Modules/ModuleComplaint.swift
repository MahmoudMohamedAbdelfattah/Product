//
//  ModuleComplaint.swift
//  MvcProduct
//
//  Created by Mahmoud on 09/08/2022.
//

import Foundation

 
struct ComplaintModule: Codable {
    var status: Bool?
    var message: String?
    var data: All?
}
 
struct All: Codable {
    var name, phone, email, message: String?
    var id: Int?
}
