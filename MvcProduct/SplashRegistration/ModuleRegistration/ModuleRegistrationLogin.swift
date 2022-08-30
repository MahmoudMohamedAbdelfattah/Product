//
//  ModuleRegistrationLogin.swift
//  MvcProduct
//
//  Created by Mahmoud on 23/07/2022.
//

import Foundation


struct RegisterModule :Codable{
    
    var status : Bool?
    var message : String?
    var data : DataToken?
}

struct DataToken:Codable{
    var name , phone , email : String?
    var id : Int?
    var image : String?
    var token : String?
}


struct LoginModule:Codable{
    var status:Bool?
    var message :String?
    var data:DataLog?
}
struct DataLog:Codable {
    var id:Int?
    var name:String?
    var email:String?
    var phone:String?
    var image:String?
    var points:Int?
    var credit :Int?
    var token:String?
    
}


struct MessageMain : Decodable {
    var status : Bool?
    var message : String?
    var data : String?
}

