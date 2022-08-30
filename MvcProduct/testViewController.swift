//
//  testViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 01/07/2022.
//

import UIKit

class testViewController: UIViewController {

    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var image: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    override func viewDidLayoutSubviews()  {

//
        if UIDevice().userInterfaceIdiom == .phone {

            height.constant = 200
            self.image.layer.cornerRadius = self.image.bounds.height/2
            self.image.clipsToBounds = true


        } else {
            height.constant = 400
            self.image.layer.cornerRadius = self.image.bounds.height/2
            image.clipsToBounds = true
        }
        

    }
}
    



//            if UIDevice().userInterfaceIdiom == .phone {
//
//                self?.heightImage.constant = 50
//                self?.heightViewImage.constant = 50
//
//                self?.ImageAnimation.layer.cornerRadius = (self?.ImageAnimation.bounds.height)!/2
//                self?.ImageAnimation.clipsToBounds = true
//                self?.setNeedsFocusUpdate()
//                self?.ImageAnimation.layoutIfNeeded()
//                self?.ViewImage.layoutIfNeeded()
//
//
//
//            } else {
//                self?.heightImage.constant = 600
//                self?.heightViewImage.constant = 600
//                self?.ImageAnimation.layer.cornerRadius = (self?.ImageAnimation.bounds.height)!/2
//                self?.ImageAnimation.clipsToBounds = true
//                self?.setNeedsFocusUpdate()
//                self?.ImageAnimation.layoutIfNeeded()
//                self?.ViewImage.layoutIfNeeded()
//
//            }
//
