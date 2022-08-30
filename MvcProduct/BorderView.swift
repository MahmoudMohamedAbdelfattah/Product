//
//  BorderView.swift
//  MvcProduct
//
//  Created by Mahmoud on 23/06/2022.
//

import Foundation
import UIKit
class BorderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
}
