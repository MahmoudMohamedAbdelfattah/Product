//
//  LoginViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 22/06/2022.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
 
// MARK:- IBOutlets
    @IBOutlet weak var stackButtonLogin: UIStackView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var ImageShowPassword: UIButton!
    @IBOutlet weak var imagePassword: UIImageView!
    @IBOutlet weak var imageEmail: UIImageView!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var imageAnimtation: UIImageView!
    @IBOutlet var allText: [UITextField]!
    
// MARK:- Variables
    var moduleLogin = LoginModule()
    
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        stackButtonLogin.isHidden = true
        for text in allText {
            text.delegate = self
        }
        animationButton(stack: stackButtonLogin)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imageAnimtation.alpha = 1
        stackButtonLogin.isHidden = true
        Component.signal.basicAnimationLoaginRegistration(image: imageAnimtation)
        animationButton(stack: stackButtonLogin)

    }
    
    private func animationButton(stack : UIStackView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                   UIView.transition(with: stack, duration: 1.5, options: .transitionCurlDown, animations: {
                    self.stackButtonLogin.isHidden = false
                   }, completion: nil)}
    }

// MARK:- Actions
    @IBAction func showPasswordButton(_ sender: UIButton) {
        passwordText.isSecureTextEntry ?
            (
                passwordText.isSecureTextEntry = false,
                ImageShowPassword.setImage(#imageLiteral(resourceName: "eye"), for: .normal)
            ) : (
                passwordText.isSecureTextEntry = true,
                ImageShowPassword.setImage(#imageLiteral(resourceName: "dashedeye"), for: .normal))
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        Component.signal.transferPush(name: "RegisterViewController", my: self, Storyboard: "Main")
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        guard let email = emailText.text?.trimmend , !email.isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل الايميل", MyViewController: self)
            return }
        guard let password = passwordText.text, !password.isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل الباسورد", MyViewController: self)
            return }
        
        NetworkFunc.fetchData(url: URLApi.login, parameter: ["email" : email,"password" : password], methode:.post, encode: JSONEncoding.default, Header: [:], responseClass: LoginModule.self) { response in
            switch response {
            case .success(let users):
                if users?.status == true {
                    Component.signal.showCustomeSucessAlert(Message:  users?.message ?? "", MyViewController: self)
                  
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                    let loginVC = UIStoryboard(name:"All" ,bundle: nil)
                    let new = loginVC.instantiateViewController(withIdentifier: "TabBarVC")
                    self.navigationController?.pushViewController(new, animated: true)
                    self.navigationController?.navigationBar.isHidden=true
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
