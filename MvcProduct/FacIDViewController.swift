//
//  FacIDViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 30/08/2022.
//

import UIKit
import LocalAuthentication
class FacIDViewController: UIViewController {

    static let signal  = FacIDViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //    authenticate()
        // Do any additional setup after loading the view.
    }
    
    func authenticate() {
        let context = LAContext()
        
        var error:NSError? = nil
        let resone = "evluation for authencation"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: resone) { success, authenticationError in
                
                
                if success {
                    
                    DispatchQueue.main.async {
                        self.alert(with: "Authentication Sussecc")
                    }
             
                    
                }else {
                    
                    print("Authentication Faile")
                    
                }
            }
        } else {
            self.alert(with: "Authentication Not Avilable")
        }
        
    }
    
    func alert(with message : String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(addAction)
        present(alert, animated: true , completion: nil)
    }

    @IBAction func FacButton(_ sender: Any) {
        
        authenticate()
    }
}
