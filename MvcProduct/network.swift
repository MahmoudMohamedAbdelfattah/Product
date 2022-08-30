//
//  network.swift
//  MvcProduct
//
//  Created by Mahmoud on 10/07/2022.
//

import Foundation
import Alamofire
import Kingfisher
import SwiftyJSON
import SwiftUI
class NetworkFunc : NSObject  {
    
    var Parameter : [String:Any] = [:]
    class func fetchData<T: Decodable>(url: String, parameter : [String:Any]? , methode : HTTPMethod ,encode : ParameterEncoding ,Header : HTTPHeaders, responseClass: T.Type , completion:@escaping (Result<T?, NSError>) -> Void) {

        AF.request(url, method: methode, parameters: parameter,encoding: encode, headers: Header).responseJSON { (response) in

          
                guard let jsonResponse = try? response.result.get() else { return }
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse , options: []) else { return }
                guard let responseObj = try? JSONDecoder().decode(T.self, from: theJSONData) else { return }
      //          print(responseObj)
                completion(.success(responseObj))
       //     print(responseObj)

        }
    }
    

// Func to Register
//class func register (name : String ,email : String , password : String , phone : String , Photo : String, completion:@escaping( _ error : Error? , _ success : Bool , _ message : String?)->Void){
//
//    let url = URLApi.register
//    let parameters : [String : Any] =
//        [
//            "name" : name,
//            "email" : email,
//            "password" : password,
//            "phone": phone,
//            "image" : Photo
//        ]
//    AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
//        .responseJSON { response in
//
//            do {let json = try JSONDecoder().decode(RegisterModule.self, from: response.data!)
//
//                if json.status == true {
//                    if let  api_token = json.data?.token {
//                        print("api_token\(api_token)")
//                        helper.saveApiToken(token: api_token)
//                    }
//                    completion(nil,true,nil)
//                    print(json)
//                }else  {
//                    let Message = try JSONDecoder().decode(MessageMain.self, from: response.data!)
//               //     print(Message)
//                    completion(nil,false,Message.message)
//                }
//            }
//            catch let errore {
//                print("The Errore", errore)
//                completion(errore,false,nil)
//            }
//    }
//}
//
//// Func to Login
//class func Login (email : String , password : String ,completion:@escaping(_ error : Error? ,_ success:Bool,_ login:LoginModule? ,_ message : String?)->Void) {
//
//    let url = URLApi.login
//    let header : HTTPHeaders  = ["lang":"ar","Content-Type":"application/json"]
//    let paramter : [String : Any] = ["email":email,
//                                     "password":password]
//
//    AF.request(url, method: .post, parameters: paramter, encoding: JSONEncoding.default, headers: header)
//        .responseJSON { response in
//
//            do {
//                let data = try JSONDecoder().decode(LoginModule.self, from: response.data!)
//                if data.status == true {
//                    print(data)
//                    let api_token = data.data?.token
//                    helper.saveApiToken(token: api_token ?? "")
//                    completion(nil,true,data,data.message) }
//                    else {
//
//                        let DataErrore = try JSONDecoder().decode(MessageMain.self, from: response.data!)
//                        print(DataErrore)
//                        completion(nil,false,nil,DataErrore.message)
//                    }
//                }
//
//            catch let errore {
//                print(errore)
//                completion(errore,false,nil,nil)
//
//            }
//}
//        }
}
