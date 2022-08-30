//
//  ExtentionLoginSwift.swift
//  MvcProduct
//
//  Created by Mahmoud on 26/06/2022.
//

import Foundation
import UIKit
extension LoginViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0{
            if textField.text!.isEmpty{
                self.imageEmail.image = UIImage(named: "Subtraction 1")
                emailView.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
            }else{
                self.imageEmail.image = UIImage(named: "Subtraction 1-1")
                emailView.layer.borderColor = UIColor.black.cgColor
            }
            
        } else
        {
            if textField.text!.isEmpty {
                passwordView.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
                self.imagePassword.image = UIImage(named: "password")
             
            } else {
                passwordView.layer.borderColor = UIColor.black.cgColor
                self.imagePassword.image = UIImage(named: "password1")
            }
        }
}
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            emailView.layer.borderColor = UIColor.black.cgColor
            self.imageEmail.image = UIImage(named: "Subtraction 1-1")
            
        } else {
            passwordView.layer.borderColor = UIColor.black.cgColor
            self.imagePassword.image = UIImage(named: "password1")
        }
    }
}
