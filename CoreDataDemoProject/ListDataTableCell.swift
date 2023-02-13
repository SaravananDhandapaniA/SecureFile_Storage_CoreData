//
//  ListDataTableCell.swift
//  CoreDataDemoProject
//
//  Created by Tringapps on 08/02/23.
//

import UIKit

class ListDataTableCell: UITableViewCell {
    
    
    @IBOutlet weak var fileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
