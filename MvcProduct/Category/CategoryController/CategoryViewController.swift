//
//  CategoryViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 17/07/2022.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    
// MARK:- IBOutlets
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var baseImage: UIImageView!
    
// MARK:- Variables
     var moduleCategory = categoriesmodule ()
    
    
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionBanner()
        getData()
     //   CategoryCollection.collectionViewLayout = UICollectionViewLayout()


    }
   
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Component.signal.basicAnimations(Image: baseImage)
    }
    
    private func setupCollectionBanner() {
        self.navigationController?.navigationBar.isHidden = true
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection?.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
       }
    
    private func getData() {
        
        DispatchQueue.global().async {[weak self] in
            NetworkFunc.fetchData(url: URLApi.Categories, parameter: nil, methode:.get, encode: URLEncoding.default, Header: [:], responseClass: categoriesmodule.self) { (response) in
                switch response {
                case .success(let users):
             //       print(users)
                    if users?.status == true {
                        self?.moduleCategory = users!
                        DispatchQueue.main.async {[weak self] in
                        self?.categoryCollection.reloadData()
                        }
                    }
                    else {
                    }

                case .failure(_):
                    print("ERROR")
                }
            }
        }
    }
}
