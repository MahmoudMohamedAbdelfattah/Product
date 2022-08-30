//
//  AnimationViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 25/06/2022.
//

import UIKit

class AnimationViewController: UIViewController {
   
    
// MARK:- IBOutlets
    @IBOutlet weak var ViewImage: UIView!
    @IBOutlet weak var ImageAnimation: UIImageView!
    @IBOutlet weak var ViewAnimation: UIView!
    @IBOutlet weak var HeightViewAnimation: NSLayoutConstraint!
  
  
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImage()
        Component.signal.animationImage(HeightViewAnimation: HeightViewAnimation, ViewAnimation: ViewAnimation, ViewImage: ViewImage, Image: ImageAnimation, view: view, GoView: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Component.signal.animationCircle(view: view)
       }
    
    private func  setupImage() {
        ImageAnimation.layer.masksToBounds = false
        ImageAnimation.layer.cornerRadius = ImageAnimation.frame.width/2
        ImageAnimation.clipsToBounds = true
        self.ViewImage.isHidden = true
    }
}
