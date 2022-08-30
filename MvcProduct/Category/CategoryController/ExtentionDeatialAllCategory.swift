//
//  ExtentionDeatialAllCategory.swift
//  MvcProduct
//
//  Created by Mahmoud on 20/07/2022.
//

import Foundation
import UIKit
extension DeatialAllCategoryViewController  {
    
// MARK:- Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return module.images?.count ?? 0
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionImageDeatial.dequeueReusableCell(withReuseIdentifier:"HomeProdunctCollectionViewCell", for: indexPath) as! HomeProdunctCollectionViewCell
        cell.AddInfoCelll(image: module.images?[indexPath.row] ?? "" )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        return CGSize(width: collectionImageDeatial.frame.width , height:  collectionImageDeatial.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageController.currentPage = Int( x / view.frame.width)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       
        collectionImageDeatial?.collectionViewLayout.invalidateLayout();

        coordinator.animate(alongsideTransition: { (_) in
         //   self.collectionViewLayout.invalidateLayout()
            if self.pageController.currentPage ==  0 {
                self.collectionImageDeatial.contentOffset = .zero
            }else {
                let indexpath = IndexPath(item: self.pageController.currentPage, section: 0)
                self.collectionImageDeatial.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            }

        }) { (_) in

        }
    }
    
}
