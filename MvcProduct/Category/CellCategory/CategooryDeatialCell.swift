//
//  CategooryDeatialCell.swift
//  MvcProduct
//
//  Created by Mahmoud on 19/07/2022.
//

import UIKit

class CategooryDeatialCell: UITableViewCell {

// MARK:- IBOutlets
    @IBOutlet weak var imageCellDatial: UIImageView!
    @IBOutlet weak var nameLblDeatial: UILabel!

// MARK:- Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func addInfoCell (NameModule : DataAll) {
        imageCellDatial.image = UIImage(named: NameModule.image!)
        nameLblDeatial.text = NameModule.name
    }
    
}
