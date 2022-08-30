//
//  circleViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 09/07/2022.
//

import UIKit

class circleViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var yourrr: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//
    override func viewDidLayoutSubviews()  {

        self.image.layer.cornerRadius = self.image.bounds.height/2
        self.image.clipsToBounds = true

    }

}
