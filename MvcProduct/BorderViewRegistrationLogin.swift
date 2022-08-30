//
//  TextBorder.swift
//  MvcProduct
//
//  Created by Mahmoud on 26/06/2022.
//

import Foundation
import UIKit
class BorderViewRegistrationLogin: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
        
    }

}
