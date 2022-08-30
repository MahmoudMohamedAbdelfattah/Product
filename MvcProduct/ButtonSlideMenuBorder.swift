//
//  ButtonSlideMenu.swift
//  MvcProduct
//
//  Created by Mahmoud on 06/07/2022.
//

import UIKit

class ButtonSlideMenuBorder: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
    }

}
