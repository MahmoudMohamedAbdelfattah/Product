//
//  HomeDeatialViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 16/07/2022.
//

import UIKit

class HomeDeatialViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
// MARK:- IBOutlets
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var baseImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var collectionDeatailImage: UICollectionView!
    
  
// MARK:- Variables
    var deatialModule = AllProducts()
    private var timer = Timer()
    private var counter = 0

// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProductInfo()
        realoadPageController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

     Component.signal.basicAnimations(Image: baseImage)
        //if collection.tage == 0
        setupCollectionHomeDeatial()
    }
    
   private func setupProductInfo() {
       self.priceLbl?.text = "\(String(describing: deatialModule.price))"
       self.oldPrice?.text = "\(String(describing: deatialModule.old_price))"
       self.discountLbl?.text = "\(String(describing: deatialModule.discount))"
       self.nameLbl?.text = deatialModule.name
       self.descriptionLbl?.text = deatialModule.description
    }
    private func setupCollectionHomeDeatial() {
        self.navigationController?.navigationBar.isHidden = true
        collectionDeatailImage.delegate = self
        collectionDeatailImage.dataSource = self
        collectionDeatailImage.translatesAutoresizingMaskIntoConstraints = false
        collectionDeatailImage?.register(UINib(nibName: "HomeProdunctCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeProdunctCollectionViewCell")
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changAutoCollectionCell), userInfo: nil, repeats: true)
       }
    }
   private func realoadPageController() {
        pageController?.currentPage = 0
        pageController?.numberOfPages = deatialModule.images?.count ?? 0
        pageController?.currentPageIndicatorTintColor = .systemPurple
        pageController?.backgroundColor = .clear
        pageController?.pageIndicatorTintColor = .darkGray
}
    

     
    
     @objc func changAutoCollectionCell ()
     {
         if (deatialModule.images?.count ?? 0) > 0 {
         if counter < deatialModule.images?.count ?? 0   {
             let index = IndexPath.init(item: counter, section: 0)
             self.collectionDeatailImage?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageController?.currentPage = counter
             counter += 1
         } else {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.collectionDeatailImage?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageController?.currentPage = counter
             counter = 1
         }
         }
     }

}
