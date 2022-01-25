//
//  ToDoListTableViewCell.swift
//  ToDo
//
//  Created by ELAVARASAN K on 24/01/22.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ vm: ToDoViewModel) {
        self.titleLbl.text = vm.title
        self.descriptionLbl.text = vm.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
