//
//  CategoryCell.swift
//  MvcProduct
//
//  Created by Mahmoud on 17/07/2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {

// MARK:- IBOutlets
    @IBOutlet weak var nameLblCategory: UILabel!
    @IBOutlet weak var imageCategoryCell: UIImageView!
 
// MARK:- Functions
    override func awakeFromNib() {
        super.awakeFromNib()
     }
    func addInfoCell (NameModule : DataInfo) {
        imageCategoryCell.image = UIImage(named: NameModule.image!)
        nameLblCategory.text = NameModule.name
    }

}
