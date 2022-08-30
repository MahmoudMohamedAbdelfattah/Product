//
//  AboutUsViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 07/07/2022.
//

import UIKit
import Alamofire
class AboutUsViewController: UIViewController {

// MARK:- IBOutlets
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var ImageFastSale: UIImageView!
    @IBOutlet weak var baseImage: UIImageView!
    
// MARK:- Function
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageFastSale.alpha = 0
        getInfo()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        Component.signal.animationImageSlidMenu(image: ImageFastSale)
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
                    self.textLbl.text = users?.data?.about
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
    
    @IBAction func faceButton(_ sender: UIButton) {
        if let url = URL(string: "https://www.facebook.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: { (_) in
            })
        }
    }
    @IBAction func twitterButton(_ sender: UIButton) {
        if let url = URL(string: "https://twitter.com/i/flow/login") {
            UIApplication.shared.open(url, options: [:], completionHandler: { (_) in
            })
        }
        
    }
    @IBAction func instagramButton(_ sender: UIButton) {
        if let url = URL(string: "https://www.instagram.com/?hl=en") {
            UIApplication.shared.open(url, options: [:], completionHandler: { (_) in
            })
        }
    }
    @IBAction func contactUsPhoneButton(_ sender: UIButton) {
 
        if let phoneCallURL = URL(string: "tel://\(01026236808)") {
           let application:UIApplication = UIApplication.shared
           if (application.canOpenURL(phoneCallURL)) {
               application.open(phoneCallURL, options: [:], completionHandler: nil)
           }
         }
    }
}
