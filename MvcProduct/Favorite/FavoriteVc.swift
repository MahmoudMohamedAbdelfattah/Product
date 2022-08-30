//
//  FavoriteVc.swift
//  MvcProduct
//
//  Created by Mahmoud on 05/08/2022.
//

import UIKit
import Alamofire
class FavoriteVc: UIViewController , UITableViewDataSource , UITableViewDelegate {

// MARK:- IBOutlets
    @IBOutlet weak var favoriteTableView: UITableView!
    
// MARK:- Variables
    static var module = ModuleFavoriteData()
    private var getData = Component.signal.getInfoUser()
    private lazy var refresher : UIRefreshControl = {
        let refresher = UIRefreshControl()
       // self.CollectionViewCato.alwaysBounceVertical = true
        self.favoriteTableView.bounces = true
        refresher.addTarget(self, action: #selector(refreche), for: .valueChanged)
        return refresher
    }()
    
// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getInfo()
        print(getData.data?.id)
        favoriteTableView.addSubview(refresher)
    }
    
    
    @objc private func refreche(){
        self.viewDidLoad()
        self.view.setNeedsLayout()
        favoriteTableView.reloadData()
        self.refresher.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getInfo()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getInfo()
    }
    private func setupTableView() {
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        favoriteTableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
    }
 
    private func getInfo() {
        let ApiToken =  getData.data!.token!
        let header : HTTPHeaders = ["Authorization":"\(ApiToken)","lang":"ar", "Content-Type" : "application/json" ]
     
        NetworkFunc.fetchData(url: URLApi.addFavorite, parameter:nil, methode: .get, encode: URLEncoding.default, Header: header, responseClass: ModuleFavoriteData.self) { response in
            switch response {
            case .success(let users):
                if users?.status == true {
             //     print(users)
                    FavoriteVc.module = users!
                    DispatchQueue.main.async {[weak self] in
                    self?.favoriteTableView.reloadData()
                    }
                }
                else
                {
                    Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                }
            case .failure(_):
             //   self.delegat?.endSpinner()
                print("ERROR")
            }
      }
   }
}
