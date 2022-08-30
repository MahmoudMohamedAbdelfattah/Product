//
//  BorderSlidMenuScroll.swift
//  MvcProduct
//
//  Created by Mahmoud on 06/07/2022.
//

import UIKit

class BorderSlidMenuScroll: UIScrollView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
    }

}
