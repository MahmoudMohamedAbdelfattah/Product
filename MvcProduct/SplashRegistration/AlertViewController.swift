//
//  AlertViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 23/07/2022.
//

import UIKit

class AlertViewController: UIViewController {

// MARK:- IBOutlets
    @IBOutlet weak var buttonError: UIButton!
    @IBOutlet weak var erroreLbl: UILabel!
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var imageErrore: UIImageView!
    
    var error = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewAlerteDesign()
        setupImageDesign()
       
     }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupImageDesign() {
        imageErrore.layer.borderColor = UIColor.white.cgColor
        imageErrore.layer.cornerRadius = imageErrore.frame.height / 2
        imageErrore.layer.borderWidth = 2
        buttonError.layer.cornerRadius = buttonError.frame.height / 2
        erroreLbl?.text = error
    }
    
    private func setupViewAlerteDesign() {
        viewAlert.layer.borderWidth = 2
        viewAlert.layer.cornerRadius = 10
        viewAlert.layer.borderColor = UIColor.white.cgColor

    }
    @IBAction func ErroreButton(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
