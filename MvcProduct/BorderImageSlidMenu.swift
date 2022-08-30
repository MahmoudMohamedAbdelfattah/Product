//
//  BorderImageSlidMenu.swift
//  MvcProduct
//
//  Created by Mahmoud on 06/07/2022.
//

import UIKit

class BorderImageSlidMenu: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
    }

}
