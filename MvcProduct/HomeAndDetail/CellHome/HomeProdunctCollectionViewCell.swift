//
//  HomeProdunctCollectionViewCell.swift
//  MvcProduct
//
//  Created by Mahmoud on 15/07/2022.
//

import UIKit
import Kingfisher
class HomeProdunctCollectionViewCell: UICollectionViewCell {
 
// MARK:- IBOutlets
    @IBOutlet weak var ImageCellCollection: UIImageView!
    
   
// MARK:- Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func AddInfoCelll (image : String) {
        let Path = image
        if let url = URL(string: Path) {
            self.ImageCellCollection.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }
}
