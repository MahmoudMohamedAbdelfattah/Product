//
//  SuccessAlertViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 24/07/2022.
//

import UIKit

class SuccessAlertViewController: UIViewController {

// MARK:- IBOutlets
    @IBOutlet weak var imageTrue: UIImageView!
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var successLbl: UILabel!
    @IBOutlet weak var buttonTrue: UIButton!
   
// MARK:- Variable
    var Success = String()
  
// MARK:- Funcition
    override func viewDidLoad() {
        super.viewDidLoad()
        SetuoAlert()
    }
    
    private func SetuoAlert() {
        viewAlert.layer.borderColor = UIColor.white.cgColor
        imageTrue.layer.borderColor = UIColor.white.cgColor
        buttonTrue.layer.cornerRadius = buttonTrue.frame.height / 2
        imageTrue.layer.cornerRadius = imageTrue.frame.height / 2
        viewAlert.layer.borderWidth = 2
        imageTrue.layer.borderWidth = 2
        viewAlert.layer.cornerRadius = 10
        successLbl?.text = Success
    }
    
// MARK:- Acition
    @IBAction func ButtoneTrue(_ sender: UIButton) {
        dismiss(animated: true)
    }
    


}
