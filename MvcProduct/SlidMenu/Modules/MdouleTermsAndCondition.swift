//
//  MdouleTermsAndCondition.swift
//  MvcProduct
//
//  Created by Mahmoud on 08/08/2022.
//

import Foundation

struct ModuleTermsAndCondition: Codable {
    var status: Bool?
    var message: String?
    var data: DataMdoule?
}

struct DataMdoule: Codable {
    let about, terms: String
}
