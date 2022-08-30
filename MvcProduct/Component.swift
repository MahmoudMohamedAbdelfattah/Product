//
//  helpFuncition.swift
//  MvcProduct
//
//  Created by Mahmoud on 25/06/2022.
//

import Foundation
import UIKit
import SwiftMessages
class Component {
    

// MARK:- Variables
    
  //  MARK:- Singleton
    static let signal  = Component()
    let shape = CAShapeLayer()
    let trackcolor = CAShapeLayer()
    let gradient = CAGradientLayer()

// MARK:- Functions
    
    // MARK:- Go To Another View "Present"
    func transferPresent(name:String,my:UIViewController ,Storyboard:String ){
           let GoToVc = UIStoryboard(name:Storyboard ,bundle: nil)
           let new = GoToVc.instantiateViewController(withIdentifier: name)
             new.modalPresentationStyle = .fullScreen
           my.present(new, animated: true)
        }
    
    func displayMessage(message: String, messageError: Bool) {
        
        let view = MessageView.viewFromNib(layout: MessageView.Layout.messageView)
        if messageError == true {
            view.configureTheme(.error)
        } else {
            view.configureTheme(.success)
        }
        
        view.iconImageView?.isHidden = true
        view.iconLabel?.isHidden = true
        view.titleLabel?.isHidden = true
        view.bodyLabel?.text = message
        view.titleLabel?.textColor = UIColor.white
        view.bodyLabel?.textColor = UIColor.white
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }

    // MARK:- Go To Another View "Push"
    func transferPush(name:String,my:UIViewController,Storyboard:String){
           let loginVC = UIStoryboard(name:Storyboard ,bundle: nil)
           let new = loginVC.instantiateViewController(withIdentifier: name)
           my.navigationController?.pushViewController(new, animated: true)
           my.navigationController?.navigationBar.isHidden=true
       }
    // MARK:- Appear and disappear basic Image "D20D20"
    func basicAnimationLoaginRegistration(image : UIImageView) {
        UIView.animate(withDuration: 2, delay: 0 ,options: [.repeat, .autoreverse],  animations: {   

               image.alpha = 0

           }, completion: {_ in
 
            })
    }
    // MARK:- Splach Animation Intro
    func animationCircle(view : UIView) {
         let circlePath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5), radius: 140, startAngle: 0, endAngle: .pi * 2, clockwise: true)

         trackcolor.path = circlePath.cgPath
         trackcolor.lineWidth = 6
         trackcolor.strokeColor = UIColor.lightGray.cgColor
         trackcolor.fillColor = UIColor.clear.cgColor
         view.layer.addSublayer(trackcolor)

         shape.path = circlePath.cgPath
         shape.lineWidth = 6
         shape.strokeEnd = 0
         shape.strokeColor = UIColor.white.cgColor
         shape.fillColor = UIColor.clear.cgColor
         view.layer.addSublayer(shape)

         let animation = CABasicAnimation(keyPath: "strokeEnd")
         animation.toValue = 1
         animation.duration = 3.5
         animation.isRemovedOnCompletion = false
         animation.fillMode = .forwards
         shape.add(animation, forKey: "animation")
     }
    
    // MARK:- Splach Animation
    func animationImage(HeightViewAnimation :NSLayoutConstraint , ViewAnimation : UIView , ViewImage : UIView , Image : UIImageView ,view : UIView , GoView : UIViewController ) {
        UIView.animate(withDuration:4, animations: {
           // self?.ImageAnimation.isHidden = true
             HeightViewAnimation.constant += 150
             ViewAnimation.layoutIfNeeded()
        }, completion: { _ in
          
          //  self?.ImageAnimation.isHidden = false
             ViewAnimation.alpha = 0
             ViewImage.isHidden = false
             ViewImage.clipsToBounds = true
            Component.signal.animationCircle(view: view )

      //   self?.AnimationCircle()
            var perspective = CATransform3DIdentity
              perspective.m33 = 1 / -200
           Image.layer.transform = perspective
              let rotate = CABasicAnimation(keyPath: "transform.rotation.y")
              rotate.fromValue = 0
              rotate.byValue = CGFloat.pi * 2
              rotate.duration = 4
              Image.layer.add(rotate, forKey: nil)
      
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.6) {
           // component.Signal.transferPresent(name: "lanuageViewController", my: GoView)
            Component.signal.transferPush(name: "lanuageViewController", my: GoView, Storyboard: "Main")

         }
    }
    
    // MARK:- Layer Image TabBarVC Basice Image
    func basicAnimations(Image : UIImageView) {
        let light = UIColor.black.cgColor
        let alpha = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3).cgColor
         gradient.frame = CGRect(x: -Image.bounds.size.width, y: 0, width: 3 * Image.bounds.size.width, height: Image.bounds.size.height)
         gradient.colors = [alpha, light, alpha]
          gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1,y: 0.5)
             gradient.locations = [0 , 0.5, 1]
          Image.layer.mask = gradient
      
               let animation = CABasicAnimation(keyPath: "locations")
               animation.fromValue = [0.0, 0.1, 0.2]
               animation.toValue = [0.9, 0.9,1.0]
        animation.duration = 1.2
               animation.repeatCount = Float.infinity
               gradient.add(animation, forKey: "shimmer")
    }
    
    // MARK:- Errore
    func showCustomeErroreAlert(Message: String , MyViewController:UIViewController) {
        
           let Vc =  UIStoryboard(name:"Main" ,bundle: nil)
            let NewVC = Vc.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
             NewVC.error = Message
        NewVC.modalTransitionStyle = .crossDissolve
            MyViewController.present(NewVC, animated: true)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in MyViewController.dismiss(animated: true, completion: nil)} )
      
    }
    // MARK:-Success
    func showCustomeSucessAlert(Message: String , MyViewController:UIViewController) {
        
           let Vc =  UIStoryboard(name:"Main" ,bundle: nil)
            let NewVC = Vc.instantiateViewController(withIdentifier: "SuccessAlertViewController") as! SuccessAlertViewController
        NewVC.Success = Message
        NewVC.modalTransitionStyle = .crossDissolve
            MyViewController.present(NewVC, animated: true)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in MyViewController.dismiss(animated: true, completion: nil)} )
    }
    
    // MARK:- Validation
     func isValidAge(TestAge:String)->Bool{
        let age = "[0-9]{2,2}"
        let agetest = NSPredicate(format: "SELF MATCHES %@", age)
        return agetest.evaluate(with: TestAge)
    }
     func isVaildPassword(Testpass:String)->Bool{
         let passreges = "^(?=.*\\d).{6,12}$"
         let passwordtest = NSPredicate(format: "SELF MATCHES %@", passreges)
         return passwordtest.evaluate(with:Testpass)
     }
     func isValidEmail(TestEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: TestEmail)
    }
    
    // MARK:- Save Information Personal After Registration Api In UserDefaults
    func cashInfo(user : RegisterModule){
        do {
     try? UserDefaults(suiteName: "MvcProduct")!.set(object:user, forKey: "ModuleRegister")
        } catch let error{
            print(error)
        }
    }
    
    // MARK:- Get Information Personal UserDefaults
    func getInfoUser() -> RegisterModule {
         do {
      let info =  try? UserDefaults(suiteName: "MvcProduct")!.get(objectType:RegisterModule.self,forKey: "ModuleRegister")
             return info ?? RegisterModule()
         } catch {
             print("error getting xml string: \(error)")
         }
    }
    
    // MARK:- Animation Slid Menu
    func animationImageSlidMenu(image : UIImageView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {

             image.layer.cornerRadius = 20
             image.layer.borderWidth = 2
             image.layer.borderColor = UIColor.red.cgColor
             image.alpha = 1

            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.12, initialSpringVelocity: 0.0, options: .curveEaseOut , animations: {
            image.transform = CGAffineTransform(translationX: 0, y: 10)

   }, completion: nil )
        }
    }
    
    // MARK:- Get ID Product Save in User Defult
    func getIdProductFavorite() -> [Int] {
        let defaults = UserDefaults.standard
        var array = defaults.array(forKey: "IDFavorite")  as? [Int] ?? [Int]()
        defaults.synchronize()
        return array
      

    }
    // MARK:- Get ID Carts Save in User Defult
    func getIdProductCarts() -> [Int] {
        let defaults = UserDefaults.standard
        var array = defaults.array(forKey: "IDCarts")  as? [Int] ?? [Int]()
        defaults.synchronize()
        return array
      

    }
    // MARK:- Delete ID Product Save in User Defult
    func deletAndInsertIdFavorite(IdFavorite : Int) {
        let defaults = UserDefaults.standard
        var array = defaults.array(forKey: "IDFavorite")  as? [Int] ?? [Int]()
    
        if array.contains(IdFavorite) {
            array.remove(at: array.index(of: IdFavorite)!)
        } else {
            array.append(IdFavorite)
        }
        defaults.set(array, forKey: "IDFavorite")
        defaults.synchronize()
    }
    // MARK:- Delete ID Carts Save in User Defult
    func deletAndInsertIdCarts(IdCarts : Int) {
        let defaults = UserDefaults.standard
        var array = defaults.array(forKey: "IDCarts")  as? [Int] ?? [Int]()
    
        if array.contains(IdCarts) {
            array.remove(at: array.index(of: IdCarts)!)
        } else {
            array.append(IdCarts)
        }
        defaults.set(array, forKey: "IDCarts")
        defaults.synchronize()
    }
}

extension String {
        var trimmend : String {
            return self.trimmingCharacters(in: .whitespaces)
            
        }

            
            var isPhoneNumber:Bool{
                do{let detctor=try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
                    let match = detctor.matches(in: self, options: [], range: NSMakeRange(0, self.count))
                    if let res=match.first{return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count && (self.count >= 8 && self.count <= 15)}else{return false}
                }catch{
                    return false}
        }
    }


public extension UserDefaults {
    
    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    func set<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        
        set(jsonData, forKey: forKey)
    }
    
    /// Get Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        return try JSONDecoder().decode(objectType, from: result)
    }
}
