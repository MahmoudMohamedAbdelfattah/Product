//
//  ExtentionHome.swift
//  MvcProduct
//
//  Created by Mahmoud on 10/07/2022.
//

import UIKit
import Kingfisher
extension HomeViewController {


// MARK:- Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  HomeViewController.BannerImage.status == true {
                return HomeViewController.BannerImage.data!.banners!.count
            }
//            else{
//                return self.ModuleHome.images?.count ?? 0
//
//            }
        return 0 
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier:"BannerCell", for: indexPath) as! BannerCollectionViewCell
            cell.AddInfoCell(BannerModule: (HomeViewController.BannerImage.data?.banners?[indexPath.row]) as!AllBanners)
          //  cell.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let pathImage = HomeViewController.BannerImage.data?.banners?[indexPath.row].image ?? ""
        
                if let UrlImage = URL(string: pathImage) {
                     cell.imageBanner.kf.setImage(with: UrlImage, placeholder: UIImage(named: "placeholder"))

                }
            cell.layer.borderColor = UIColor.blue.cgColor
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius  = 5
        return cell
        } else {return UICollectionViewCell()}
        return UICollectionViewCell()
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

     //   layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
     
 
        return CGSize(width: bannerCollectionView.frame.width , height: self.bannerCollectionView.frame.height)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  HomeViewController.BannerImage.status == true {
            return HomeViewController.BannerImage.data!.products!.count
        } else {  return 0}
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewHome.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
        cell.setup(Module: HomeViewController.BannerImage.data?.products?[indexPath.row] ?? AllProducts())
        
      //  cell.AddInfoCelll(image: (HomeViewController.BannerImage.data!.products![indexPath.row].images))
                             
        return cell
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        if let storyboard = storyboard{
           let vc = storyboard.instantiateViewController(withIdentifier: "HomeDeatialViewController") as! HomeDeatialViewController
            vc.deatialModule = (HomeViewController.BannerImage.data?.products?[indexPath.row])!
           self.present(vc, animated: true)
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageController.currentPage = Int( x / view.frame.width)
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       
        bannerCollectionView?.collectionViewLayout.invalidateLayout();

        coordinator.animate(alongsideTransition: { (_) in
         //   self.collectionViewLayout.invalidateLayout()
            if self.pageController.currentPage ==  0 {
                self.bannerCollectionView.contentOffset = .zero
            }else {
                let indexpath = IndexPath(item: self.pageController.currentPage, section: 0)
                self.bannerCollectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in

        }
    }
}

