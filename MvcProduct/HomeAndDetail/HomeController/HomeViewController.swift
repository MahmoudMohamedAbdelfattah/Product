//
//  HomeViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 05/07/2022.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout, UITableViewDataSource , UITableViewDelegate {
   
 
// MARK:- IBOutlets
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var baseImage: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var tableViewHome: UITableView!
    
// MARK:- Variables
    static var BannerImage = HomeModule()
    static var Module = AllProducts ()
    private var GetData = Component.signal.getInfoUser()
    private  var timer = Timer()
    private var counter = 0
    
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableVuewHome()
        Component.signal.basicAnimations(Image: baseImage)
        SetupCollectionBanner()
        getData()
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

         Component.signal.basicAnimations(Image: baseImage)
  }
    
    
//    override func viewDidLayoutSubviews() {
//      super.viewDidLayoutSubviews()
//      self.BannerCollectionView.collectionViewLayout.invalidateLayout()
//       Component.signal.basicAnimations(Image: BaseImage)
//    }
 
  
    private func setupTableVuewHome() {
         tableViewHome.dataSource = self
         tableViewHome.delegate = self
         tableViewHome.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
    }
    private func getData() {
        NetworkFunc.fetchData(url: URLApi.Home, parameter: nil, methode:.get, encode: URLEncoding.default, Header: [:], responseClass: HomeModule.self) { (response) in
            switch response {
            case .success(let users):
         //       print(users)
                if users?.status == true {
                    HomeViewController.BannerImage = users!
                    self.realoadPageController()
              //      print(users?.status)
                    DispatchQueue.main.async {[weak self] in
                        self?.tableViewHome.reloadData()
                        self?.bannerCollectionView.reloadData()
                    }
                }
                else {
                }

            case .failure(_):
             //   self.delegat?.endSpinner()
                print("ERROR")
            }
        }
    }
    
   private func realoadPageController() {
        pageController?.currentPage = 0
        pageController?.numberOfPages =  HomeViewController.BannerImage.data?.banners?.count ?? 0
        pageController?.currentPageIndicatorTintColor = .systemPurple
        pageController?.backgroundColor = .clear
        pageController?.pageIndicatorTintColor = .white
}
    
    private func SetupCollectionBanner() {
        self.navigationController?.navigationBar.isHidden = true
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        self.bannerCollectionView.layer.masksToBounds = true
        self.bannerCollectionView.clipsToBounds = true
        bannerCollectionView.translatesAutoresizingMaskIntoConstraints = false


        bannerCollectionView?.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changAutoCollectionCell), userInfo: nil, repeats: true)
       }
     
    }
    
    @objc func changAutoCollectionCell ()
    {
        if (HomeViewController.BannerImage.data?.banners?.count ?? 0) > 0 {
        if counter < HomeViewController.BannerImage.data?.banners?.count ?? 0   {
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController?.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController?.currentPage = counter
            counter = 1
        }
        }
    }
   
  

     
    
    


    @IBAction func ButtonSlidMenu(_ sender: UIButton) {
        
        UIView.animate(withDuration: 3) {
            if let storyboard = self.storyboard{
               let vc = storyboard.instantiateViewController(withIdentifier: "SlidMenuView") as! SlidMenuView
                vc.modalPresentationStyle = .custom

               self.present(vc, animated: true)

            }
        }
    }
    
}
