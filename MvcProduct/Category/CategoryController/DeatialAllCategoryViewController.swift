//
//  DeatialAllCategoryViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 20/07/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData
import RealmSwift
class DeatialAllCategoryViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {

// MARK:- IBOutlets
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionImageDeatial: UICollectionView!
   
// MARK:- Variables
    var cellIndex = IndexPath()
    var module = DataAll()
    var addFavoriteID = [DataAll]()
    var isCouponFav = UserDefaults.standard.bool(forKey: "isCouponFav")
    var isChecked : Bool?
    var categoriesDeatialModule = moduleFavoriteCarts()
    private var getData = Component.signal.getInfoUser()
    private var changeButtonFavorite = false
    private var changeButtonCarts = false
    var moduleCarts = ModuleCartsData()
    var iDProductFavorite =  Component.signal.getIdProductFavorite()
    var iDProductCart =  Component.signal.getIdProductCarts()
    var timer = Timer()
    private var counter = 0
    
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
         setupCollectionBanner()
        realoadPageController()
        setupInfoProduct()
        print("..../////")
        print(addFavoriteID)
        print(Component.signal.getIdProductFavorite())
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupButtonFavoriteAndCartImage()
    }
    
    private func setupButtonFavoriteAndCartImage() {
        iDProductFavorite.map {
            if module.id == $0 {
                self.favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                self.changeButtonFavorite = true
                print($0)
            }
        }
        
        iDProductCart.map {
            if module.id == $0 {
                self.cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
                self.changeButtonCarts = true
                print($0)
            }
        }
    }
    private func setupCollectionBanner() {
        self.navigationController?.navigationBar.isHidden = true
        collectionImageDeatial.delegate = self
        collectionImageDeatial.dataSource = self
        collectionImageDeatial?.register(UINib(nibName: "HomeProdunctCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeProdunctCollectionViewCell")
   
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changAutoCollectionCell), userInfo: nil, repeats: true)
       }
    }
 
 
    
     @objc private func changAutoCollectionCell ()
     {
         if (module.images?.count ?? 0) > 0 {
         if counter < module.images?.count ?? 0   {
             let index = IndexPath.init(item: counter, section: 0)
             self.collectionImageDeatial?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageController?.currentPage = counter
             counter += 1
         } else {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.collectionImageDeatial?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageController?.currentPage = counter
             counter = 1
         }
         }
     }
    
  private func realoadPageController() {
        pageController?.currentPage = 0
        pageController?.numberOfPages =  module.images?.count ?? 0
        pageController?.currentPageIndicatorTintColor = .systemPurple
        pageController?.backgroundColor = .clear
        pageController?.pageIndicatorTintColor = .darkGray
    }
    private func setupInfoProduct() {
        self.nameLbl?.text = module.name
        self.priceLbl?.text = "\(String(describing: module.price))"
        self.oldPrice?.text = "\(String(describing: module.old_price))"
        self.discountLbl?.text = "\(String(describing: module.discount))"
        self.descriptionLbl?.text = "\(String(describing: module.description))"
    }
    
// MARK:- Actions
    @IBAction func favoritesButton(_ sender: UIButton) {

        let ApiToken =  getData.data!.token!

        let header : HTTPHeaders = ["Authorization":"\(ApiToken)","lang":"ar", "Content-Type" : "application/json" ]


        changeButtonFavorite = !changeButtonFavorite
        
        if changeButtonFavorite {
         
            self.favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)

            NetworkFunc.fetchData(url: URLApi.addFavorite, parameter: ["product_id":module.id!], methode: .post, encode: JSONEncoding.default, Header:header, responseClass: moduleFavoriteCarts.self) { response in

                switch response {
                case .success(let users):
             //       print(users)
                    if users?.status == true {
                        self.categoriesDeatialModule = users!
                        Component.signal.showCustomeSucessAlert(Message: users?.message ?? "", MyViewController: self)
                        let iDProduct = users!.data?.product?.id
                        Component.signal.deletAndInsertIdFavorite(IdFavorite: iDProduct!)
                    }
                    else {
                        Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                    }
                case .failure(let Errore):
                 //   self.delegat?.endSpinner()
                    print("ERROR")
                    Component.signal.showCustomeErroreAlert(Message: (Errore) as! String, MyViewController: self)
                }
            }
        }
                
    else {
        self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        NetworkFunc.fetchData(url: URLApi.addFavorite, parameter: ["product_id":module.id!], methode: .post, encode: JSONEncoding.default, Header:header, responseClass: moduleFavoriteCarts.self) { response in

            switch response {
            case .success(let users):
         //       print(users)
                if users?.status == true {
                    self.categoriesDeatialModule = users!
                    Component.signal.showCustomeSucessAlert(Message: users?.message ?? "", MyViewController: self)
                    let iDProduct = users!.data?.product?.id
                    Component.signal.deletAndInsertIdFavorite(IdFavorite: iDProduct!)
            }
                else {
                    Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                }
            case .failure(let Errore):
             //   self.delegat?.endSpinner()
                print("ERROR")
                Component.signal.showCustomeErroreAlert(Message: (Errore) as! String, MyViewController: self)
            }
        }
    }
}
    
    @IBAction func cartsButton(_ sender: UIButton) {
        
        let ApiToken =  getData.data!.token!

        let header : HTTPHeaders = ["Authorization":"\(ApiToken)","lang":"ar", "Content-Type" : "application/json" ]


        changeButtonCarts = !changeButtonCarts
        
        if changeButtonCarts {
         
            self.cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)

            NetworkFunc.fetchData(url: URLApi.addCarts, parameter: ["product_id":module.id!], methode: .post, encode: JSONEncoding.default, Header:header, responseClass: moduleFavoriteCarts.self) { response in

                switch response {
                case .success(let users):
             //       print(users)
                    if users?.status == true {
                        self.categoriesDeatialModule = users!
                        Component.signal.showCustomeSucessAlert(Message: users?.message ?? "", MyViewController: self)
                        let iDProduct = users!.data?.product?.id
                        Component.signal.deletAndInsertIdCarts(IdCarts: iDProduct!)
                   
                    }
                    else {
                        Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                    }
                case .failure(let Errore):
                 //   self.delegat?.endSpinner()
                    print("ERROR")
                    Component.signal.showCustomeErroreAlert(Message: (Errore) as! String, MyViewController: self)
                }
            }
        }
                
    else {
        
        self.cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        NetworkFunc.fetchData(url: URLApi.addCarts, parameter: ["product_id":module.id!], methode: .post, encode: JSONEncoding.default, Header:header, responseClass: moduleFavoriteCarts.self) { response in

            switch response {
            case .success(let users):
         //       print(users)
                if users?.status == true {
                    self.categoriesDeatialModule = users!
                    Component.signal.showCustomeSucessAlert(Message: users?.message ?? "", MyViewController: self)
                    let iDProduct = users!.data?.product?.id
                    Component.signal.deletAndInsertIdCarts(IdCarts: iDProduct!)
                 
            }
                else {
                    Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                }
            case .failure(let Errore):
             //   self.delegat?.endSpinner()
                print("ERROR")
                Component.signal.showCustomeErroreAlert(Message: (Errore) as! String, MyViewController: self)
            }
        }
      }
    }
}


