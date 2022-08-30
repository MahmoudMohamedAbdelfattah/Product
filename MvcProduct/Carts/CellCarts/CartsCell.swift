//
//  CartsCell.swift
//  MvcProduct
//
//  Created by Mahmoud on 07/08/2022.
//

import UIKit

class CartsCell: UITableViewCell {

// MARK:- IBOutlets
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var discountCart: UILabel!
    @IBOutlet weak var priceCart: UILabel!
    @IBOutlet weak var nameCart: UILabel!
    @IBOutlet weak var imageCart: UIImageView!
    
// MARK:- Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell (Module : CartProducts) {
        self.discountCart?.text = "\(Module.discount ?? 0)"
        self.oldPrice?.text = "\(Module.old_price ?? 0)"
        self.nameCart?.text = Module.name ?? ""
        self.priceCart?.text = "\(Module.price ?? 0)"
        self.imageCart.image = UIImage(named: Module.image!)
    }
}
