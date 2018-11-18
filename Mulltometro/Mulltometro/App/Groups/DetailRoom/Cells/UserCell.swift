//
//  UserCell.swift
//  Mulltometro
//
//  Created by George Gomes on 17/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    static let identifier: String = "UserCell"

    @IBOutlet weak var lbUserName: UILabel!
    
    var name: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with name: String) {
        lbUserName.text = name
    }
    
}
