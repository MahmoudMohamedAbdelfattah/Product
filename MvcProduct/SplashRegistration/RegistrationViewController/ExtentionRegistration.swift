//
//  ExtentionRegistration.swift
//  MvcProduct
//
//  Created by Mahmoud on 26/06/2022.
//

import Foundation
import UIKit
 
extension RegisterViewController  : UITextFieldDelegate {
   

// MARK:- Actions
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0{
            if textField.text!.isEmpty{
                self.nameImage.image = UIImage(named: "Subtraction 3")
                viewName.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
            }else{
                self.nameImage.image = UIImage(named: "Subtraction 3-1")
                viewName.layer.borderColor = UIColor.black.cgColor
            }
        }
        else if textField.tag == 1 {
            if textField.text!.isEmpty {
                phoneView.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
                self.phoneImage.image = UIImage(named: "phone")
            
            } else {
                phoneView.layer.borderColor = UIColor.black.cgColor
                self.phoneImage.image = UIImage(named: "phone-1")
            }
        }

        else if textField.tag == 3 {
            if textField.text!.isEmpty {
                ageView.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
                self.ageImage.image = UIImage(systemName: "40.circle.fill")
                self.ageImage.alpha = 0.6

            } else {
                ageView.layer.borderColor = UIColor.black.cgColor
                self.ageImage.image = UIImage(systemName: "40.circle.fill")
                self.ageImage.alpha = 1
            }
            
        } else if textField.tag == 4 {
            if textField.text!.isEmpty {
                emailView.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
                self.emailImage.image = UIImage(named: "Subtraction 1")
                
            } else {
                emailView.layer.borderColor = UIColor.black.cgColor
                self.emailImage.image = UIImage(named: "Subtraction 1-1")
                
            }
        } else if textField.tag == 5 {
            if textField.text!.isEmpty {
                passwordView.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
                self.passwordImage.image = UIImage(named: "password")
                
            } else {
                passwordView.layer.borderColor = UIColor.black.cgColor
                self.passwordImage.image = UIImage(named: "password1")
                
            }
        }else if textField.tag == 6 {
            if textField.text!.isEmpty {
                confirmPasswordView.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
                self.confirmPasswordImage.image = UIImage(named: "password")
                
            } else {
                confirmPasswordView.layer.borderColor = UIColor.black.cgColor
                self.confirmPasswordImage.image = UIImage(named: "password1")
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField.tag == 0 {
            viewName.layer.borderColor = UIColor.black.cgColor
            self.nameImage.image = UIImage(named: "Subtraction 3-1")
        } else if textField.tag == 1 {
            phoneView.layer.borderColor = UIColor.black.cgColor
            self.phoneImage.image = UIImage(named: "phone-1")
        } else if textField.tag == 2 {

        }else if textField.tag == 3 {
            ageView.layer.borderColor = UIColor.black.cgColor
            self.ageImage.image = UIImage(systemName: "40.circle.fill")
            self.ageImage.alpha = 1
        }else if textField.tag == 4 {
            emailView.layer.borderColor = UIColor.black.cgColor
            self.emailImage.image = UIImage(named: "Subtraction 1-1")
        }else if textField.tag == 5 {
            passwordView.layer.borderColor = UIColor.black.cgColor
            self.passwordImage.image = UIImage(named: "password1")
        }else if textField.tag == 6 {
            confirmPasswordView.layer.borderColor = UIColor.black.cgColor
            self.confirmPasswordImage.image = UIImage(named: "password1")
        }
    }

 
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
        
    }
    
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        {
//      let TheImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//       //  self.image =  TheImg!.jpegData(compressionQuality: 1)!.base64EncodedString()
//        profileImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//            dismiss(animated: true, completion: nil)
            ///
            ///
        let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.image =  userPickedImage?.pngData()
//             profileImage.image = userPickedImage
//
//            if let imageData = profileImage.image?.pngData() {
//            DataBaseHelper.shareInstance.saveImage(data: imageData)
//               }
            
            
            guard let userPickedImage = info[.editedImage] as? UIImage else { return }
          profileImage.image = userPickedImage
            
            if let imageData = profileImage.image?.pngData() {
            DataBaseHelper.shareInstance.saveImage(data: imageData)
               }
            
           picker.dismiss(animated: true)
       
          //  dismiss(animated: true, completion: nil)
          
    }


     func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
}
