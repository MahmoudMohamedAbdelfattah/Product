//
//  ModelRelam.swift
//  MvcProduct
//
//  Created by Mahmoud on 23/06/2022.
//
//
import Foundation
import RealmSwift

class PersonalInformation : Object {
    
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var Email = ""
    @objc dynamic var Phone = 0
    @objc dynamic var Password = 0
    @objc dynamic var picture: Data? = nil
}
