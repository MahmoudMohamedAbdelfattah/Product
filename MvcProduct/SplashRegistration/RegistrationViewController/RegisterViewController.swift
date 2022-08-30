//
//  RegisterViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 23/06/2022.
//

import UIKit
import RealmSwift
import CountryPickerView
import Alamofire
class RegisterViewController: UIViewController, CountryPickerViewDelegate , CountryPickerViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
// MARK:- IBOutlets
    @IBOutlet weak var womanLbl: UILabel!
    @IBOutlet weak var manLbl: UILabel!
    
    @IBOutlet weak var womanButton: UIButton!
    @IBOutlet weak var manButton: UIButton!
    
    @IBOutlet weak var imageAnimation: UIImageView!
    @IBOutlet weak var confirmPasswordImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var kindImage: UIImageView!
    @IBOutlet weak var ageImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var confirmPasswordView: BorderViewRegistrationLogin!
    @IBOutlet weak var phoneView: BorderViewRegistrationLogin!
    @IBOutlet weak var passwordView: BorderViewRegistrationLogin!
    @IBOutlet weak var emailView: BorderViewRegistrationLogin!
    @IBOutlet weak var ageView: BorderViewRegistrationLogin!
    @IBOutlet weak var viewName: BorderViewRegistrationLogin!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var passWordText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet var allText: [UITextField]!
    
    @IBOutlet weak var countryView: CountryPickerView!
  
// MARK:- Variables
    var codePhone : String?
    let imagepiker = UIImagePickerController()
    var image : Data?
    var moduleRegister = RegisterModule()
    var personalityType : String?
    var hasKind = true {
        didSet {
            manButton.isSelected = hasKind
            womanButton.isSelected = !hasKind
        }
    }
    
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for text in allText {
            text.delegate = self
        }
              
        countryView.delegate = self
        countryView.dataSource = self
        
        imagepiker.delegate = self
        imagepiker.sourceType = .photoLibrary
        imagepiker.allowsEditing=true
        
        kindImage.layer.cornerRadius = kindImage.frame.height / 2
        codePhone = countryView.selectedCountry.localizedName()
        codePhone = countryView.selectedCountry.name
        let tapgest=UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.chooseimage))
        profileImage.addGestureRecognizer(tapgest)
        profileImage.isUserInteractionEnabled=true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageAnimation.alpha = 1

        Component.signal.basicAnimationLoaginRegistration(image: imageAnimation)
     }

    @objc func chooseimage()  {
        let alertcon=UIAlertController(title: "اختر الصوره", message: "من اي مصدر تريد احضار الصوره", preferredStyle: .actionSheet)
        let camera=UIAlertAction(title: "الكاميرا", style:.default) {[weak self] (ـ) in
            self?.imagepiker.sourceType = .camera
            if self != nil{
            self?.present(self!.imagepiker,animated: true,completion: nil)
            }}
        let photo=UIAlertAction(title: "الصور", style:.default) {[weak self] (ـ) in
            self?.imagepiker.sourceType = .photoLibrary
            if self != nil{
                self?.present(self!.imagepiker,animated: true,completion: nil)
            }}
        let cancel=UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
        alertcon.addAction(cancel)
        alertcon.addAction(camera)
        alertcon.addAction(photo)
        present(alertcon,animated: true,completion: nil)
     }
    
// MARK:- Actions
    @IBAction func RegistrationButton(_ sender: UIButton) {
        
        guard let kindImge = self.image , !kindImge .isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك اختار صوره", MyViewController: self)
            return
        }
//        if image == nil {
//            Component.signal.showCustomeErroreAlert(Message: "من فضلك اختار صوره", MyViewController: self)
//            return
//        }
  
        guard let kind = self.personalityType , !kind .isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك النوع", MyViewController: self)
            return
        }
       guard let name = nameText.text?.trimmend , !name.isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل الاسم", MyViewController: self)
            return
        }
        guard let Email = emailText.text?.trimmend , !Email.isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل الايميل", MyViewController: self)
            return
        }
        if !Component.signal.isValidEmail(TestEmail: Email){
            Component.signal.showCustomeErroreAlert(Message: "الايميل خطا ", MyViewController: self)
            return
        }
        guard let Age = ageText.text?.trimmend , !Age.isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل عمرك", MyViewController: self)
            return
        }
        if !Component.signal.isValidAge(TestAge: Age){
            Component.signal.showCustomeErroreAlert(Message: "ادخل العمر بشكل صحيح", MyViewController: self)
            return
        }
//
        guard let Phone = phoneText.text, !Phone.isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل رقم التلفون", MyViewController: self)
            return
        }
        if !Phone.isPhoneNumber{
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل التلفون بشكل صحيح", MyViewController: self)
            return
        }
        guard let Password = passWordText.text, !Password.isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل الباسورد", MyViewController: self)
            return
        }
        guard let ConfirmPassword = confirmPasswordText.text, !ConfirmPassword.isEmpty else {
            Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل تاكيدالباسورد", MyViewController: self)
            return
        }
        if Password != ConfirmPassword {
            Component.signal.showCustomeErroreAlert(Message: "كلمه المرور وتاكيد كلمه المرور غير متطابقه", MyViewController: self)

        }
        if !Component.signal.isVaildPassword(Testpass: Password){
            Component.signal.showCustomeErroreAlert(Message: "ادخل الباسورد بشكل صحيح", MyViewController: self)
            return
        }

        NetworkFunc.fetchData(url: URLApi.register, parameter: ["name" :name ,"email" :Email ,"password":Password ,"phone":Phone], methode:.post, encode: JSONEncoding.default, Header: [:], responseClass: RegisterModule.self) { (response) in
            switch response {
            case .success(let users):
         //       print(users)
                if users?.status == true {
                   self.moduleRegister = users!

                    Component.signal.showCustomeSucessAlert(Message: self.moduleRegister.message ?? "", MyViewController: self)
                    Component.signal.cashInfo(user: users ?? RegisterModule())

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                        Component.signal.transferPush(name: "AddressViewController", my: self, Storyboard: "Main")
                     }
                }
                else {

                    Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                }

            case .failure(_):
                 print("ERROR")
            }
        }
        
        
//    //   CoreData
//        Info.name = NameText.text  ?? ""
//        Info.age = Int(AgeText.text ?? "") ?? 0
//
//        // Clouser
//        try! self.realm.write {
//            self.realm.add(Info)
//        }

     }
    
    @IBAction func CodePhoneButton(_ sender: UIButton) {
        countryView.showCountriesList(from: self)
        
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        
    }
    @IBAction func ButtonMan(_ sender: UIButton) {
        manButton.setImage(UIImage(named: "circle_checked"), for: .normal)
        womanButton.setImage(UIImage(named: "unchecked_box"), for: .normal)
        kindImage.alpha = 1
        personalityType = manLbl?.text
        manLbl.textColor = .black
        womanLbl.textColor = .secondaryLabel
    }
    
    @IBAction func BackButton(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ButtonWoman(_ sender: UIButton) {
        womanButton.setImage(UIImage(named: "circle_checked"), for: .normal)
        womanLbl.textColor = .black
        manLbl.textColor = .secondaryLabel
        manButton.setImage(UIImage(named: "unchecked_box"), for: .normal)
        kindImage.alpha = 1
        personalityType = womanLbl?.text
     }
}

