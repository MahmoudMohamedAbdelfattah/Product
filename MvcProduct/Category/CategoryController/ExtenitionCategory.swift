//
//  ExtenitionCategory.swift
//  MvcProduct
//
//  Created by Mahmoud on 17/07/2022.
//


import UIKit
import Kingfisher
extension CategoryViewController {
    

// MARK:- Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  moduleCategory.status == true {
            return moduleCategory.data?.data?.count ?? 0
            }
        return 0
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier:"CategoryCell", for: indexPath) as! CategoryCell
       cell.addInfoCell(NameModule: (moduleCategory.data?.data?[indexPath.row]) as! DataInfo )
         let pathImage = moduleCategory.data?.data?[indexPath.row].image ?? ""
             if let UrlImage = URL(string: pathImage) {
                 cell.imageCategoryCell.kf.setImage(with: UrlImage, placeholder: UIImage(named: "placeholder"))
                }
        return cell
}
    
 
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: categoryCollection.frame.width/2, height: categoryCollection.frame.height)
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let storyboard = storyboard {
           let vc = storyboard.instantiateViewController(withIdentifier: "AllCategoryViewController") as! AllCategoryViewController
         //   vc.ID = ModuleCategory.data?.data?[indexPath.row].id ?? 0
            vc.id = moduleCategory.data?.data?[indexPath.row].id ?? 0
            print( moduleCategory.data?.data?[indexPath.row].id )
           self.present(vc, animated: true)
        }
    }
    
}
