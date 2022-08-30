//
//  BannerCollectionViewCell.swift
//  MvcProduct
//
//  Created by Mahmoud on 10/07/2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

// MARK:- IBOutlets
    @IBOutlet weak var imageBanner: UIImageView!
  
// MARK:- Functions
    override func awakeFromNib() {
        super.awakeFromNib()

     }

    
    func AddInfoCell (BannerModule : AllBanners) {
        imageBanner.image = UIImage(named: BannerModule.image ?? "")
     }
}
