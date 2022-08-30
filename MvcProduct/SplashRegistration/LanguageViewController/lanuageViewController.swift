//
//  lanuageViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 24/06/2022.
//

import UIKit
 
class lanuageViewController: UIViewController {

// MARK:- IBOutlets
    @IBOutlet weak var imageAnimation: UIImageView!
    @IBOutlet weak var viewButtonLanguage: UIView!

// MARK:- Variables
    let payment = {(view: UIView) in
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.clipsToBounds = true
        view.layer.masksToBounds = true
    }
    
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
         payment(viewButtonLanguage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViewAnimation() 
       // AnimationImage()
        Component.signal.basicAnimationLoaginRegistration(image: imageAnimation)
    }
 
// MARK:- Setup Animation View Button
    private func setupViewAnimation() {
        UIView.animate(withDuration: 1, animations: {  [weak self] in
            var perspective = CATransform3DIdentity
               perspective.m24 = -1 / 900
          self?.viewButtonLanguage.layer.transform = perspective
            let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
            rotate.fromValue = 0
            rotate.byValue = CGFloat.leastNormalMagnitude
            rotate.duration = 1
           self?.viewButtonLanguage.layer.add(rotate, forKey: nil)
            self?.viewButtonLanguage.layoutSubviews()
            
        }, completion: { _ in
          
       })
    }
    
// MARK:- Actions
    @IBAction func arbicButton(_ sender: UIButton) {
       // component.Signal.transferPresent(name: "LoginViewController", my: self)
        Component.signal.transferPush(name: "LoginViewController", my: self, Storyboard: "Main")
    }
    
    @IBAction func englishButton(_ sender: UIButton) {
       // component.Signal.transferPresent(name: "LoginViewController", my: self)
        Component.signal.transferPush(name: "LoginViewController", my: self, Storyboard: "Main")
    }
}

