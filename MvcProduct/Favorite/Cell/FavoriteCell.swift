//
//  FavoriteCell.swift
//  MvcProduct
//
//  Created by Mahmoud on 06/08/2022.
//

import UIKit

class FavoriteCell: UITableViewCell {

// MARK:- IBOutlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var oldPriceLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var NameLbl: UILabel!
  
// MARK:- Functions
    override func awakeFromNib() {
        super.awakeFromNib()
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }

    func setupCell (Module : product) {
        self.discountLbl?.text = "\(Module.discount ?? 0)"
        self.oldPriceLbl?.text = "\(Module.oldPrice ?? 0.0)"
        self.NameLbl?.text = Module.name ?? ""
        self.priceLbl?.text = "\(Module.price ?? 0.0)"
        self.productImage.image = UIImage(named: Module.image!)
    }
}
