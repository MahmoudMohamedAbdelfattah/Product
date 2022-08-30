//
//  TabBarVC.swift
//  MvcProduct
//
//  Created by Mahmoud on 04/07/2022.
//

import UIKit
import SwiftUI

class TabBarVC: UITabBarController  {
    
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.delegate = self
        ChangeRediusTabbar()
        ChangeUnselectColor()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ChangeLayoutOfTabBar()
    }
    

    fileprivate func ChangeRediusTabbar() {
       // self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 15
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
      
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 6
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOpacity = 3
        
    }

    fileprivate func ChangeUnselectColor() {
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.tintColor = .white
    }
    
    fileprivate func ChangeLayoutOfTabBar() {
        if UIDevice().userInterfaceIdiom == .phone {
            
            var TabFrame = tabBar.frame
            TabFrame.size.height = 100
            TabFrame.origin.y = view.frame.size.height - 100
            tabBar.frame = TabFrame
        } else {
            var TabFrame = tabBar.frame
            TabFrame.size.height = 100
            TabFrame.origin.y = view.frame.size.height - 100
            tabBar.frame = TabFrame
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    
        AnimationWhenSelectItem(item: item)
        HandelAnimationAction(item : item)
    }
    fileprivate func AnimationWhenSelectItem(item : UITabBarItem) {
        
        guard let BarItem = item.value(forKey: "view") as? UIView else {return}
        let time : TimeInterval =  0.3
        let Animation = UIViewPropertyAnimator(duration: time, dampingRatio: 0.9) {
            BarItem.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }
        Animation.addAnimations({
            BarItem.transform = .identity
        }, delayFactor: time)
        Animation.startAnimation()
        
        
    
     
        
        
    }
    
    fileprivate func HandelAnimationAction(item : UITabBarItem) {
        
        if item == (self.tabBar.items)?[0] {
            print("Camba")
        }else if item == (self.tabBar.items)?[1] {
            print("Camba1")
        }
    }
    
}
