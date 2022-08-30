//
//  FQSVc.swift
//  MvcProduct
//
//  Created by Mahmoud on 09/08/2022.
//

import UIKit
import Alamofire
class FaqsVc: UIViewController , UITableViewDelegate , UITableViewDataSource {

// MARK:- IBOutlets
    @IBOutlet weak var imageFastsale: UIImageView!
    @IBOutlet weak var baseImage: UIImageView!
    @IBOutlet weak var faqsTableView: UITableView!
    
    var moduleFaqs = FaqsModule()
  
// MARK:- Function
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFastsale.alpha = 0
        SetupVategoryTable()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        Component.signal.animationImageSlidMenu(image: imageFastsale)
        Component.signal.basicAnimations(Image: baseImage)
    }
    
    private func SetupVategoryTable() {
        faqsTableView.dataSource = self
        faqsTableView.delegate = self
        faqsTableView.register(UINib(nibName: "FaqsCell", bundle: nil), forCellReuseIdentifier: "FaqsCell")
        self.navigationController?.navigationBar.isHidden = true
    }
 
    private func getData() {
        DispatchQueue.global().async {[weak self] in
            NetworkFunc.fetchData(url: "\(URLApi.FAQSS)", parameter: nil, methode:.get, encode: URLEncoding.default, Header: [:], responseClass: FaqsModule.self) { (response) in
                switch response {
                case .success(let users):
             //       print(users)
                    if users?.status == true {
                        self?.moduleFaqs = users!
                        DispatchQueue.main.async {[weak self] in
                        self?.faqsTableView.reloadData()
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
    
// MARK:- Action
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
