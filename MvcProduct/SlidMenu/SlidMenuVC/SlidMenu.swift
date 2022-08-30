//
//  SlidMenu.swift
//  MvcProduct
//
//  Created by Mahmoud on 06/07/2022.
//

import UIKit
import Alamofire

class SlidMenuView: UIViewController {

    
// MARK:- IBOutlets
    @IBOutlet weak var TrailingLayout: NSLayoutConstraint!
    @IBOutlet weak var TopLayout: NSLayoutConstraint!
    @IBOutlet weak var ScrollSlidMenu: BorderSlidMenuScroll!
    @IBOutlet weak var Imageee: BorderImageSlidMenu!
    @IBOutlet weak var ViewSlidMenuAnimation: GradiantColor!
    
// MARK:- Variables
   private var GetToken =  Component.signal.getInfoUser()
   private var Module = ExiteModule()
    
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollAnimation()
        
        let arr = DataBaseHelper.shareInstance.fetchImage()
        Imageee.image = UIImage(data: arr.last?.img ?? Data())
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice().userInterfaceIdiom == .phone {
            TopLayout.constant = 25
            TrailingLayout.constant = 25
           
        } else {
            TopLayout.constant = 60
            TrailingLayout.constant = 60

        }
    }
 
    private func setUpScrollAnimation() {
        var perspective = CATransform3DIdentity
        perspective.m14 = 0.3 / -700
        self.ScrollSlidMenu.layer.transform = perspective
        let rotate = CABasicAnimation(keyPath: "transform.rotation.x")
        rotate.fromValue = 0
        rotate.byValue = CGFloat.leastNonzeroMagnitude
        rotate.duration = 1
        self.ScrollSlidMenu.layer.add(rotate, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    
// MARK:- Action
    @IBAction func AboutUsButton(_ sender: Any) {
 
        Component.signal.transferPresent(name: "AboutUsViewController", my: self, Storyboard: "All")
    }
    
    @IBAction func TermsConditionButton(_ sender: UIButton) {
    
        Component.signal.transferPresent(name: "Term_ConditionViewController", my: self, Storyboard: "All")
    }
    
    @IBAction func InfoPersonalButt(_ sender: ButtonSlideMenuBorder) {
        
        Component.signal.transferPresent(name: "PersonalInformationViewController", my: self, Storyboard: "All")
    }
    
    
    @IBAction func FaqsButton(_ sender: Any) {
        Component.signal.transferPresent(name: "FaqsVc", my: self, Storyboard: "All")
    }
    @IBAction func ComplaintButton(_ sender: UIButton) {
        Component.signal.transferPresent(name: "AddComplaint", my: self, Storyboard: "All")
    }
    
    @IBAction func SettingButton(_ sender: ButtonSlideMenuBorder) {
        Component.signal.transferPresent(name: "ChangPasswordViewController", my: self, Storyboard: "All")
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
        NetworkFunc.fetchData(url:URLApi.Exite , parameter: ["Authorization":GetToken.data?.token], methode: .post, encode: JSONEncoding.default, Header: [:], responseClass: ExiteModule.self) { response in
            switch response {
            case .success(let users):
                if users?.status == true {
                    Component.signal.showCustomeSucessAlert(Message:  users?.message ?? "", MyViewController: self)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                        Component.signal.transferPresent(name: "LoginViewController", my: self, Storyboard: "Main")
                    }
                }
                else{
                    Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                }
            case .failure(_):
             //   self.delegat?.endSpinner()
                print("ERROR")
            }
        }
     }
 }
