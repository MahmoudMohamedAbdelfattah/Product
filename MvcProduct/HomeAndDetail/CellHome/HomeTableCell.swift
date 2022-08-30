//
//  HomeTableCell.swift
//  MvcProduct
//
//  Created by Mahmoud on 15/07/2022.
//

import UIKit
import CoreAudio

class HomeTableCell: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

// MARK:- IBOutlets
    @IBOutlet weak var collectionViewImage: UICollectionView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblProductOldPrice: UILabel!
    @IBOutlet weak var lblProductDiscound: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!

// MARK:- Variables
    var arryImage  = [String]()
    
// MARK:- Functions
    override func awakeFromNib() {
        super.awakeFromNib()
     
        collectionViewImage?.register(UINib(nibName: "HomeProdunctCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeProdunctCollectionViewCell")
                collectionViewImage.dataSource = self
                collectionViewImage.delegate = self
               self.collectionViewImage.allowsMultipleSelection = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
    func setup (Module : AllProducts) {
        
        self.lblProductDiscound?.text = "\(Module.discount ?? 0)"
        self.lblProductOldPrice?.text = "\(Module.old_price ?? 0.0)"
        self.lblProductName?.text = Module.name ?? ""
        self.lblProductPrice?.text = "\(Module.price ?? 0)"
        self.arryImage = Module.images ?? []
        collectionViewImage.reloadData()
    }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
          //  return HomeViewController.BannerImage.data?.products?.count ?? 0
           return arryImage.count
    
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             
                
            let cell = collectionViewImage?.dequeueReusableCell(withReuseIdentifier: "HomeProdunctCollectionViewCell", for: indexPath) as!  HomeProdunctCollectionViewCell
            cell.AddInfoCelll(image:arryImage[indexPath.item] )
            return cell
       
        }
            
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            let cell = collectionViewImage?.dequeueReusableCell(withReuseIdentifier: "HomeProdunctCollectionViewCell", for: indexPath) as! HomeProdunctCollectionViewCell
    
            return CGSize(width: cell.ImageCellCollection.frame.width , height:  self.collectionViewImage.frame.height)
        }
}
    

