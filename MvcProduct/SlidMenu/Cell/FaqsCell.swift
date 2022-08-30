//
//  FaqsCell.swift
//  MvcProduct
//
//  Created by Mahmoud on 09/08/2022.
//

import UIKit

class FaqsCell: UITableViewCell {

// MARK:- IBOutlets
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
   
// MARK:- Function
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func addInfoCell (NameModule : ALLData) {
        answerLbl.text = NameModule.answer
        questionLbl.text = NameModule.question
    }
    
}
