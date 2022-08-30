//
//  ExtentionFaqs.swift
//  MvcProduct
//
//  Created by Mahmoud on 18/08/2022.
//

import Foundation
import UIKit
extension FaqsVc {
    
// MARK:- Function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  moduleFaqs.status == true {
            return moduleFaqs.data?.data?.count ?? 0
              }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = faqsTableView.dequeueReusableCell(withIdentifier: "FaqsCell", for: indexPath) as! FaqsCell
           cell.addInfoCell(NameModule: moduleFaqs.data?.data![indexPath.row] ?? ALLData())
 
           if indexPath.row % 2 == 0 {
               cell.questionLbl.textAlignment = NSTextAlignment.left
            } else  {
                cell.answerLbl.textAlignment = NSTextAlignment.right
            }
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
