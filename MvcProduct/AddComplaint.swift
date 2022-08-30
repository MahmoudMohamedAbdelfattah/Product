//
//  PrivacyPolicyViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 07/07/2022.
//

import UIKit
import Alamofire
class AddComplaint: UIViewController{

    @IBOutlet weak var ImageFastSale: UIImageView!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var imageCimplaint: UIImageView!
    @IBOutlet weak var complaintTxt: UITextView!
    @IBOutlet weak var emailLbl: UITextField!
    @IBOutlet weak var phoneLbl: UITextField!
    @IBOutlet weak var nameLbl: UITextField!
    
 
   private var info = Component.signal.getInfoUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   Component.signal.animationImageSlidMenu(image: imageCimplaint)
    //    Component.signal.animationImageSlidMenu(image: ImageFastSale)


        personalInfo()
    
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
     //   Component.signal.animationImageSlidMenu(image: imageCimplaint)
        Component.signal.basicAnimations(Image: ImageFastSale)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func personalInfo() {
        self.nameLbl.text = info.data?.name
        self.emailLbl.text = info.data?.email
        self.phoneLbl.text = info.data?.phone
        buttonSubmit.layer.cornerRadius = 10
        buttonSubmit.layer.borderWidth = 2
        buttonSubmit.layer.borderColor = UIColor.white.cgColor
        buttonSubmit.clipsToBounds = true


    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        addComplaint()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
   private func addComplaint() {
        guard let message = complaintTxt?.text , !message.isEmpty else {
             Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل اقتراحك", MyViewController: self)
             return
         }
        let header : HTTPHeaders = ["lang":"ar", "Content-Type" : "application/json" ]
        NetworkFunc.fetchData(url: URLApi.complaints, parameter:["name":info.data?.name ?? "" , "phone": info.data?.phone ?? 0 ,"email":info.data?.email ?? "","message":message ], methode: .post, encode: JSONEncoding.default, Header: header, responseClass: ComplaintModule.self) { response in
            switch response {
            case .success(let users):
                if users?.status == true {
             //     print(users)
                    self.buttonSubmit.backgroundColor = .orange

                    Component.signal.showCustomeSucessAlert(Message: users?.message ?? "", MyViewController: self)
             
                }
                else{
                    
                    Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                    self.buttonSubmit.backgroundColor = .black

                }
            case .failure(_):
             //   self.delegat?.endSpinner()
                print("ERROR")
            }
        }

    }
}



//         "id": 12053

