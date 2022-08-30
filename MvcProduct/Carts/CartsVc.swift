//
//  CartsVc.swift
//  MvcProduct
//
//  Created by Mahmoud on 07/08/2022.
//

import UIKit
import Alamofire

class CartsVc: UIViewController , UITableViewDataSource , UITableViewDelegate{

// MARK:- IBOutlets
    @IBOutlet weak var cartTableView: UITableView!
    
// MARK:- Variables
    static var module = GetCart()
    var getData = Component.signal.getInfoUser()
    lazy var refresher : UIRefreshControl = {
        let refresher = UIRefreshControl()
       // self.CollectionViewCato.alwaysBounceVertical = true
        self.cartTableView.bounces = true
        refresher.addTarget(self, action: #selector(refreche), for: .valueChanged)
        return refresher
    }()

// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fffffff")
        print(getData.data?.id)
        setupTableView()
        getInfo()
        cartTableView.addSubview(refresher)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getInfo()
    }
   
    @objc private func refreche(){
        self.viewDidLoad()
        self.view.setNeedsLayout()
        cartTableView.reloadData()
        self.refresher.endRefreshing()
    }
    private func setupTableView() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.register(UINib(nibName: "CartsCell", bundle: nil), forCellReuseIdentifier: "CartsCell")
    }
    
    private func getInfo() {
        
        let apiToken =  getData.data!.token!

        let header : HTTPHeaders = ["Authorization":"\(apiToken)","lang":"ar", "Content-Type" : "application/json" ]
        print("///////////")

        NetworkFunc.fetchData(url: URLApi.addCarts, parameter:nil, methode: .get, encode: URLEncoding.default, Header: header, responseClass: GetCart.self) { response in
            switch response {
            case .success(let users):
                if users?.status == true {
                    CartsVc.module = users!
                    DispatchQueue.main.async {[weak self] in
                    self?.cartTableView.reloadData()
                    }
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
