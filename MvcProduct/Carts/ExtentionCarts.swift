//
//  ExtentionCarts.swift
//  MvcProduct
//
//  Created by Mahmoud on 07/08/2022.
//

import Foundation
import UIKit
import Kingfisher
import Alamofire
extension CartsVc {
    
// MARK:- Functions
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if  CartsVc.module.status == true {
        return CartsVc.module.data?.cart_items?.count ?? 0
         } else { return 0}
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartsCell", for: indexPath) as! CartsCell
    
    cell.setupCell(Module: CartsVc.module.data?.cart_items?[indexPath.row].product ?? CartProducts())
    let pathImage = CartsVc.module.data?.cart_items?[indexPath.row].product?.image ?? ""
        if let UrlImage = URL(string: pathImage) {
            cell.imageCart.kf.setImage(with: UrlImage, placeholder: UIImage(named: "placeholder"))
           }
    print(CartsVc.module.data!.cart_items![indexPath.row].id!)

    return cell
}
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
}
    
func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
         let delete = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] action, view, completionHandler in
             var rr =   CartsVc.module.data!.cart_items!.remove(at: indexPath.row).product?.id
             tableView.deleteRows(at: [indexPath], with: .fade)
             let  ApiToken = getData.data!.token!

             let header : HTTPHeaders = ["Authorization":"\(ApiToken)","lang":"ar", "Content-Type" : "application/json" ]
             NetworkFunc.fetchData(url: URLApi.addCarts, parameter:["product_id":rr], methode: .post, encode: JSONEncoding.default, Header:header, responseClass: moduleFavoriteCarts.self) { response in

                 switch response {
                 case .success(let users):
              //       print(users)
                     if users?.status == true {
                          
                         Component.signal.showCustomeSucessAlert(Message: users?.message ?? "", MyViewController: self)
 
                         Component.signal.deletAndInsertIdCarts(IdCarts: rr!)
                    
                     }
                     else {
                         Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                     }
                 case .failure(let Errore):
                  //   self.delegat?.endSpinner()
                     print("ERROR")
                     Component.signal.showCustomeErroreAlert(Message: (Errore) as! String, MyViewController: self)
                 }
             }
             completionHandler(true)
         }
         return UISwipeActionsConfiguration(actions: [delete])
     }
 }
