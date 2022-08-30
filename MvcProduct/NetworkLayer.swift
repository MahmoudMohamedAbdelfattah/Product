////
////  NetworkLayer.swift
////  MvcProduct
////
////  Created by Mahmoud on 27/07/2022.
////
//
//import Foundation
//import Alamofire
//import Kingfisher
//import SwiftyJSON
//
//public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
//
//
//    func toJsonData() -> Data {
//        do {
//            return try JSONSerialization.data(withJSONObject: self, options: [])
//        } catch {
//            return Data()
//        }
//    }
//}
//
//class ApiClient : NSObject{
//
//
//    func execute<T>(request: ApiRequest, completionHandler: @escaping (APIResult<ApiResponse<T>>) -> Void) {
//            var urlRequest = URLRequest(url: URL(string: ServiceBase.base.rawValue + request.urlPrefix)!)
//            urlRequest.httpMethod = request.method.rawValue
//            urlRequest.httpBody = request.body?.toJsonData()
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//           urlRequest.addValue(AppManager.userToken ?? "", forHTTPHeaderField: "Authorization")
//            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//                DispatchQueue.main.async {
//                    guard let httpUrlResponse = response as? HTTPURLResponse else {
//                        completionHandler(.failure(NetworkRequestError(error: error! as NSError)))
//                        return
//                    }
//
//                    let successRange = 200...299
//                    if successRange.contains(httpUrlResponse.statusCode) {
//                        do {
//                            let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
//                            completionHandler(.success(response))
//                        } catch { // Parsing Error
//                            completionHandler(.failure(error))
//                        }
//                    } else if httpUrlResponse.statusCode == 401 { // Not Auth
//
//
//                    } else { // Network Error
//                        completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
//                    }
//                }
//            }
//            dataTask.resume()
//        }
//    }
//
//
//enum APIResult<T> {
//    case success(T)
//    case failure(Error)
//
//    public func dematerialize() throws -> T {
//        switch self {
//        case let .success(value):
//            return value
//        case let .failure(error):
//            throw error
//        }
//    }
//}
//
//
//
//struct ApiRequest {
//    var urlPrefix: String
//    var method: HTTPMethod
//    var body: [String: Any]?
//}
//
//
//struct ApiResponse<T: Decodable> {
//    let entity: T
//    let httpUrlResponse: HTTPURLResponse
//    let data: Data?
//
//    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
//        do {
//            self.entity = try JSONDecoder().decode(T.self, from: data ?? Data())
//            self.httpUrlResponse = httpUrlResponse
//            self.data = data
//        } catch {
//          //  throw ApiParseError(data: data, httpUrlResponse: httpUrlResponse, error: error as NSError)
//        }
//    }
//}
//
//
//
//ApiClient().execute(request: ApiRequest(urlPrefix: ServiceBase.repositories.rawValue, method: .get), completionHandler: { (result: APIResult<ApiResponse<T>>) in
//                  switch result {
//                  case let .success(response):
//                      completionHandler(.success(response.entity))
//                  case let .failure(error):
//                      completionHandler(.failure(error))
//                  }
//              })
