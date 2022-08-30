//
//  BorderMainView.swift
//  MvcProduct
//
//  Created by Mahmoud on 06/07/2022.
//

import UIKit

class BorderMainView: UIView {

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
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
    }
}
