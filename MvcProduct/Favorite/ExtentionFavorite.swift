//
//  ExtentionFavorite.swift
//  MvcProduct
//
//  Created by Mahmoud on 06/08/2022.
//

import Foundation
import UIKit
import Kingfisher
extension FavoriteVc {
    
// MARK:- Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  FavoriteVc.module.status == true {
            return FavoriteVc.module.data?.data?.count ?? 0
        } else {  return 0}
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        
        cell.setupCell(Module: FavoriteVc.module.data?.data?[indexPath.row].product ?? product())
        let pathImage = FavoriteVc.module.data?.data?[indexPath.row].product?.image ?? ""
            if let UrlImage = URL(string: pathImage) {
                cell.productImage.kf.setImage(with: UrlImage, placeholder: UIImage(named: "placeholder"))
               }
         return cell
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
