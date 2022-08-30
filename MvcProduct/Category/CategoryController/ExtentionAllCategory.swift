//
//  ExtentionAllCategory.swift
//  MvcProduct
//
//  Created by Mahmoud on 20/07/2022.
//

import Foundation
import UIKit
import Kingfisher
extension AllCategoryViewController {

    
// MARK:- Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.categoriesDeatialModule.status == true {
            return (self.categoriesDeatialModule.data?.data!.count)!
        }
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTable.dequeueReusableCell(withIdentifier: "CategooryDeatialCell", for: indexPath) as! CategooryDeatialCell
        cell.addInfoCell(NameModule: categoriesDeatialModule.data?.data![indexPath.row] ?? DataAll())
        let pathImage = categoriesDeatialModule.data?.data?[indexPath.row].image ?? ""
            if let UrlImage = URL(string: pathImage) {
                cell.imageCellDatial.kf.setImage(with: UrlImage, placeholder: UIImage(named: "placeholder"))
               }
        if indexPath.row % 2 == 0 {
            cell.nameLblDeatial.textAlignment = NSTextAlignment.left
        } else  {
            cell.nameLblDeatial.textAlignment = NSTextAlignment.right
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        if let storyboard = storyboard{
           let vc = storyboard.instantiateViewController(withIdentifier: "DeatialAllCategoryViewController") as! DeatialAllCategoryViewController
            vc.module = (categoriesDeatialModule.data?.data?[indexPath.row])!
           self.present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
 
