//
//  AllCategoryViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 20/07/2022.
//

import UIKit
import Alamofire

class AllCategoryViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    
// MARK:- IBOutlets
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var baseImage: UIImageView!
    
// MARK:- Variables
     var categoriesDeatialModule = DeatialCategoriesModule ()
     var id : Int?

    
// MARK:- Functions
   convenience init(id : Int) {
        self.init()
        self.id = id
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVategoryTable()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)

         Component.signal.basicAnimations(Image: baseImage)
     }
 
    private func setupVategoryTable() {
        categoryTable.dataSource = self
        categoryTable.delegate = self
        categoryTable.register(UINib(nibName: "CategooryDeatialCell", bundle: nil), forCellReuseIdentifier: "CategooryDeatialCell")
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func getData() {
        DispatchQueue.global().async {[weak self] in
            NetworkFunc.fetchData(url: "\(URLApi.Categories)/\(self?.id ?? 0)", parameter: nil, methode:.get, encode: URLEncoding.default, Header: [:], responseClass: DeatialCategoriesModule.self) { (response) in
                switch response {
                case .success(let users):
             //       print(users)
                    if users?.status == true {
                        self?.categoriesDeatialModule = users!
                        DispatchQueue.main.async {[weak self] in
                        self?.categoryTable.reloadData()
                        }
                    }
                    else {
                //        print(users?.message)
                    }
                case .failure(_):
                 //   self.delegat?.endSpinner()
                    print("ERROR")
                }
            }
        }
    }

}


