//
//  ModuleContact.swift
//  MvcProduct
//
//  Created by Mahmoud on 09/08/2022.
//

import Foundation

struct ContactsModule: Codable {
    var status: Bool?
    var message: String?
    var data: InfoAll?
}

struct InfoAll: Codable {
    var data: [InfoData]?
}

struct InfoData: Codable {
    var id, type: Int?
    var value: String?
    var image: String?
}
