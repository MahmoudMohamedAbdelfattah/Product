//
//  SelectNameLocationVC.swift
//  MvcProduct
//
//  Created by Mahmoud on 01/08/2022.
//

import UIKit

protocol PasseName : AnyObject {
    func NameCity (name:String)
}

class SelectNameLocationVC: UIViewController,UITableViewDataSource,UITableViewDelegate  {

    @IBOutlet weak var SelectTalbleNameLocation: UITableView!
    
    var NameSelct = ["النادي","منزل","العمل"]
    weak var delegate : PasseName?
    var NameLocation : String?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        SetupVategoryTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return NameSelct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectTalbleNameLocation.dequeueReusableCell(withIdentifier: "SelectPlaceTableViewCell", for: indexPath) as! SelectPlaceTableViewCell
        cell.NameLbl.text = NameSelct[indexPath.row]
        return cell
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.NameLocation = NameSelct[indexPath.row]
        self.delegate?.NameCity(name: self.NameLocation ?? "")
        
        dismiss(animated: true, completion: nil)

    }
    
    private func SetupVategoryTable() {
        SelectTalbleNameLocation.dataSource = self
        SelectTalbleNameLocation.delegate = self
        SelectTalbleNameLocation.register(UINib(nibName: "SelectPlaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectPlaceTableViewCell")
     
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}

