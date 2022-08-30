//
//  PersonalInformationViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 25/07/2022.
//

import UIKit
import Alamofire
class PersonalInformationViewController: UIViewController {

// MARK:- IBOutlets
    @IBOutlet weak var baseImage: UIImageView!
    @IBOutlet weak var imageFastsale: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
// MARK:- Variables
    private var GetData = Component.signal.getInfoUser()
    
// MARK:- Function
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        designView()
        imageFastsale.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        Component.signal.animationImageSlidMenu(image: imageFastsale)
        Component.signal.basicAnimations(Image: baseImage)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    private func getData() {
        let aa =  GetData.data!.token!
        let header : HTTPHeaders = ["Authorization":"\(aa)","lang":"ar", "Content-Type" : "application/json" ]
        print("///////////")
        NetworkFunc.fetchData(url: URLApi.GetInfo, parameter: nil, methode: .get, encode: URLEncoding.default, Header: header, responseClass: RegisterModule.self) { response in
            switch response {
            case .success(let users):
                if users?.status == true {
             //     print(users)
                    self.nameLbl?.text = users?.data!.name!
                    self.phoneLbl?.text = users?.data!.phone!
                    self.emailLbl?.text  = users?.data!.email!
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
    
    private func designView() {
        self.stackView.layer.cornerRadius = 10
        self.stackView.layer.borderWidth = 2
        self.stackView.layer.borderColor = UIColor.white.cgColor
        self.stackView.clipsToBounds = true
    }
    
// MARK:- Action
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
