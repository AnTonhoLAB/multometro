//
//  ParticipantsGroupCell.swift
//  Mulltometro
//
//  Created by George Gomes on 16/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    static let identifier: String = "HeaderCell"
    
    @IBOutlet weak var lbHeaderTitle: UILabel!
    
    var title: String? 
    var users: [String]?
    var fees: [Fee]?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        if let title = title {
            lbHeaderTitle.text = title
        }
    }
}

