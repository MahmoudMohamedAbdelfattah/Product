//
//  Term&ConditionViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 07/07/2022.
//

import UIKit
import Alamofire
class Term_ConditionViewController: UIViewController {

// MARK:- IBOutlets
    @IBOutlet weak var imageFastSale: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var baseImage: UIImageView!
    
// MARK:- Variables
    var Module = ModuleTermsAndCondition()

// MARK:- Function
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        imageFastSale.alpha = 0

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        Component.signal.animationImageSlidMenu(image: imageFastSale)
        Component.signal.basicAnimations(Image: baseImage)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    func getInfo() {
        NetworkFunc.fetchData(url: URLApi.aboutAndTerms, parameter: nil, methode:.get, encode: URLEncoding.default, Header: [:], responseClass: ModuleTermsAndCondition.self) { (response) in
            switch response {
            case .success(let users):
         //       print(users)
                if users?.status == true {
                    self.textView.text = users?.data?.terms
                }
                else {
                    
                }

            case .failure(_):
             //   self.delegat?.endSpinner()
                print("ERROR")
            }
        }
   }
    
// MARK:- Action
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
