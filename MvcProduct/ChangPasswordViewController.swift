//
//  ChangPasswordViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 26/07/2022.
//

import UIKit
import Alamofire
import RealmSwift
class ChangPasswordViewController: UIViewController {

// MARK:- IBOutlets
    @IBOutlet weak var NewPasswordText: UITextField!
    @IBOutlet weak var OldPassword: UITextField!
    
    var rr = RegisterModule()
    private var GetData = Component.signal.getInfoUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(GetData.data?.id)
        print(GetData.data?.token)

    }
    

    @IBAction func ChangeButton(_ sender: UIButton) {
        
        let old = OldPassword?.text
        let new = NewPasswordText?.text
        print("\(old)")
        print(new!)
        let aa =  GetData.data!.token!

        let header : HTTPHeaders = ["Authorization":"\(aa)","lang":"ar", "Content-Type" : "application/json" ]
        print("///////////")
        
        NetworkFunc.fetchData(url: URLApi.ChangePassword, parameter: ["current_password":old,"new_password":new], methode: .post, encode: JSONEncoding.default, Header: header, responseClass: RegisterModule.self) { response in
            switch response {
            case .success(let users):
                if users?.status == true {
             //     print(users)
                    Component.signal.showCustomeSucessAlert(Message: users?.message ?? "", MyViewController: self)
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

